class AdressRam {
  int? adressRamId;
  String localisationRam;
  String nameEmetteur;
  int contactEmetteur;
  String emailEmetteur;
  String civiliteEmetteur;
  String instruction;
  String? updatedAt;

  AdressRam(
      {this.adressRamId,
      required this.localisationRam,
      required this.nameEmetteur,
      required this.contactEmetteur,
      required this.emailEmetteur,
      required this.civiliteEmetteur,
      required this.instruction,
      this.updatedAt});

  factory AdressRam.fromJson(dynamic json) {
    return AdressRam(
      adressRamId: json['adresse_ram_id'] as int,
      localisationRam: json['localisationRam'] as String,
      nameEmetteur: json['name_emetteur'] as String,
      contactEmetteur: json['contact_emetteur'] as int,
      emailEmetteur: json['email_emetteur'] as String,
      civiliteEmetteur: json['civilite_emetteur'] as String,
      instruction: json['instruction'] as String,
      updatedAt: json['updated_at'] as String,
    );
  }

  Map<String, dynamic> toJson() => {
        "localisationRam": localisationRam,
        "name_emetteur": nameEmetteur,
        "contact_emetteur": contactEmetteur,
        "email_emetteur": emailEmetteur,
        "civilite_emetteur": civiliteEmetteur,
        "instruction": instruction,
        "updated_at": updatedAt,
      };

  static List<AdressRam> adressRamFromSnapshot(List snapshot) {
    return snapshot.map((data) => AdressRam.fromJson(data)).toList();
  }

  @override
  String toString() {
    return 'AdressRam {adresse_ram_id:$adressRamId,localisationRam: $localisationRam, name_recepteur: $nameEmetteur, contact_recepteur: $contactEmetteur, email_recepteur: $emailEmetteur,civilite_recepteur:$civiliteEmetteur, instruction:$instruction, updated_at!$updatedAt}';
  }
}
