class Commande {
  int? commandeId;
  final int client_id;
  final int adresse_id;
  final String statut;
  final String? updated_at;

  Commande(
      {this.commandeId,
      required this.client_id,
      required this.adresse_id,
      required this.statut,
      this.updated_at});

  factory Commande.fromJson(dynamic json) {
    return Commande(
      commandeId: json['commande_id'] as int,
      client_id: json['user_id'] as int,
      adresse_id: json['adresse_id'] as int,
      statut: json['statut'] as String,
      updated_at: json['updated_at'] as String,
    );
  }

  Map<String, dynamic> toJson() => {
        "user_id": client_id,
        "adresse_id": adresse_id,
        "statut": statut,
        "updated_at": updated_at,
      };

  static List<Commande> recipesFromSnapshot(List snapshot) {
    return snapshot.map((data) => Commande.fromJson(data)).toList();
  }

  @override
  String toString() {
    return 'Commande {commande_id:$commandeId,user_id: $client_id, adresse_id: $adresse_id,statut:$statut,updated_At:$updated_at}';
  }
}
