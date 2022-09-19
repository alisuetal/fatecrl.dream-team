import 'dart:convert';

import 'package:dream_team/utils/constants.dart';
import 'package:flutter/cupertino.dart';
import 'package:http/http.dart' as http;

import '../models/player.dart';

class TeamController with ChangeNotifier {
  List _players = [0, 1, 2, 3, 4];
  List _tatics = [];

  Future<bool> loadPlayers(String email) async {
    const url = "${Constants.baseUrl}Team/LoadPlayers";
    final response = await http.post(
      Uri.parse(url),
      body: {
        'email': email,
      },
    );
    if (response.statusCode == 201) {
      final data = jsonDecode(response.body);
      for (var p in data) {
        Player player = Player(
          id: int.parse(p['id']),
          name: p['name'],
          position: p['position'],
          point: int.parse(p['point']),
          rebound: int.parse(p['rebound']),
          block: int.parse(p['block']),
          steal: int.parse(p['steal']),
          assist: int.parse(p['assist']),
          missShot: int.parse(p['missShot']),
          turnOver: int.parse(p['turnOver']),
          urlImage: p['imgUrl'],
          price: int.parse(p['price']),
          team: p['team'],
        );

        _players.add(player);
      }
    }
    notifyListeners();
    return false;
  }

  TeamController() {
    (setTatic(0));
  }

  List getPlayers() {
    return _players;
  }

  bool checkPlayer(int index) {
    try {
      if (_players.elementAt(index) != index) {
        return true;
      }
      return false;
    } catch (e) {
      return false;
    }
  }

  Future<bool> addPlayer(int index, Player player, String email) async {
    const url = "${Constants.baseUrl}/Team/AddPlayer";
    final response = await http.post(
      Uri.parse(url),
      body: {
        'player': player.id.toString(),
        'email': email,
        'datetime': DateTime.now().toString().substring(0, 19),
      },
    );
    if (response.statusCode == 201) {
      _players.removeAt(index);
      _players.insert(index, player);
      notifyListeners();
      return true;
    }
    notifyListeners();
    return false;
  }

  int teamValue() {
    var price = 0;
    for (var p in _players) {
      Player player = p;
      price += player.price;
    }
    return price;
  }

  Future<bool> clearPlayers(String email) async {
    const url = "${Constants.baseUrl}/Team/ClearPlayers";
    final response = await http.post(
      Uri.parse(url),
      body: {
        'email': email,
      },
    );
    if (response.statusCode == 201) {
      _players.clear();
      notifyListeners();
      return true;
    }
    return false;
  }

  String getPosition(int index) {
    return _tatics.elementAt(index);
  }

  void setTatic(int tatic) {
    _tatics.clear();
    switch (tatic) {
      case 0:
        _tatics.add("Ala");
        _tatics.add("Ala");
        _tatics.add("Ala");
        _tatics.add("Armador");
        _tatics.add("Pivô");
        break;
      case 1:
        _tatics.add("Ala");
        _tatics.add("Ala");
        _tatics.add("Armador");
        _tatics.add("Armador");
        _tatics.add("Pivô");
        break;
      case 2:
        _tatics.add("Ala");
        _tatics.add("Ala");
        _tatics.add("Armador");
        _tatics.add("Pivô");
        _tatics.add("Pivô");
        break;
      case 3:
        _tatics.add("Ala");
        _tatics.add("Armador");
        _tatics.add("Armador");
        _tatics.add("Armador");
        _tatics.add("Pivô");
        break;
      case 4:
        _tatics.add("Ala");
        _tatics.add("Armador");
        _tatics.add("Armador");
        _tatics.add("Pivô");
        _tatics.add("Pivô");
        break;
      case 5:
        _tatics.add("Ala");
        _tatics.add("Armador");
        _tatics.add("Pivô");
        _tatics.add("Pivô");
        _tatics.add("Pivô");
        break;
    }
    notifyListeners();
  }

  int taticSize() {
    return _tatics.length;
  }
}
