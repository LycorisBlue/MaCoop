import 'dart:io';

import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:tuloss_coo/models/database.dart';

import '../../models/Cooperative.dart';
import 'package:tuloss_coo/pages/cooperative/add.dart';

import '../Home/home.dart';


class ListeCooperative extends StatefulWidget {
  @override
  _ListeCooperativeState createState() => _ListeCooperativeState();
}

class _ListeCooperativeState extends State<ListeCooperative> {
  late Future<List<Cooperative>> _listeCooperatives;
  final Box _boxLogin = Hive.box("admins");

  @override
  void initState() {
    super.initState();
    _listeCooperatives = DatabaseHelper.instance.cooperatives(); // Assurez-vous que votre fonction membres() est accessible via votre instance DatabaseHelper
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(boxLogin: _boxLogin,),
      body: Center(
        child: Container(
          width: double.infinity,
          height: 1000,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Padding(
                padding: const EdgeInsets.all(16.0),
                child: ElevatedButton(
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => AddCooperative(),
                      ),
                    );
                  },
                  child: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Icon(Icons.add),
                      SizedBox(width: 8.0),
                      Text('Créer une coopérative'),
                    ],
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16.0),
                child: Text(
                  'Liste des coopératives',
                  style: TextStyle(
                    fontSize: 18.0,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
              Expanded(
                child: Container(
                  padding: EdgeInsets.all(30),
                  margin: EdgeInsets.all(20),
                  decoration: BoxDecoration(
                    border: Border.all(color: Colors.grey),
                    borderRadius: BorderRadius.circular(8.0),
                  ),
                  child: GirdView(liste: _listeCooperatives),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class GirdView extends StatelessWidget {
  const GirdView({
    super.key,
    required Future<List<Cooperative>> liste,
  }) : _listeMembres = liste;

  final Future<List<Cooperative>> _listeMembres;

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<List<Cooperative>>(
      future: _listeMembres,
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return Center(child: CircularProgressIndicator());
        } else if (snapshot.hasError) {
          return Center(child: Text('Erreur de chargement des membres'));
        } else if (snapshot.hasData) {
          return GridView.count(
            crossAxisCount: 2,
            childAspectRatio: 0.8,
            padding: EdgeInsets.all(15.0),
            crossAxisSpacing: 16.0,
            mainAxisSpacing: 16.0,
            children: List.generate(snapshot.data!.length, (index) {
              return Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  // Ici, je suppose que 'picture' est un lien vers une image. Vous devrez peut-être ajuster cela en fonction de vos données.
                  Expanded(
                    child: Image.file(
                      File(snapshot.data![index].imagePath),
                      fit: BoxFit.cover,
                    ),
                  ),
                  Text(
                    snapshot.data![index].nom,
                    style: const TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 16.0,
                    ),
                  ),
                ],
              );

            }),
          );
        } else {
          return Center(child: Text('Aucun membre trouvé'));
        }
      },
    );
  }
}
