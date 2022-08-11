class Coursier {
  int? coursierId;
  int? commandeId;
  final String first_name;
  final String last_name;
  final String email;
  final int phone_number;
  final String password;
  final String? image;
  final String transport;
  final String rating;
  final String occupation;
  String? updated_At;

  Coursier(
      {this.coursierId,
      this.commandeId,
      required this.first_name,
      required this.last_name,
      required this.email,
      required this.phone_number,
      required this.password,
      this.image,
      required this.transport,
      required this.rating,
      required this.occupation,
      this.updated_At});

  factory Coursier.fromJson(dynamic json) {
    return Coursier(
      coursierId: json['coursier_id'] as int,
      commandeId: json['comande_id'],
      first_name: json['first_name'] as String,
      last_name: json['last_name'] as String,
      email: json['email'] as String,
      phone_number: json['phone_number'] as int,
      password: json['password'] as String,
      image: json['image'] as String,
      transport: json['transport'] as String,
      rating: json['rating'] as String,
      occupation: json['occupation'] as String,
    );
  }
  Map<String, dynamic> toJson() => {
        "comande_id": commandeId,
        "first_name": first_name,
        "last_name": last_name,
        "email": email,
        "phone_number": phone_number,
        "password": password,
        "image": image,
        "transport": transport,
        "rating": rating,
        "occupation": occupation,
        "updated_at": updated_At,
      };
  static List<Coursier> recipesFromSnapshot(List snapshot) {
    return snapshot.map((data) => Coursier.fromJson(data)).toList();
  }

  @override
  String toString() {
    return 'Coursier {coursier_id:$coursierId, commande_id: $commandeId, first_name:$first_name,email: $email, phone_number: $phone_number,password:$password, image:!$image,transport: $transport, rating: $rating,occupation:$occupation,updated_at:$updated_At}';
  }
}
