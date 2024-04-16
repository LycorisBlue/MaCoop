import 'package:flutter/material.dart';
import '../../models/Formation.dart';
import '../../models/database.dart';

class FormationListScreen extends StatefulWidget {
  @override
  _FormationListScreenState createState() => _FormationListScreenState();
}

class _FormationListScreenState extends State<FormationListScreen> {
  late Future<List<Formation>> _listeFormations;

  @override
  void initState() {
    super.initState();
    _listeFormations = DatabaseHelper.instance.formations();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Liste des Formations"),
      ),
      body: FutureBuilder<List<Formation>>(
        future: _listeFormations,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(child: CircularProgressIndicator());
          } else if (snapshot.hasError) {
            return Center(child: Text("Erreur de chargement des données"));
          } else if (snapshot.hasData) {
            return ListView.builder(
              itemCount: snapshot.data!.length,
              itemBuilder: (context, index) {
                Formation formation = snapshot.data![index];
                String sectionsString = formation.sections.join(", ");
                return ListTile(
                  title: Text(formation.titre),
                  subtitle: Text("${sectionsString}\nPrévu pour: ${formation.datePrevu.toString()}"),
                );
              },
            );
          } else {
            return Center(child: Text("Aucune formation disponible"));
          }
        },
      ),
    );
  }
}
