import 'package:flutter/material.dart';

class AccueilMembrePage extends StatefulWidget {
  final String title;
  final String type;

  const AccueilMembrePage({super.key, required this.title, required this.type});

  @override
  State<AccueilMembrePage> createState() => _AccueilMembrePageState();
}

class _AccueilMembrePageState extends State<AccueilMembrePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Lycoris Blue"),
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
        child: Container(
          height: 700,
          padding: const EdgeInsets.all(20),
          child: Column(
            children: [
              Container(
                color: Colors.white,
                width: double.infinity,
                child: Text(widget.title, style: TextStyle(fontSize: 30, fontWeight: FontWeight.w400),),
              ),
              Expanded(
                child: Container(
                  decoration: BoxDecoration(
                      border: Border.all(
                          color: Colors.black,
                          width: 1
                      )
                  ),
                  child: const Center(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: <Widget>[
                        Text(
                          "Vide pour l'instant",
                          style: TextStyle(fontSize: 30, fontWeight: FontWeight.w400),
                        ),
                        // Ajouter ici la liste ou le contenu des coopératives
                      ],
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
      floatingActionButton: Container(
        width: 80,
        height: 80,
        child: FloatingActionButton(
          onPressed: () {
            // Code pour créer une coopérative
          },
          child: Icon(Icons.add, size: 50,),
          tooltip: 'Créer une coopérative',
        ),
      ),
    );
  }
}


