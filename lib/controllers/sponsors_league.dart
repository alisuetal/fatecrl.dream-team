import 'dart:convert';
import 'dart:math';

import 'package:dream_team/models/sponsors_league.dart';
import 'package:dream_team/screens/utils/constants.dart';
import 'package:flutter/cupertino.dart';
import 'package:http/http.dart' as http;

class SponsorsLeagueControler with ChangeNotifier {
  List<SponsorsLeague> _leagues = [];

  Future<void> loudLeagues() async {
    _leagues.clear();
    const url = "${Constants.baseUrl}SponsorsLeague/Select";
    final response = await http.get(Uri.parse(url));

    if (response.statusCode == 201) {
      final data = jsonDecode(response.body);

      for (var l in data) {
        SponsorsLeague league = SponsorsLeague(
          id: l['id'],
          name: l['name'],
        );
        _leagues.add(league);
      }
    }
    notifyListeners();
  }

  Map<int, String> getLeague() {
    Map<int, String> leaguesMap = {};
    for (var league in _leagues) {
      leaguesMap[league.id] = league.name;
    }
    return leaguesMap;
  }
}
