import 'dart:convert';
import 'dart:async';
import 'package:flutter/widgets.dart';
import 'package:http/http.dart' as http;
import 'package:lilicourse/models/adresse/AdresseLivraison/AdresseLivraison.dart';
import 'package:lilicourse/models/adresse/AdresseRamassage/AdresseRamassage.dart';
import 'package:lilicourse/models/commande/commande.dart';
import 'package:lilicourse/models/commande/sharedCommande.dart';

import '../models/adresse/Adresse/Adresse.dart';
import '../models/paiement/Paiement.dart';
import '../services/service.dart';

enum Statut {
  getting,
  notget,
  getted,
  registing,
  registed,
  notregisted,
  updating,
  updated,
  notupdated,
  deleting,
  deleted,
  notdeleted,
}

class CommProvider extends ChangeNotifier {
  Commande? _commande;
  List<Commande> _commandes = [];
  List<Paiement> _paiements = [];
  List<Adresse> _adresses = [];
  int? _id;
  String? _name;
  Statut _registerStatus = Statut.notregisted;
  Statut _deleteStatus = Statut.notdeleted;
  Statut _updateStatus = Statut.notupdated;
  Statut _getStatuts = Statut.notget;

  Commande get commande {
    return _commande!;
  }

  int get id {
    return _id!;
  }

  String get name {
    return _name!;
  }

  void setCommande(Commande co) {
    co = _commande!;
    notifyListeners();
  }

  Statut get registerStatus => _registerStatus;
  set registerStatus(Statut value) {
    _registerStatus = value;
  }

  Statut get getSatut => _getStatuts;
  set getStatut(Statut value) {
    _getStatuts = value;
  }

  Statut get deleteStatus => _deleteStatus;
  set deleteStatus(Statut value) {
    _deleteStatus = value;
  }

  Statut get updateStatus => _updateStatus;
  set updateStatus(Statut value) {
    _updateStatus = value;
  }

  Future<Map<String, dynamic>> getCommandeById(int id) async {
    var result;
    var urlcre = Uri.parse(
        '${Api_services.httpbaseUrl2}/lilicourse/commande/get?id=$id');
    try {
      _getStatuts = Statut.getting;
      notifyListeners();

      final response = await http.get(urlcre);

      if (response.statusCode == 200) {
        var data = jsonDecode(response.body);
        _getStatuts = Statut.getted;
        _commande = Commande.fromJson(data);
        CommandePreference.saveCommandeToSharePreferences(data);
        notifyListeners();

        result = {
          "statut": true,
          "message": "Commande getted",
          "commande": _commande!
        };
      } else {
        _registerStatus = Statut.notregisted;
        notifyListeners();
        result = {"statut": false, "message": "Commande not getted"};
      }
    } catch (e) {
      print(e);
    }
    return result;
  }

  Future<Map<String, dynamic>> getCommandesPaiements() async {
    var result;
    List _temp = [];
    List _tem = [];
    List _add = [];

    var urlpaiement =
        Uri.parse('${Api_services.httpbaseUrl2}/lilicourse/paiements');
    try {
      final responsePaiement = await http.get(urlpaiement);
      if (responsePaiement.statusCode == 200) {
        var data = jsonDecode(responsePaiement.body);
        for (var i in data) {
          _temp.add(i);
        }
        _paiements = Paiement.paiementFromSnapshot(_temp);
        notifyListeners();

        var urlcommande =
            Uri.parse('${Api_services.httpbaseUrl2}/lilicourse/commandes');

        final responseCommande = await http.get(urlcommande);
        if (responseCommande.statusCode == 200) {
          var data2 = jsonDecode(responseCommande.body);
          for (var i in data2) {
            for (var j in data) {
              if (i['commande_id'] == j['paiement_id']) {
                _tem.add(i);
              }
            }
          }
          _commandes = Commande.recipesFromSnapshot(_tem);
          notifyListeners();

          var urladress =
              Uri.parse('${Api_services.httpbaseUrl2}/lilicourse/adress');
          final responseAdress = await http.get(urladress);

          if (responseAdress.statusCode == 200) {
            var data3 = jsonDecode(responseAdress.body);
            for (var i in data2) {
              for (var j in data) {
                for (var k in data3) {
                  if (i['commande_id'] == j['paiement_id']) {
                    if (i['adresse_id'] == k['adresse_id']) {
                      _add.add(k);
                    }
                  }
                }
              }
            }
            _adresses = Adresse.adressFromSnapshot(_add);
            notifyListeners();
            result = {
              "statut": true,
              "message": "get successfully",
              "paiements": _paiements,
              "commandes": _commandes,
              "adresses": _adresses,
            };
          }
        }
      }
    } catch (e) {
      print(e);
    }
    return result;
  }

  Future<Map<String, dynamic>> createACommande(Commande com) async {
    var result;
    var urlcre =
        Uri.parse('${Api_services.httpbaseUrl2}/lilicourse/commande/add');
    Map<String, String> header = {"Content-Type": "application/json"};
    try {
      _registerStatus = Statut.registing;
      notifyListeners();

      final response = await http.post(
        urlcre,
        headers: header,
        body: jsonEncode(
          com.toJson(),
        ),
      );

      if (response.statusCode == 200) {
        var data = jsonDecode(response.body);
        _registerStatus = Statut.registed;
        _commande = Commande.fromJson(data);
        CommandePreference.saveCommandeToSharePreferences(data);
        notifyListeners();

        result = {
          "statut": true,
          "message": "Commande added",
          "commande": _commande!
        };
      } else {
        _registerStatus = Statut.notregisted;
        notifyListeners();
        result = {"statut": false, "message": "Commande not added"};
      }
    } catch (e) {
      print(e);
    }
    return result;
  }

  Future<Map<String, dynamic>> updateCommande(Commande com) async {
    var result;
    var urlput = Uri.parse(
        '${Api_services.httpbaseUrl2}/lilicourse/adress/put?id=${com.commandeId}');
    Map<String, String> header = {"Content-Type": "application/json"};
    try {
      _registerStatus = Statut.updating;
      notifyListeners();

      final response = await http.put(
        urlput,
        headers: header,
        body: jsonEncode(
          com.toJson(),
        ),
      );

      if (response.statusCode == 200) {
        var data = jsonDecode(response.body);
        print('$data.......................');
        _registerStatus = Statut.updated;
        _commande = Commande.fromJson(data);
        CommandePreference.saveCommandeToSharePreferences(data);
        notifyListeners();

        result = {
          "statut": true,
          "message": "Commande updated",
          "commande": _commande!
        };
      } else {
        _registerStatus = Statut.notupdated;
        notifyListeners();
        result = {"statut": false, "message": "Adress not updated"};
      }
    } catch (e) {
      print(e);
    }
    return result;
  }
}
