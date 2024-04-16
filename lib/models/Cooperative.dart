import 'dart:convert';

class Cooperative {
  int? id;
  String nom;
  String president;
  String adg;
  String localisation;
  String telephone;
  DateTime dateCreation;
  String imagePath;
  List<String> sections;

  Cooperative({
    this.id,
    required this.nom,
    required this.president,
    required this.adg,
    required this.localisation,
    required this.telephone,
    required this.dateCreation,
    required this.imagePath,
    required this.sections,
  });

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'nom': nom,
      'president': president,
      'adg': adg,
      'localisation': localisation,
      'telephone': telephone,
      'dateCreation': dateCreation.toIso8601String(),
      'imagePath': imagePath,
      'sections': jsonEncode(sections),
    };
  }

  factory Cooperative.fromMap(Map<String, dynamic> map) {
    return Cooperative(
      id: map['id'],
      nom: map['nom'],
      president: map['president'],
      adg: map['adg'],
      localisation: map['localisation'],
      telephone: map['telephone'],
      dateCreation: DateTime.parse(map['dateCreation']),
      imagePath: map['imagePath'],
      sections: List<String>.from(jsonDecode(map['sections'])),
    );
  }
}
