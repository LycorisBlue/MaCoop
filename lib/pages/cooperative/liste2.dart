import 'package:flutter/material.dart';

class CooperativesListScreen extends StatelessWidget {
  final List<Map<String, String>> fakeData = List.generate(3, (index) => {
    "Logo": "Logo $index",
    "Nom": "Nom $index",
    "Président": "Président $index",
    "Téléphone": "Téléphone $index"
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Bienvenue John'),
        actions: [
          IconButton(
            icon: Icon(Icons.home),
            onPressed: () {
              // Home button logic
            },
          ),
          IconButton(
            icon: Icon(Icons.exit_to_app),
            onPressed: () {
              // Exit button logic
            },
          ),
        ],
      ),
      body: ListView(
        children: <Widget>[
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: ElevatedButton.icon(
              onPressed: () {
                // Add cooperative logic
              },
              icon: Icon(Icons.add),
              label: Text('Ajouter une coopérative'),
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: Text(
              'Liste des coopératives',
              style: Theme.of(context).textTheme.headline6,
            ),
          ),
          _buildCooperativeSection(context, 'Coopérative 1 - Section 1', fakeData),
          _buildCooperativeSection(context, 'Coopérative 2 - Section 2', fakeData),
          _buildCooperativeSection(context, 'Coopérative 3 - Section 3', fakeData),
        ],
      ),
    );
  }

  Widget _buildCooperativeSection(BuildContext context, String sectionTitle, List<Map<String, String>> data) {
    return Card(
      margin: const EdgeInsets.all(16.0),
      child: Column(
        children: <Widget>[
          ListTile(
            title: Text(sectionTitle, style: Theme.of(context).textTheme.subtitle1),
          ),
          Table(
            columnWidths: const <int, TableColumnWidth>{
              0: FlexColumnWidth(1),
              1: FlexColumnWidth(2),
              2: FlexColumnWidth(3),
              3: FlexColumnWidth(2),
            },
            border: TableBorder.all(),
            children: [
              TableRow(
                children: [
                  TableCell(child: Center(child: Text('Logo'))),
                  TableCell(child: Center(child: Text('Nom'))),
                  TableCell(child: Center(child: Text('Président'))),
                  TableCell(child: Center(child: Text('Téléphone'))),
                ],
              ),
              ...data.map((cooperative) {
                return TableRow(
                  children: [
                    TableCell(child: Center(child: Text(cooperative["Logo"]!))),
                    TableCell(child: Center(child: Text(cooperative["Nom"]!))),
                    TableCell(child: Center(child: Text(cooperative["Président"]!))),
                    TableCell(child: Center(child: Text(cooperative["Téléphone"]!))),
                  ],
                );
              }).toList(),
            ],
          ),
        ],
      ),
    );
  }
}