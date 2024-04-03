import 'package:flutter/material.dart';

class LoginPage extends StatefulWidget {
  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Container(
          padding: EdgeInsets.all(16.0),
          width: 500,
          decoration: BoxDecoration(
            border: Border.all(color: Colors.grey),
            borderRadius: BorderRadius.circular(8.0),
          ),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              const Text(
                'Inscription',
                style: TextStyle(
                  fontSize: 18.0,
                  fontWeight: FontWeight.bold,
                ),
              ),
              SizedBox(height: 16.0),
              const TextField(
                decoration: InputDecoration(
                  labelText: 'Adresse email',
                  prefixIcon: Icon(Icons.email),
                ),
              ),
              SizedBox(height: 16.0),
              TextField(
                decoration: InputDecoration(
                  labelText: 'Mot de passe',
                  prefixIcon: Icon(Icons.lock),
                ),
                obscureText: true,
              ),
              SizedBox(height: 16.0),
              ElevatedButton(
                onPressed: () {
                  // Logique de connexion
                },
                child: Text('CONNEXION'),
              ),
              SizedBox(height: 8.0),
              TextButton(
                onPressed: () {
                  // Logique de réinitialisation du mot de passe
                },
                child: Text('Mot de passe oublié ?'),
              ),
              SizedBox(height: 16.0),
              OutlinedButton(
                onPressed: () {
                  // Logique de création de compte
                },
                child: Text('CRÉER UN COMPTE'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
