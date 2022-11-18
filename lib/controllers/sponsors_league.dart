import 'dart:convert';
import 'dart:math';
import 'package:dream_team/models/sponsors_league_member.dart';
import 'package:dream_team/models/sponsors_league.dart';
import 'package:dream_team/utils/constants.dart';
import 'package:flutter/cupertino.dart';
import 'package:http/http.dart' as http;

class SponsorsLeagueController with ChangeNotifier {
  final List<SponsorsLeague> _leagues = [];
  final List<LeagueMember> _members = [];

  int length() {
    return _leagues.length;
  }

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

  bool isHisLeague(int index, int id) {
    return _leagues.elementAt(index).id == id;
  }

  String getLeagueNameIndex(int index) {
    return _leagues.elementAt(index).name;
  }

  String getLeagueNameId(int id) {
    int index = _leagues.indexWhere((league) => league.id == id);
    return _leagues.elementAt(index).name;
  }

  int getLeagueId(int index) {
    return _leagues.elementAt(index).id;
  }

  Future<void> getLeagueMembers(int sponsorLeague) async {
    _members.clear();
    const url = "${Constants.baseUrl}SponsorsLeague/GetLeagueMembers";
    final response = await http.post(
      Uri.parse(url),
      body: {
        'sponsorLeague': sponsorLeague.toString(),
      },
    );

    if (response.statusCode == 201) {
      final data = jsonDecode(response.body);

      for (var m in data) {
        LeagueMember member = LeagueMember(
          nickname: m['nickname'],
          points: int.parse(m['point']),
          position: int.parse(m['position']),
        );
        _members.add(member);
      }
    }
    notifyListeners();
  }

  int getMembersLength() {
    return _members.length;
  }

  String getMemberNickname(int index) {
    return _members.elementAt(index).nickname ?? "";
  }

  int getMemberPoints(int index) {
    return _members.elementAt(index).points ?? 0;
  }

  int getMemberPosition(int index) {
    return _members.elementAt(index).position ?? 0;
  }
}
