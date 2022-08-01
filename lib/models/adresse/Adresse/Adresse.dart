class PlaceLocation {
  final double latitude;
  final double longitude;

  const PlaceLocation({required this.latitude, required this.longitude});
}

class Adresse {
  int? adressId;
  int adresslivid;
  int adressramid;
  String poids;
  String taille;
  String type;
  String planification;
  String? updatedAt;

  Adresse({
    this.adressId,
    required this.adresslivid,
    required this.adressramid,
    required this.poids,
    required this.taille,
    required this.type,
    required this.planification,
    this.updatedAt,
  });

  factory Adresse.fromJson(dynamic json) {
    return Adresse(
      adressId: json['adresse_id'],
      adresslivid: json['adresse_liv_id'],
      adressramid: json['adresse_ram_id'],
      poids: json['poids'],
      taille: json['taille'],
      type: json['type'],
      planification: json['planification'],
      updatedAt: json['updated_at'],
    );
  }

  Map<String, dynamic> toJson() => {
        "adresse_liv_id": adresslivid,
        "adresse_ram_id": adressramid,
        "poids": poids,
        "taille": taille,
        "type": type,
        "planification": planification,
        "updated_at": updatedAt,
      };

  static List<Adresse> adressRamFromSnapshot(List snapshot) {
    return snapshot.map((data) => Adresse.fromJson(data)).toList();
  }

  @override
  String toString() {
    return 'AdressRam {adresse_id:$adressId,adresse_liv_id: $adresslivid, adresse_ram_id: $adressramid, poids: $poids, taille: $taille,type:$type,planification:$planification updated_at!$updatedAt}';
  }
}
