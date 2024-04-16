class Admin {
  int? id;
  String nom;
  String prenom;
  String dateOfbirth;
  String telephone;
  String adresse;
  String email;
  String password;

  Admin({
    this.id,
    required this.nom,
    required this.prenom,
    required this.dateOfbirth,
    required this.telephone,
    required this.adresse,
    required this.email,
    required this.password,
  });

  // Ajout de la méthode fromMap
  factory Admin.fromMap(Map<String, dynamic> map) {
    return Admin(
      id: map['id'],
      nom: map['nom'],
      prenom: map['prenom'],
      dateOfbirth: map['dateOfbirth'],
      telephone: map['telephone'],
      adresse: map['adresse'],
      email: map['email'],
      password: map['password'],
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'nom': nom,
      'prenom': prenom,
      'dateOfbirth': dateOfbirth,
      'telephone': telephone,
      'adresse': adresse,
      'email': email,
      'password': password,
    };
  }
}
