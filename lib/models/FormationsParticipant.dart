class FormationParticipant {
  int? id;
  String formationId;
  String participantId;
  String participantNom;

  FormationParticipant({
    this.id,
    required this.formationId,
    required this.participantId,
    required this.participantNom,
  });

  // Ajout de la méthode fromMap
  factory FormationParticipant.fromMap(Map<String, dynamic> map) {
    return FormationParticipant(
      id: map['id'],
      formationId: map['formationId'],
      participantId: map['participantId'],
      participantNom: map['participantNom']
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'formationId': formationId,
      'participantId': participantId,
      'participantNom': participantNom
    };
  }
}
