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
      adressId: json['adresse_id'] as int,
      adresslivid: json['adresse_liv_id'] as int,
      adressramid: json['adresse_ram_id'] as int,
      poids: json['poids'] as String,
      taille: json['taille'] as String,
      type: json['type'] as String,
      planification: json['planification'] as String,
      updatedAt: json['updated_at'] as String,
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
