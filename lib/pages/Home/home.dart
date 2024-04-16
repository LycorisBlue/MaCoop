import 'package:flutter/material.dart';
import 'package:hive_flutter/adapters.dart';
import 'package:tuloss_coo/pages/Home/connexion.dart';
import 'package:tuloss_coo/pages/formation/add.dart';
import 'package:tuloss_coo/pages/membre/liste.dart';

import '../cooperative/liste.dart';


class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final Box _boxLogin = Hive.box("admins");



  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(boxLogin: _boxLogin, afficherBoutonAccueil: false,),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            GestureDetector(
                onTap: (){
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => ListeCooperative(),
                    ),
                  );
                },
                child: MenuButton('COOPERATIVES')
            ),
            const SizedBox(height: 16.0),
            MenuButton('PERSONNEL ADMINISTRATIF'),
            const SizedBox(height: 16.0),
            GestureDetector(
                onTap: (){
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => AddFormation(),
                    ),
                  );
                },
                child: MenuButton('FORMATIONS')
            ),
            const SizedBox(height: 16.0),
            GestureDetector(
              onTap: (){
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => MembresGridPage(),
                  ),
                );
              },
                child: MenuButton('MEMBRES')
            ),
          ],
        ),
      ),
    );
  }
}

class CustomAppBar extends StatelessWidget implements PreferredSizeWidget {
  const CustomAppBar({
    super.key,
    required this.boxLogin,
    this.afficherBoutonAccueil = true, // Paramètre ajouté avec une valeur par défaut à true
  });

  final Box boxLogin;
  final bool afficherBoutonAccueil; // Déclaration du nouveau paramètre

  @override
  Widget build(BuildContext context) {
    List<Widget> actions = [];

    // Ajout conditionnel du bouton Accueil en fonction de afficherBoutonAccueil
    if (afficherBoutonAccueil) {
      actions.add(
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: GestureDetector(
            onTap: (){
              Navigator.pushReplacement(
                context,
                MaterialPageRoute(
                  builder: (context) => HomePage(),
                ),
              );
            },
            child: Container(
              padding: EdgeInsets.all(8.0),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(10.0),
                border: Border.all(color: Colors.white),
              ),
              child: Row(
                children: const [
                  Icon(Icons.home, color: Colors.blue),
                  SizedBox(width: 5),
                  Text('Accueil'),
                ],
              ),
            ),
          ),
        ),
      );
    }

    // Toujours ajouter le bouton Quitter
    actions.add(
      Padding(
        padding: const EdgeInsets.all(8.0),
        child: GestureDetector(
          onTap: () {
            boxLogin.clear();
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => LoginPage(),
              ),
            );
          },
          child: Container(
            padding: EdgeInsets.all(8.0),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(10.0),
              border: Border.all(color: Colors.white),
            ),
            child: const Row(
              children: [
                Icon(Icons.exit_to_app, color: Colors.red),
                SizedBox(width: 5),
                Text('Quitter'),
              ],
            ),
          ),
        ),
      ),
    );

    return AppBar(
      title: Text("Bienvenue ${boxLogin.get("user-name")}"),
      actions: actions,
    );
  }

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);
}

class MenuButton extends StatelessWidget {
  final String text;

  MenuButton(this.text);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 400,
      padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
      decoration: BoxDecoration(
        border: Border.all(color: Colors.grey),
        borderRadius: BorderRadius.circular(8.0),
      ),
      child: Center(
        child: Text(
          text,
          style: const TextStyle(fontSize: 16.0, fontWeight: FontWeight.w600),
        ),
      ),
    );
  }
}