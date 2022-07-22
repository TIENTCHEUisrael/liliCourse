class Coursier {
  final int user_id;
  final int commande_id;
  final String transport;
  final double rating;

  Coursier(
      {required this.user_id,
      required this.commande_id,
      required this.transport,
      required this.rating});

  factory Coursier.fromJson(dynamic json) {
    return Coursier(
      user_id: json['user_id'] as int,
      commande_id: json['commande_id'] as int,
      transport: json['transport'] as String,
      rating: json['rating'] as double,
    );
  }

  static List<Coursier> recipesFromSnapshot(List snapshot) {
    return snapshot.map((data) => Coursier.fromJson(data)).toList();
  }

  @override
  String toString() {
    return 'Coursier {user_id: $user_id, commande_id: $commande_id, transport: $transport, rating: $rating}';
  }
}
