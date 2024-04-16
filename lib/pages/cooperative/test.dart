import 'package:flutter/material.dart';
import '../../models/Cooperative.dart';
import '../../models/database.dart'; // Assurez-vous que ces chemins sont corrects

class SelectCooperativePage extends StatefulWidget {
  @override
  _SelectCooperativePageState createState() => _SelectCooperativePageState();
}

class _SelectCooperativePageState extends State<SelectCooperativePage> {
  List<Cooperative> cooperatives = [];
  String? _typeCooperative;
  List<String> selectedSections = [];

  @override
  void initState() {
    super.initState();
    loadCooperatives();
  }

  void loadCooperatives() async {
    final List<Cooperative> loadedCooperatives = await DatabaseHelper.instance.cooperatives(); // Assurez-vous que la méthode 'cooperatives' est définie et renvoie les données attendues
    setState(() {
      cooperatives = loadedCooperatives;
      if (cooperatives.isNotEmpty) {
        _typeCooperative = cooperatives.first.nom; // Sélectionne la première coopérative par défaut
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Sélectionnez votre coopérative')),
      body: Column(
        children: [
          DropdownButtonFormField<String>(
              value: _typeCooperative,
              onChanged: (String? newValue) {
                setState(() {
                  _typeCooperative = newValue;
                  selectedSections.clear(); // Efface les sélections précédentes
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

          Expanded(
            child: ListView(
              children: selectedSections.map((section) {
                return CheckboxListTile(
                  title: Text(section),
                  value: selectedSections.contains(section),
                  onChanged: (bool? value) {
                    setState(() {
                      if (value == true) {
                        selectedSections.add(section);
                      } else {
                        selectedSections.remove(section);
                      }
                    });
                  },
                );
              }).toList(),
            ),
          ),
          ElevatedButton(
            onPressed: () {
              print('Sections sélectionnées: $selectedSections');
            },
            child: Text('Continuer'),
          ),
        ],
      ),
    );
  }

  void updateSelectedCooperative(String? coopName) {
    final selectedCoop = cooperatives.firstWhere((coop) => coop.nom == coopName);
    if (selectedCoop != null) {
      selectedSections = List<String>.from(selectedCoop.sections);
    }
  }
}
