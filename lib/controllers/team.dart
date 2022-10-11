import 'dart:convert';
import 'dart:math';

import 'package:dream_team/utils/constants.dart';
import 'package:flutter/cupertino.dart';
import 'package:http/http.dart' as http;

import '../models/player.dart';

class TeamController with ChangeNotifier {
  List _players = [];
  List _tatics = [];

  Future<bool> initTeam(int tatic, String email) async {
    setTatic(tatic);
    loadPlayers(email);
    return true;
  }

  List getPlayersId() {
    List players =
        _players.where((element) => element.runtimeType != int).toList();
    final List ids = players.map((e) {
      if (e.runtimeType != int) {
        Player p = e;
        return p.id;
      }
    }).toList();
    return ids;
  }

  void setTatic(tatic) {
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

  Future<bool> loadPlayers(String email) async {
    _players.clear();
    _players.addAll([0, 1, 2, 3, 4]);
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
        for (int i = 0; i < 5; i++) {
          if (_players.elementAt(i).runtimeType == int) {
            if (player.position.contains(_tatics.elementAt(i).toString())) {
              _players.insert(i, player);
              _players.removeAt(i + 1);
              break;
            }
          }
        }
      }
    }
    notifyListeners();
    return false;
  }

  String getImageUrl(int index) {
    Player player = _players.elementAt(index);
    return player.urlImage;
  }

  int getPrice(int index) {
    Player player = _players.elementAt(index);
    return player.price;
  }

  int getId(int index) {
    Player player = _players.elementAt(index);
    return player.id;
  }

  String getName(int index) {
    Player player = _players.elementAt(index);
    return player.name;
  }

  double getPoints(int index) {
    Player player = _players.elementAt(index);
    return double.parse(player.point.toString());
  }

  String getTeam(int index) {
    Player player = _players.elementAt(index);
    return player.team;
  }

  double getVariation(int index) {
    final player = _players.elementAt(index);

    final point = player.point;
    final rebound = player.rebound;
    final block = player.block;
    final steal = player.steal;
    final assist = player.assist;

    final positive = point + rebound + block + steal + assist;

    final negative = player.missShot + player.turnOver;

    return (positive - negative) / 100;
  }

  List getPlayers() {
    return _players;
  }

  bool isPlayer(int index) {
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
      if (p.runtimeType != int) {
        Player player = p;
        price += player.price;
      }
    }
    return price;
  }

  Future<bool> removePlayer(String email, int playerId, int index) async {
    const url = "${Constants.baseUrl}/Team/RemovePlayer";
    final response = await http.post(
      Uri.parse(url),
      body: {
        'email': email,
        'player': playerId.toString(),
      },
    );
    if (response.statusCode == 201) {
      _players.removeAt(index);
      _players.insert(index, index);
      notifyListeners();
      return true;
    }
    return false;
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
      _players.addAll([0, 1, 2, 3, 4]);
      notifyListeners();
      return true;
    }
    return false;
  }

  String getPosition(int index) {
    return _tatics.elementAt(index);
  }

  int taticSize() {
    return _tatics.length;
  }
}
