import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class RegisterPage extends StatefulWidget {
  @override
  _RegisterPageState createState() => _RegisterPageState();
}

class _RegisterPageState extends State<RegisterPage> {
  String _typeUtilisateur = 'Membre';
  final _nomController = TextEditingController();
  final _prenomController = TextEditingController();
  DateTime _dateNaissance = DateTime(1900, 1, 1);
  final _telephoneController = TextEditingController();
  final _adresseController = TextEditingController();
  final _emailController = TextEditingController();
  final _motDePasseController = TextEditingController();

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
                  DropdownButtonFormField<String>(
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
                      labelText: 'Type utilisateur',
                      border: OutlineInputBorder(),
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