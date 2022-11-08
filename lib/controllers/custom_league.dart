import 'dart:convert';
import 'dart:ffi';
import 'dart:math';

import 'package:dream_team/models/custom_league.dart';
import 'package:dream_team/utils/constants.dart';
import 'package:flutter/cupertino.dart';
import 'package:http/http.dart' as http;

class CustomLeagueController with ChangeNotifier {
  final List<CustomLeague> _leagues = [];

  int countLeagues() {
    print(_leagues.length);
    return _leagues.length;
  }

  String getNameIndex(int index) {
    return _leagues.elementAt(index).name;
  }

  Future<bool> getCustomLeague(String email) async {
    final url = "${Constants.baseUrl}CustomLeague/GetLeagueUser?email=$email";
    final response = await http.get(
      Uri.parse(url),
    );
    if (response.statusCode == 201) {
      final data = jsonDecode(response.body);
      for (var l in data) {
        CustomLeague league = CustomLeague(
          id: int.parse(l['id']),
          name: l['name'],
          rounds: int.parse(l['rounds']),
          members: int.parse(l['userLength']),
          private: int.parse(l['private']) == 1,
          privateId: l['code'],
        );
        _leagues.add(league);
      }
      notifyListeners();
      return true;
    }
    return false;
  }
}
