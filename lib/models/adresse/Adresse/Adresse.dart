class PlaceLocation {
  final double latitude;
  final double longitude;
  final String address;

  const PlaceLocation(
      {required this.latitude, required this.longitude, required this.address});
}

class Adresse {
  int adresslivid;
  int adressramid;
  String poids;
  String taille;
  String type;
  String? updatedAt;

  Adresse({
    required this.adresslivid,
    required this.adressramid,
    required this.poids,
    required this.taille,
    required this.type,
    this.updatedAt,
  });

  factory Adresse.fromJson(dynamic json) {
    return Adresse(
      adresslivid: json['adresse_liv_id'],
      adressramid: json['adresse_ram_id'],
      poids: json['poids'],
      taille: json['taille'],
      type: json['type'],
      updatedAt: json['updated_at'],
    );
  }

  Map<String, dynamic> toJson() => {
        "adresse_liv_id": adresslivid,
        "adresse_ram_id": adressramid,
        "poids": poids,
        "taille": taille,
        "type": type,
        "updated_at": updatedAt,
      };

  static List<Adresse> adressRamFromSnapshot(List snapshot) {
    return snapshot.map((data) => Adresse.fromJson(data)).toList();
  }

  @override
  String toString() {
    return 'AdressRam {adresse_liv_id: $adresslivid, adresse_ram_id: $adressramid, poids: $poids, taille: $taille,type:$type, updated_at!$updatedAt}';
  }
}
