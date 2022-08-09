class Paiement {
  int? PaiementId;
  final int userId;
  final int commandeId;
  final String montant;
  final String mode;
  final String phone;
  final String? updated_at;

  Paiement({
    this.PaiementId,
    required this.userId,
    required this.commandeId,
    required this.montant,
    required this.mode,
    required this.phone,
    this.updated_at,
  });

  factory Paiement.fromJson(dynamic json) {
    return Paiement(
      PaiementId: json['paiement_id'] as int,
      userId: json['user_id'] as int,
      commandeId: json['comande_id'] as int,
      montant: json['montant'] as String,
      mode: json['mode'] as String,
      phone: json['code'] as String,
      updated_at: json['updated_at'] as String,
    );
  }

  Map<String, dynamic> toJson() => {
        "user_id": userId,
        "comande_id": commandeId,
        "montant": montant,
        "mode": mode,
        "code": phone,
        "updated_at": updated_at
      };

  static List<Paiement> paiementFromSnapshot(List snapshot) {
    return snapshot.map((data) => Paiement.fromJson(data)).toList();
  }

  @override
  String toString() {
    return 'Paiement {user_id:$userId,comande_id: $commandeId, montant: $montant, mode: $mode, code: $phone,updated_at!:$updated_at}';
  }
}
