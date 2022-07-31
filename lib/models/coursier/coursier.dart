class Coursier {
  int? coursierId;
  final int userId;
  final int commandeId;
  final String transport;
  final double rating;

  Coursier(
      {this.coursierId,
      required this.userId,
      required this.commandeId,
      required this.transport,
      required this.rating});

  factory Coursier.fromJson(dynamic json) {
    return Coursier(
      coursierId: json['coursier_id'],
      userId: json['user_id'] as int,
      commandeId: json['commande_id'] as int,
      transport: json['transport'] as String,
      rating: json['rating'] as double,
    );
  }

  static List<Coursier> recipesFromSnapshot(List snapshot) {
    return snapshot.map((data) => Coursier.fromJson(data)).toList();
  }

  @override
  String toString() {
    return 'Coursier {coursier_id:$coursierId,user_id: $userId, commande_id: $commandeId, transport: $transport, rating: $rating}';
  }
}
