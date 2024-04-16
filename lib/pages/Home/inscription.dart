import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';
import 'package:tuloss_coo/models/Admin.dart';
import 'package:tuloss_coo/pages/Home/connexion.dart';

import '../../models/database.dart';

class RegisterPage extends StatefulWidget {
  @override
  _RegisterPageState createState() => _RegisterPageState();
}

class _RegisterPageState extends State<RegisterPage> {
  final _nomController = TextEditingController();
  final _prenomController = TextEditingController();
  DateTime _dateNaissance = DateTime(1900, 1, 1);
  final _telephoneController = TextEditingController();
  final _adresseController = TextEditingController();
  final _emailController = TextEditingController();
  final _motDePasseController = TextEditingController();

  Future<void> resetDatabase() async {
    var databasesPath = await getDatabasesPath();
    String path = join(databasesPath, 'MaCoop.db'); // Utilisez le nom réel de votre base de données
    await deleteDatabase(path);
  }


  Future<void> enregistrerMembre() async {
    print("Let's go");


    // Créer un objet Membre avec les données du formulaire
    final admin = Admin(
      nom: _nomController.text,
      prenom: _prenomController.text,
      telephone: _telephoneController.text,
      adresse: _adresseController.text,
      email: _emailController.text,
      dateOfbirth: "$_dateNaissance",
      password: _motDePasseController.text,
    );

    try {
      // Utilisez DatabaseHelper pour insérer le nouveau membre dans la base de données
      final databaseHelper = DatabaseHelper.instance;
      final int id = await databaseHelper.insertAdmin(admin);
      print('Membre enregistré avec l\'ID: $id');

      // Vérifiez si l'id n'est pas null (ou, dans ce cas, puisque `id` est un int, vérifiez qu'il est supérieur à 0)
      if (id > 0) {
        print('Membre enregistré avec l\'ID: $id');
        // Naviguez vers une nouvelle page
        Navigator.push(
          this.context,
          MaterialPageRoute(
            builder: (context) => LoginPage(),
          ),
        );
      } else {
        // Gérez le cas où l'id est 0 ou null, ce qui indiquerait un échec de l'insertion
        print('Échec de l\'enregistrement du membre');
      }

    } catch (e) {
      print('Erreur lors de l\'enregistrement du membre: $e');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Container(
          width: 500,
          child: SingleChildScrollView(
            child: Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Inscription',
                    style: TextStyle(
                      fontSize: 24.0,
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
                  TextField(
                    controller: _prenomController,
                    decoration: InputDecoration(
                      labelText: 'Prénom',
                      border: OutlineInputBorder(),
                    ),
                  ),
                  SizedBox(height: 16.0),
                  InkWell(
                    onTap: () {
                      showDatePicker(
                        context: context,
                        initialDate: _dateNaissance,
                        firstDate: DateTime(1900),
                        lastDate: DateTime.now(),
                      ).then((selectedDate) {
                        if (selectedDate != null) {
                          setState(() {
                            _dateNaissance = selectedDate;
                          });
                        }
                      });
                    },
                    child: InputDecorator(
                      decoration: InputDecoration(
                        labelText: 'Date de naissance',
                        border: OutlineInputBorder(),
                      ),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(DateFormat('dd-MM-yyyy').format(_dateNaissance)),
                          Icon(Icons.calendar_today),
                        ],
                      ),
                    ),
                  ),
                  SizedBox(height: 16.0),
                  TextField(
                    controller: _telephoneController,
                    keyboardType: TextInputType.number,
                    decoration: InputDecoration(
                      labelText: 'Téléphone',
                      border: OutlineInputBorder(),
                    ),
                  ),
                  SizedBox(height: 16.0),
                  TextField(
                    controller: _adresseController,
                    decoration: InputDecoration(
                      labelText: 'Adresse',
                      border: OutlineInputBorder(),
                    ),
                  ),
                  SizedBox(height: 16.0),
                  TextField(
                    controller: _emailController,
                    decoration: InputDecoration(
                      labelText: 'Adresse email',
                      border: OutlineInputBorder(),
                    ),
                  ),
                  SizedBox(height: 16.0),
                  TextField(
                    controller: _motDePasseController,
                    obscureText: true,
                    decoration: InputDecoration(
                      labelText: 'Mot de passe',
                      border: OutlineInputBorder(),
                    ),
                  ),
                  SizedBox(height: 16.0),
                  ElevatedButton(
                    onPressed: () {
                      // Action pour l'inscription
                      enregistrerMembre();
                    },
                    child: Text('INSCRIRE'),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}