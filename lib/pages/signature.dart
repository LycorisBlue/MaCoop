import 'package:flutter/material.dart';
import 'package:signature/signature.dart';
import 'dart:ui' as ui;
import 'dart:typed_data';
import 'dart:io';
import 'package:path_provider/path_provider.dart';

class FormationWidget extends StatefulWidget {
  @override
  _FormationWidgetState createState() => _FormationWidgetState();
}

class _FormationWidgetState extends State<FormationWidget> {
  final SignatureController _signatureController = SignatureController(
    penStrokeWidth: 2,
    penColor: Colors.black,
  );

  final String _folderName = 'formations'; // Nom du dossier souhaité

  @override
  void initState() {
    super.initState();
    _signatureController.addListener(() => print('Value changed'));
  }

  Future<String> _createFolderInAppDocDir(String folderName) async {
    final Directory appDocDir = await getApplicationDocumentsDirectory();
    final Directory folderPath = Directory('${appDocDir.path}/$folderName');

    if (await folderPath.exists()) {
      return folderPath.path;
    } else {
      final Directory newFolder = await folderPath.create(recursive: true);
      return newFolder.path;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Bienvenue John'),
        actions: [
          IconButton(
            icon: Icon(Icons.home),
            onPressed: () {
              // Action pour l'icône Accueil
            },
          ),
          IconButton(
            icon: Icon(Icons.exit_to_app),
            onPressed: () {
              // Action pour l'icône Quitter
            },
          ),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            Container(
              padding: EdgeInsets.all(16.0),
              decoration: BoxDecoration(
                border: Border.all(color: Colors.grey),
                borderRadius: BorderRadius.circular(8.0),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      Text('Formation XYZ'),
                      SizedBox(width: 8.0),
                      Text('John DOE'),
                      SizedBox(width: 8.0),
                      Text('01.01.1900'),
                    ],
                  ),
                  SizedBox(height: 16.0),
                  Signature(
                    controller: _signatureController,
                    height: 200,
                    backgroundColor: Colors.grey.shade300,
                  ),
                ],
              ),
            ),
            SizedBox(height: 16.0),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                ElevatedButton(
                  onPressed: () async {
                    final data = await _signatureController.toPngBytes();
                    final folderPath = await _createFolderInAppDocDir(_folderName);
                    final file = File('$folderPath/signature_${DateTime.now().millisecondsSinceEpoch}.png');
                    await file.writeAsBytes(data!);
                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(
                        content: Text('Signature enregistrée dans $folderPath'),
                      ),
                    );
                  },
                  child: Text('ENREGISTRER'),
                ),
                ElevatedButton(
                  onPressed: () {
                    // Action pour annuler
                    _signatureController.clear();
                  },
                  child: Text('ANNULER'),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}