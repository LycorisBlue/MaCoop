import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:path_provider/path_provider.dart';
import 'package:path/path.dart' as path;
import 'package:hive/hive.dart';
import 'package:tuloss_coo/pages/cooperative/liste.dart';
import 'dart:io';

//import '../../models/coopModel.dart';
import '../../models/Cooperative.dart';
import '../../models/database.dart';



class AddCooperative extends StatefulWidget {
  @override
  _AddCooperativeState createState() => _AddCooperativeState();
}

class _AddCooperativeState extends State<AddCooperative> {
  final _boxCoop = Hive.box("cooperative");
  final TextEditingController _nomController = TextEditingController();
  final TextEditingController _presidentController = TextEditingController();
  final TextEditingController _adgController = TextEditingController();
  final TextEditingController _localisationController = TextEditingController();
  final TextEditingController _telephoneController = TextEditingController();
  DateTime _dateCreation = DateTime(2024, 1, 1);
  File? _imageFile;
  List<String> _sections = [];

  Future<void> _selectImage(ImageSource source) async {
    final pickedFile = await ImagePicker().pickImage(source: source);
    if (pickedFile != null) {
      setState(() {
        _imageFile = File(pickedFile.path);
      });
    }
  }

  void _addSection() {
    setState(() {
      _sections.add('');
    });
  }

  Future<void> _saveFormData() async {
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

    final cooperative = Cooperative(
      nom: _nomController.text,
      president: _presidentController.text,
      adg: _adgController.text,
      localisation: _localisationController.text,
      telephone: _telephoneController.text,
      dateCreation: _dateCreation,
      imagePath: finalImagePath,
      sections: _sections,
    );

    try {
      // Utilisez DatabaseHelper pour insérer le nouveau membre dans la base de données
      final databaseHelper = DatabaseHelper.instance;
      final int id = await databaseHelper.insertCooperative(cooperative);
      print('Membre enregistré avec l\'ID: $id');
      Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => ListeCooperative(),
        ),
      );

    } catch (e) {
      print('Erreur lors de l\'enregistrement du membre: $e');
    }


  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Bienvenue John'),
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
              'Ajouter une coopérative',
              style: TextStyle(
                fontSize: 18.0,
                fontWeight: FontWeight.bold,
              ),
            ),
            SizedBox(height: 16.0),
            TextField(
              controller: _nomController,
              decoration: InputDecoration(
                labelText: 'Nom',
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
                    child: Text('Logo'),
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
              controller: _presidentController,
              decoration: const InputDecoration(
                labelText: 'Président',
                border: OutlineInputBorder(),
              ),
            ),
            const SizedBox(height: 16.0),
            TextField(
              controller: _adgController,
              decoration: const InputDecoration(
                labelText: 'Administrateur de groupes (ADG)',
                border: OutlineInputBorder(),
              ),
            ),
            const SizedBox(height: 16.0),
            TextField(
              controller: _localisationController,
              decoration: const InputDecoration(
                labelText: 'Localisation / Adresse du siège',
                border: OutlineInputBorder(),
              ),
            ),
            const SizedBox(height: 16.0),
            TextField(
              controller: _telephoneController,
              decoration: const InputDecoration(
                labelText: 'Téléphone de la coopérative',
                border: OutlineInputBorder(),
              ),
            ),
            SizedBox(height: 16.0),
            Row(
              children: [
                const Text(
                  'Sections',
                  style: TextStyle(
                    fontSize: 16.0,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                SizedBox(width: 8.0),
                IconButton(
                  onPressed: _addSection,
                  icon: Icon(Icons.add),
                ),
              ],
            ),
            Expanded(
              child: ListView.builder(
                itemCount: _sections.length,
                itemBuilder: (context, index) {
                  return Padding(
                    padding: const EdgeInsets.symmetric(vertical: 8.0),
                    child: TextField(
                      onChanged: (value) {
                        setState(() {
                          _sections[index] = value;
                        });
                      },
                      decoration: InputDecoration(
                        hintText: 'Section ${index + 1}',
                        border: OutlineInputBorder(),
                      ),
                    ),
                  );
                },
              ),
            ),
            SizedBox(height: 16.0),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                ElevatedButton(
                  onPressed: () {
                    _saveFormData();
                  },
                  child: const Text('ENREGISTRER'),
                ),
                ElevatedButton(
                  onPressed: () {
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