import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:tuloss_coo/pages/Home/home.dart';
import 'package:tuloss_coo/pages/Home/inscription.dart';

import '../../models/database.dart';

class LoginPage extends StatefulWidget {
  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  // Définition des TextEditingController pour l'email et le mot de passe
  final Box _boxLogin = Hive.box("admins");
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();

  @override
  void dispose() {
    // Nettoyer les contrôleurs lorsque le widget est supprimé
    _emailController.dispose();
    _passwordController.dispose();
    super.dispose();
  }
  Future<void> _login() async {
    // Ici, vous appelez votre fonction de connexion (à implémenter)
    // et utilisez les valeurs des contrôleurs pour l'email et le mot de passe
    String email = _emailController.text;
    String password = _passwordController.text;

    try {
      // Utilisez DatabaseHelper pour insérer le nouveau membre dans la base de données
      final databaseHelper = DatabaseHelper.instance;
      final List result = await databaseHelper.connexion(email, password);
      if(result[0] == "success"){
        _boxLogin.put("login", true);
        _boxLogin.put("user-name", result[1]);
        _boxLogin.put("user-email", result[2]);
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(
            builder: (context) => HomePage(),
          ),
        );
      }else{
        print(result[0]);
      }

    } catch (e) {
      print('Erreur lors de l\'enregistrement du membre: $e');
    }

    // Affiche le résultat avec print

  }

  @override
  Widget build(BuildContext context) {
    if (_boxLogin.get("login") ?? false) {
      return HomePage();
    }
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
              TextField(
                decoration: InputDecoration(
                  labelText: 'Adresse email',
                  prefixIcon: Icon(Icons.email),
                ),
                controller: _emailController,
              ),
              SizedBox(height: 16.0),
              TextField(
                controller: _passwordController,
                decoration: InputDecoration(
                  labelText: 'Mot de passe',
                  prefixIcon: Icon(Icons.lock),
                ),
                obscureText: true,
              ),
              SizedBox(height: 16.0),
              ElevatedButton(
                onPressed: () {
                  _login();
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
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => RegisterPage(),
                    ),
                  );
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
