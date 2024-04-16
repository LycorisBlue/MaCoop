import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:path_provider/path_provider.dart';
import 'package:path/path.dart' as path;
import 'package:hive/hive.dart';
import 'package:sqflite/sqflite.dart';
import 'package:tuloss_coo/pages/cooperative/copy.dart';
import 'package:tuloss_coo/pages/membre/liste.dart';
import 'dart:io';

import '../../models/Membres.dart';
import '../../models/coopModel.dart';
import '../../models/database.dart';



class AddMember extends StatefulWidget {
  @override
  _AddMemberState createState() => _AddMemberState();
}

class _AddMemberState extends State<AddMember> {
  final _boxCoop = Hive.box("cooperative");
  final TextEditingController _nomController = TextEditingController();
  final TextEditingController _prenomController = TextEditingController();
  final TextEditingController _adresseController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _telephoneController = TextEditingController();
  String _typeCooperative = 'SAO';
  String _typeSection = 's1';
  String _typeUtilisateur = 'Membre';

  DateTime _dateCreation = DateTime(2000, 1, 1);
  File? _imageFile;

  Future<void> _selectImage(ImageSource source) async {
    final pickedFile = await ImagePicker().pickImage(source: source);
    if (pickedFile != null) {
      setState(() {
        _imageFile = File(pickedFile.path);
      });
    }
  }

  Future<void> enregistrerMembre() async {
    print("Let's go");
    String finalImagePath = '';

    if (_imageFile != null) {
      final Directory appDocDir = await getApplicationDocumentsDirectory();
      final Directory coopDir = Directory('${appDocDir.path}/coop');
      if (!await coopDir.exists()) {
        await coopDir.create(recursive: true);
      }
      final String newPath = path.join(coopDir.path, path.basename(_imageFile!.path));
      final File newImage = await _imageFile!.copy(newPath);
      finalImagePath = newImage.path;
    }
    print(finalImagePath);


    // Créer un objet Membre avec les données du formulaire
    final membre = Membre(
      idCooperative: _typeCooperative,
      idSection: _typeSection,
      idType: _typeUtilisateur,
      nom: _nomController.text,
      prenom: _prenomController.text,
      telephone: _telephoneController.text,
      adresse: _adresseController.text,
      email: _emailController.text,
      dateOfbirth: "$_dateCreation",
      picture: finalImagePath,
    );

    try {
      // Utilisez DatabaseHelper pour insérer le nouveau membre dans la base de données
      final databaseHelper = DatabaseHelper.instance;
      final int id = await databaseHelper.insertMember(membre);
      print('Membre enregistré avec l\'ID: $id');
      Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => MembresGridPage(),
        ),
      );

    } catch (e) {
      print('Erreur lors de l\'enregistrement du membre: $e');
    }
  }

  Future<void> supprimerLaBaseDeDonnees() async {
    // Obtenez le chemin du répertoire des bases de données
    var databasesPath = await getDatabasesPath();
    // Joignez le nom de votre base de données pour obtenir le chemin complet
    String path = "$databasesPath/MaCoop.db";

    // Supprimez la base de données
    await deleteDatabase(path);
    print("La base de données a été supprimée.");
  }




  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Bienvenue Lycoris'),
        actions: [
          IconButton(
            icon: Icon(Icons.home),
            onPressed: () {
              // Action pour l'icône Accueil
            },
          ),
          IconButton(
            icon: Icon(Icons.exit_to_app),
            onPressed: () {
              // Action pour l'icône Quitter
            },
          ),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Ajouter un membre',
              style: TextStyle(
                fontSize: 18.0,
                fontWeight: FontWeight.bold,
              ),
            ),
            SizedBox(height: 16,),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Expanded(
                  child: DropdownButtonFormField<String>(
                    value: _typeCooperative,
                    onChanged: (value) {
                      setState(() {
                        _typeCooperative = value!;
                      });
                    },
                    items: ['Solo leveling', 'SAO']
                        .map((value) => DropdownMenuItem<String>(
                      value: value,
                      child: Text(value),
                    ))
                        .toList(),
                    decoration: InputDecoration(
                      labelText: 'Cooperative',
                      border: OutlineInputBorder(),
                    ),
                  ),
                ),
                SizedBox(width: 10,),
                Expanded(
                  child: DropdownButtonFormField<String>(
                    value: _typeSection,
                    onChanged: (value) {
                      setState(() {
                        _typeSection = value!;
                      });
                    },
                    items: ['s1', 's2', 's3']
                        .map((value) => DropdownMenuItem<String>(
                      value: value,
                      child: Text(value),
                    ))
                        .toList(),
                    decoration: InputDecoration(
                      labelText: 'Section',
                      border: OutlineInputBorder(),
                    ),
                  ),
                ),
                SizedBox(width: 10,),
                Expanded(
                  child: DropdownButtonFormField<String>(
                    value: _typeUtilisateur,
                    onChanged: (value) {
                      setState(() {
                        _typeUtilisateur = value!;
                      });
                    },
                    items: ['Membre', 'Administrateur', 'Gestionnaire']
                        .map((value) => DropdownMenuItem<String>(
                      value: value,
                      child: Text(value),
                    ))
                        .toList(),
                    decoration: InputDecoration(
                      labelText: 'Type de membre',
                      border: OutlineInputBorder(),
                    ),
                  ),
                ),

              ],
            ),
            SizedBox(height: 16.0),
            TextField(
              controller: _nomController,
              decoration: InputDecoration(
                labelText: 'Nom',
                border: OutlineInputBorder(),
              ),
            ),
            SizedBox(height: 16,),
            TextField(
              controller: _prenomController,
              decoration: InputDecoration(
                labelText: 'prenom',
                border: OutlineInputBorder(),
              ),
            ),
            SizedBox(height: 16.0),
            Row(
              children: [
                Expanded(
                  child: InkWell(
                    onTap: () {
                      showDatePicker(
                        context: context,
                        initialDate: _dateCreation,
                        firstDate: DateTime(1900),
                        lastDate: DateTime.now(),
                      ).then((selectedDate) {
                        if (selectedDate != null) {
                          setState(() {
                            _dateCreation = selectedDate;
                          });
                        }
                      });
                    },
                    child: InputDecorator(
                      decoration: const InputDecoration(
                        labelText: 'Date de naissance',
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
                ),
                SizedBox(width: 16.0),
                Container(
                  width: 100.0,
                  height: 100.0,
                  decoration: BoxDecoration(
                    border: Border.all(color: Colors.grey),
                  ),
                  child: _imageFile == null
                      ? const Center(
                    child: Text('Photo'),
                  )
                      : Image.file(
                    _imageFile!,
                    fit: BoxFit.cover,
                  ),
                ),
                SizedBox(width: 16.0),
                Column(
                  children: [
                    ElevatedButton(
                      onPressed: () {
                        _selectImage(ImageSource.gallery);
                      },
                      child: Text('Galerie'),
                    ),
                    SizedBox(height: 8.0),
                    ElevatedButton(
                      onPressed: () {
                        _selectImage(ImageSource.camera);
                      },
                      child: Text('Caméra'),
                    ),
                  ],
                ),
              ],
            ),
            const SizedBox(height: 16.0),
            TextField(
              controller: _telephoneController,
              keyboardType: TextInputType.phone,
              decoration: const InputDecoration(
                labelText: 'Télephone',
                border: OutlineInputBorder(),
              ),
            ),
            const SizedBox(height: 16.0),
            TextField(
              controller: _adresseController,
              decoration: const InputDecoration(
                labelText: 'Adresse',
                border: OutlineInputBorder(),
              ),
            ),
            const SizedBox(height: 16.0),
            TextField(
              controller: _emailController,
              decoration: const InputDecoration(
                labelText: 'Adresse email',
                border: OutlineInputBorder(),
              ),
            ),
            SizedBox(height: 16.0),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                ElevatedButton(
                  onPressed: () {
                    enregistrerMembre();
                  },
                  child: const Text('ENREGISTRER'),
                ),
                ElevatedButton(
                  onPressed: () {
                    supprimerLaBaseDeDonnees();
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => ListeCooperative(),
                      ),
                    );
                  },
                  child: const Text('ANNULER'),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}