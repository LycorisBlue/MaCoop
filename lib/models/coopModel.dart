class FormData {
  String nom;
  String president;
  String adg;
  String localisation;
  String telephone;
  DateTime dateCreation;
  String imagePath;
  List<String> sections;

  FormData({
    required this.nom,
    required this.president,
    required this.adg,
    required this.localisation,
    required this.telephone,
    required this.dateCreation,
    required this.imagePath,
    required this.sections,
  });

  Map<String, dynamic> toJson() => {
    'nom': nom,
    'president': president,
    'adg': adg,
    'localisation': localisation,
    'telephone': telephone,
    'dateCreation': dateCreation.toIso8601String(),
    'imagePath': imagePath,
    'sections': sections,
  };

  // Ajouter une méthode factory pour créer une instance à partir d'un json
  factory FormData.fromJson(Map<String, dynamic> json) => FormData(
    nom: json['nom'],
    president: json['president'],
    adg: json['adg'],
    localisation: json['localisation'],
    telephone: json['telephone'],
    dateCreation: DateTime.parse(json['dateCreation']),
    imagePath: json['imagePath'],
    sections: List<String>.from(json['sections']),
  );
}

class Cooperative {
  final String nom;
  final String president;
  final String adg;
  final String localisation;
  final String telephone;
  final DateTime dateCreation;
  final String imagePath;
  final List<String> sections;

  Cooperative({
    required this.nom,
    required this.president,
    required this.adg,
    required this.localisation,
    required this.telephone,
    required this.dateCreation,
    required this.imagePath,
    required this.sections,
  });
}
