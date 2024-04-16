import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:tuloss_coo/models/Formation.dart';
import 'package:tuloss_coo/pages/Home/home.dart';
import 'package:tuloss_coo/pages/formation/liste.dart';

import '../../models/Cooperative.dart';
import '../../models/Membres.dart';
import '../../models/database.dart';

class AddFormation extends StatefulWidget {
  @override
  _AddFormationState createState() => _AddFormationState();
}

// Renommez _FormWidgetState en _AddFormationState
class _AddFormationState extends State<AddFormation> {
  final Box _boxLogin = Hive.box("admins");
  final _titreController = TextEditingController();
  final _formateurController = TextEditingController();
  final _descriptionController = TextEditingController();
  DateTime _datePrevue = DateTime(1900);
  DateTime _dateCreation = DateTime(2024, 1, 1);
  final _lieuController = TextEditingController();

  List<Cooperative> cooperatives = [];
  String? _typeCooperative;
  //List<String> selectedSections = [];
  List<String> memberNames = []; // Liste pour stocker les noms des membres récupérés
  List<String> allSections = []; // Toutes les sections de la coopérative sélectionnée
  Set<String> selectedSections = Set(); // Sections actuellement sélectionnées



  Future<void> _saveFormData() async{
    // Créer un objet Membre avec les données du formulaire
    final formation = Formation(
      titre: _titreController.text,
      formateur: _formateurController.text,
      description: _descriptionController.text,
      datePrevu: _dateCreation,
      lieu: _lieuController.text,
      idCooperative: _typeCooperative ?? cooperatives.first.nom,
      sections: selectedSections.toList()
    );

    try {
      // Utilisez DatabaseHelper pour insérer le nouveau membre dans la base de données
      final databaseHelper = DatabaseHelper.instance;
      final int id = await databaseHelper.insertFormation(formation);
      print('Membre enregistré avec l\'ID: $id');
      Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => FormationListScreen(),
        ),
      );

    }  catch (e) {
      print('Erreur lors de l\'enregistrement du membre: $e');
    }
  }

  @override
  void initState() {
    super.initState();
    loadCooperatives();
  }

  void loadCooperatives() async {
    final List<Cooperative> loadedCooperatives = await DatabaseHelper.instance.cooperatives();
    setState(() {
      cooperatives = loadedCooperatives;
      if (cooperatives.isNotEmpty) {
        _typeCooperative = cooperatives.first.nom; // Sélectionne la première coopérative par défaut
        updateSelectedCooperative(_typeCooperative); // Mettre à jour les sections sélectionnées initialement
      }
    });
  }

  void updateSelectedCooperative(String? coopName) {
    final selectedCoop = cooperatives.firstWhere((coop) => coop.nom == coopName);
    if (selectedCoop != null) {
      allSections = List<String>.from(selectedCoop.sections);
      selectedSections.clear();

    }
    setState(() {});
  }


  Future<void> updateMemberList(List<String> sections) async {
    final List<Membre> members = await DatabaseHelper.instance.getMembersBySections(sections);
    setState(() {
      memberNames = members.map((m) => m.nom).toList(); // Assumer que Membre a un champ nom
      print(memberNames);
    });
  }

  @override
  void dispose() {
    _titreController.dispose();
    _formateurController.dispose();
    _descriptionController.dispose();
    _lieuController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(boxLogin: _boxLogin,),
      body: Padding(
        padding: EdgeInsets.all(16.0),
        child: Form(
          child: Column(
            children: [
              DropdownButtonFormField<String>(
                value: _typeCooperative,
                onChanged: (String? newValue) {
                  setState(() {
                    _typeCooperative = newValue;
                    updateSelectedCooperative(newValue);
                  });
                },
                items: cooperatives.map((Cooperative coop) => DropdownMenuItem<String>(
                  value: coop.nom,
                  child: Text(coop.nom),
                )).toList(),
                decoration: InputDecoration(
                  labelText: 'Cooperative',
                  border: OutlineInputBorder(),
                ),
              ),

              Container(
                height: 250,
                child: ListView(
                  children: allSections.map((section) {
                    return CheckboxListTile(
                      title: Text(section),
                      value: selectedSections.contains(section),
                      onChanged: (bool? value) async {
                        setState(() {

                          if (value == true) {
                            selectedSections.add(section);
                          } else {
                            selectedSections.remove(section);
                          }
                        });
                        await updateMemberList(selectedSections.toList());
                      },
                    );
                  }).toList(),
                ),
              ),
              Row(
                children: [
                  Expanded(
                    child: TextFormField(
                      controller: _titreController,
                      decoration: InputDecoration(
                        labelText: "Titre",
                        border: OutlineInputBorder(),
                      ),
                    ),
                  ),
                  SizedBox(width: 10),
                  Expanded(
                    child: TextFormField(
                      controller: _formateurController,
                      decoration: InputDecoration(
                        labelText: "Formateur",
                        border: OutlineInputBorder(),
                      ),
                    ),
                  ),
                ],
              ),
              SizedBox(height: 16,),
              TextFormField(
                controller: _descriptionController,
                decoration: InputDecoration(
                  labelText: "Description et objectifs",
                  border: OutlineInputBorder(),
                ),
                maxLines: 3,
              ),
              SizedBox(height: 16,),
              Row(
                children: [
                  Expanded(
                    child: InputDecorator(
                      decoration: const InputDecoration(
                        labelText: 'Date de création',
                        border: OutlineInputBorder(),
                      ),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text('${_dateCreation.day}/${_dateCreation.month}/${_dateCreation.year}'),
                          Icon(Icons.calendar_today),
                        ],
                      ),
                    ),
                  ),
                  SizedBox(width: 16.0),
                  Expanded(
                    child: TextFormField(
                      controller: _lieuController,
                      decoration: InputDecoration(
                        labelText: "Lieu",
                        border: OutlineInputBorder(),
                      ),
                    ),
                  ),
                ],
              ),
              SizedBox(height: 16.0),
              Expanded(
                child: ListView(
                  children: memberNames.map((name) => ListTile(
                    title: Text(name),
                  )).toList(),
                ),
              ),
              SizedBox(height: 16.0),
              Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  ElevatedButton(
                    onPressed: () {
                      // Traiter les données du formulaire ici
                      print("Titre: ${_titreController.text}");
                      print("Formateur: ${_formateurController.text}");
                      print("Description: ${_descriptionController.text}");
                      print("Date prévue: $_datePrevue");
                      print("Lieu: ${_lieuController.text}");
                      _saveFormData();
                    },
                    child: Text("ENREGISTRER"),
                  ),
                  SizedBox(width: 16.0),
                  ElevatedButton(
                    onPressed: () {
                      // Annuler le formulaire ici
                    },
                    child: Text("ANNULER"),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }

}