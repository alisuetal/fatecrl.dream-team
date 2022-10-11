import 'dart:convert';

import 'package:dream_team/models/player.dart';
import 'package:dream_team/utils/constants.dart';
import 'package:flutter/cupertino.dart';
import 'package:http/http.dart' as http;

class PlayerController with ChangeNotifier {
  List<Player> _players = [];
  List<Player> _duplciatePlayers = [];

  void searchPlayers(String name) {
    List<Player> dummySearchList = [];
    dummySearchList.addAll(_duplciatePlayers);
    if (name.isNotEmpty) {
      List<Player> dummyListData = [];
      dummySearchList.forEach((Player p) {
        if (p.name.contains(name)) {
          dummyListData.add(p);
        }
      });
      _players.clear();
      _players.addAll(dummyListData);
      return;
    } else {
      _players.clear();
      _players.addAll(_duplciatePlayers);
    }
  }

  Future<void> preLoad(String position, List playerIds) async {
    await loadPlayers(position);
    for (int id in playerIds) {
      _players.removeWhere((Player p) => p.id == id);
    }
  }

  Future<void> loadPlayers(String position) async {
    _players.clear();
    const url = "${Constants.baseUrl}Player/Select";
    final response = await http.post(
      Uri.parse(url),
      body: {
        'position': position,
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
  }

  int sizePlayers() {
    return _players.length;
  }

  String getImageUrl(int index) {
    return _players.elementAt(index).urlImage;
  }

  int getPrice(int index) {
    return _players.elementAt(index).price;
  }

  String getName(int index) {
    return _players.elementAt(index).name;
  }

  double getPoints(int index) {
    return double.parse(_players.elementAt(index).point.toString());
  }

  String getTeam(int index) {
    return _players.elementAt(index).team;
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

  Player getPlayer(int index) {
    return _players.elementAt(index);
  }

  List<Player> getPlayersList() {
    return _players;
  }
}
