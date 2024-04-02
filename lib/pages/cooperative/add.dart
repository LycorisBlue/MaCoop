import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'dart:io';

class AddCooperativeWidget extends StatefulWidget {
  @override
  _AddCooperativeWidgetState createState() => _AddCooperativeWidgetState();
}

class _AddCooperativeWidgetState extends State<AddCooperativeWidget> {
  final TextEditingController _nomController = TextEditingController();
  final TextEditingController _presidentController = TextEditingController();
  final TextEditingController _adgController = TextEditingController();
  final TextEditingController _localisationController = TextEditingController();
  final TextEditingController _telephoneController = TextEditingController();
  DateTime _dateCreation = DateTime(1900, 1, 1);
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
                      decoration: InputDecoration(
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
                      ? Center(
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
            SizedBox(height: 16.0),
            TextField(
              controller: _presidentController,
              decoration: InputDecoration(
                labelText: 'Président',
                border: OutlineInputBorder(),
              ),
            ),
            SizedBox(height: 16.0),
            TextField(
              controller: _adgController,
              decoration: InputDecoration(
                labelText: 'Administrateur de groupes (ADG)',
                border: OutlineInputBorder(),
              ),
            ),
            SizedBox(height: 16.0),
            TextField(
              controller: _localisationController,
              decoration: InputDecoration(
                labelText: 'Localisation / Adresse du siège',
                border: OutlineInputBorder(),
              ),
            ),
            SizedBox(height: 16.0),
            TextField(
              controller: _telephoneController,
              decoration: InputDecoration(
                labelText: 'Téléphone de la coopérative',
                border: OutlineInputBorder(),
              ),
            ),
            SizedBox(height: 16.0),
            Row(
              children: [
                Text(
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
                    // Action pour enregistrer la coopérative
                  },
                  child: Text('ENREGISTRER'),
                ),
                ElevatedButton(
                  onPressed: () {
                    // Action pour annuler
                  },
                  child: Text('ANNULER'),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}