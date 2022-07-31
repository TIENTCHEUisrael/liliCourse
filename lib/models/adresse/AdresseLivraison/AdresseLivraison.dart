class AdressLiv {
  int? adressLivId;
  String localisationLiv;
  String nameRecepteur;
  int contactRecepteur;
  String emailRecepteur;
  String civiliteRecepteur;
  String instruction;
  String? updatedAt;

  AdressLiv(
      {this.adressLivId,
      required this.localisationLiv,
      required this.nameRecepteur,
      required this.contactRecepteur,
      required this.emailRecepteur,
      required this.civiliteRecepteur,
      required this.instruction,
      this.updatedAt});

  factory AdressLiv.fromJson(dynamic json) {
    return AdressLiv(
      adressLivId: json['adresse_liv_id'] as int,
      localisationLiv: json['localisationLiv'] as String,
      nameRecepteur: json['name_recepteur'] as String,
      contactRecepteur: json['contact_recepteur'] as int,
      emailRecepteur: json['email_recepteur'] as String,
      civiliteRecepteur: json['civilite_recepteur'] as String,
      instruction: json['instruction'] as String,
      updatedAt: json['updated_at'] as String,
    );
  }

  Map<String, dynamic> toJson() => {
        "localisationLiv": localisationLiv,
        "name_recepteur": nameRecepteur,
        "contact_recepteur": contactRecepteur,
        "email_recepteur": emailRecepteur,
        "civilite_recepteur": civiliteRecepteur,
        "instruction": instruction,
        "updated_at": updatedAt,
      };

  static List<AdressLiv> adressRamFromSnapshot(List snapshot) {
    return snapshot.map((data) => AdressLiv.fromJson(data)).toList();
  }

  @override
  String toString() {
    return 'AdressRam {adresse_liv_id:$adressLivId,localisationLiv: $localisationLiv, name_recepteur: $nameRecepteur, contact_recepteur: $contactRecepteur, email_recepteur: $emailRecepteur,civilite_recepteur:$civiliteRecepteur, instruction:$instruction, updated_at!$updatedAt}';
  }
}
