class AdressRam {
  String localisation;
  String nameEmetteur;
  int contactEmetteur;
  String emailEmetteur;
  String civiliteEmetteur;
  String planification;
  String? updatedAt;

  AdressRam(
      {required this.localisation,
      required this.nameEmetteur,
      required this.contactEmetteur,
      required this.emailEmetteur,
      required this.civiliteEmetteur,
      required this.planification,
      this.updatedAt});

  factory AdressRam.fromJson(dynamic json) {
    return AdressRam(
      localisation: json['localisation'] as String,
      nameEmetteur: json['name_emetteur'] as String,
      contactEmetteur: json['contact_emetteur'] as int,
      emailEmetteur: json['email_emetteur'] as String,
      civiliteEmetteur: json['civilite_emetteur'] as String,
      planification: json['planification'] as String,
      updatedAt: json['updated_at'] as String,
    );
  }

  Map<String, dynamic> toJson() => {
        "localisation": localisation,
        "name_recepteur": nameEmetteur,
        "contact_recepteur": contactEmetteur,
        "email_recepteur": emailEmetteur,
        "civilite_recepteur": civiliteEmetteur,
        "planification": planification,
        "updated_at": updatedAt,
      };

  static List<AdressRam> adressRamFromSnapshot(List snapshot) {
    return snapshot.map((data) => AdressRam.fromJson(data)).toList();
  }

  @override
  String toString() {
    return 'AdressRam {localisation: $localisation, name_recepteur: $nameEmetteur, contact_recepteur: $contactEmetteur, email_recepteur: $emailEmetteur,civilite_recepteur:$civiliteEmetteur, planification:$planification, updated_at!$updatedAt}';
  }
}
