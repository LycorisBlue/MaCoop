import 'dart:convert';

class Formation {
  int? id;
  String titre;
  String formateur;
  String description;
  DateTime datePrevu;
  String lieu;
  String idCooperative;
  List<String> sections;

  Formation({
    this.id,
    required this.titre,
    required this.formateur,
    required this.description,
    required this.datePrevu,
    required this.lieu,
    required this.idCooperative,
    required this.sections
  });

  // Ajout de la méthode fromMap
  factory Formation.fromMap(Map<String, dynamic> map) {
    return Formation(
      id: map['id'],
      titre: map['titre'],
      formateur: map['formateur'],
      description: map['description'],
      datePrevu: map['datePrevu'],
      lieu: map['lieu'],
      idCooperative: map['idCooperative'],
      sections: List<String>.from(jsonDecode(map['sections'])),
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'titre': titre,
      'formateur': formateur,
      'description': description,
      'datePrevu': datePrevu.toIso8601String(),
      'lieu': lieu,
      'id_cooperative': idCooperative,
      'sections': jsonEncode(sections),
    };
  }
}
