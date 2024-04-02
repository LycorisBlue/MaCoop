import 'package:flutter/material.dart';


class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Bienvenue John"),
        actions: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Stack(
              children: [
                Container(
                  padding: EdgeInsets.all(8.0),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10.0),
                    border: Border.all(color: Colors.white),
                  ),
                  child: const Row(
                    children: [
                      Icon(Icons.home, color: Colors.blue,),
                      SizedBox(width: 5),
                      Text('Accueil'),
                    ],
                  ),
                ),
              ],
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Stack(
              children: [
                Container(
                  padding: EdgeInsets.all(8.0),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10.0),
                    border: Border.all(color: Colors.white),
                  ),
                  child: const Row(
                    children: [
                      Icon(Icons.exit_to_app, color: Colors.red,),
                      SizedBox(width: 5),
                      Text('Quitter'),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            MenuButton('COOPERATIVES'),
            const SizedBox(height: 16.0),
            MenuButton('PERSONNEL ADMINISTRATIF'),
            const SizedBox(height: 16.0),
            MenuButton('FORMATIONS'),
            const SizedBox(height: 16.0),
            MenuButton('MEMBRES'),
          ],
        ),
      ),
    );
  }
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