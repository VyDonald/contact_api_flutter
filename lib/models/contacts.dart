class Contact {
  final int? id;
  final String nom;
  final String prenom;
  final String numero;
  final int groupeId;

  Contact({this.id, required this.nom, required this.prenom, required this.numero, required this.groupeId});

  factory Contact.fromJson(Map<String, dynamic> json) {
    return Contact(
      id: json['id'],
      nom: json['nom'],
      prenom: json['prenom'],
      numero: json['numero'],
      groupeId: json['groupe_id'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'nom': nom,
      'prenom': prenom,
      'numero': numero,
      'groupe_id': groupeId,
    };
  }
}
