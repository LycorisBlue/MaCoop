class Membre {
  int? id;
  String idCooperative;
  String idSection;
  String idType;
  String nom;
  String prenom;
  String picture;
  String dateOfbirth;
  String telephone;
  String adresse;
  String email;

  Membre({
    this.id,
    required this.idCooperative,
    required this.idSection,
    required this.idType,
    required this.nom,
    required this.prenom,
    required this.picture,
    required this.dateOfbirth,
    required this.telephone,
    required this.adresse,
    required this.email,
  });

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'id_cooperative': idCooperative,
      'id_section': idSection,
      'id_type': idType,
      'nom': nom,
      'prenom': prenom,
      'picture': picture,
      'dateOfbirth': dateOfbirth,
      'telephone': telephone,
      'adresse': adresse,
      'email': email,
    };
  }
}