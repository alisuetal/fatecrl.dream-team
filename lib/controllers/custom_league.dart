import 'dart:convert';
import 'dart:math';

import 'package:dream_team/models/custom_league.dart';
import 'package:dream_team/models/public_league.dart';
import 'package:dream_team/models/sponsors_league_member.dart';
import 'package:dream_team/utils/constants.dart';
import 'package:flutter/cupertino.dart';
import 'package:http/http.dart' as http;

class CustomLeagueController with ChangeNotifier {
  final List<CustomLeague> _leagues = [];
  final List<LeagueMember> _members = [];
  final List<PublicLeague> _publicLeagues = [];

  int countLeagues() {
    return _leagues.length;
  }

  String getNameIndex(int index) {
    return _leagues.elementAt(index).name;
  }

  String getCreatorNameIndex(int index) {
    return _leagues.elementAt(index).creator;
  }

  int getUserPointsIndex(int index) {
    return _leagues.elementAt(index).userPoints;
  }

  int getLeagueId(int index) {
    return _leagues.elementAt(index).id;
  }

  String getLeagueNameId(int id) {
    return _leagues.where((l) => l.id == id).first.name;
  }

  String getCreatorNameId(int id) {
    return _leagues.where((l) => l.id == id).first.creator;
  }

  double getUserPointsId(int id) {
    return double.parse(
        _leagues.where((l) => l.id == id).first.userPoints.toString());
  }

  int memberLength() {
    return _members.length;
  }

  String getMemberPosition(int index) {
    return _members.elementAt(index).position.toString();
  }

  String getMemberNickname(int index) {
    return _members.elementAt(index).nickname!;
  }

  String getMemberPoints(int index) {
    return _members.elementAt(index).points.toString();
  }

  Future<void> getLeagueMembers(int customLeague) async {
    _members.clear();
    final url =
        "${Constants.baseUrl}CustomLeague/GetLeagueMembers?customLeague=$customLeague";
    final response = await http.get(
      Uri.parse(url),
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

  Future<int> getUserPosition(String email, int i, bool isIndex) async {
    final league = isIndex ? _leagues.elementAt(i).id : i;
    final url =
        "${Constants.baseUrl}CustomLeague/GetUserPosition?email=$email&league=$league";
    final response = await http.get(
      Uri.parse(url),
    );
    if (response.statusCode == 201) {
      final data = jsonDecode(response.body);
      notifyListeners();
      return data[0];
    }
    return 0;
  }

  String getPublicLeagueNameIndex(int index) {
    return _publicLeagues.elementAt(index).name;
  }

  String getPublicLeagueCreatorIndex(int index) {
    return _publicLeagues.elementAt(index).creator;
  }

  int getPublicLeagueMembersIndex(int index) {
    return _publicLeagues.elementAt(index).members;
  }

  int publicLeaguesLength() {
    return _publicLeagues.length;
  }

  int getPublicLeagueId(int index) {
    return _publicLeagues.elementAt(index).id;
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
          userPoints: int.parse(l['points']),
          creator: l['creator'],
        );
        _leagues.add(league);
      }
      notifyListeners();
      return true;
    }
    return false;
  }

  Future<bool> loadPublicLeagues() async {
    _publicLeagues.clear();
    const url = "${Constants.baseUrl}CustomLeague/GetPublicLeagues";
    final response = await http.get(
      Uri.parse(url),
    );
    if (response.statusCode == 201) {
      final data = jsonDecode(response.body);
      for (var l in data) {
        PublicLeague public = PublicLeague(
          id: int.parse(l['id']),
          name: l['name'],
          members: int.parse(l['userLength']),
          creator: l['creator'],
        );
        _publicLeagues.add(public);
      }
      notifyListeners();
      return true;
    }
    return false;
  }
}
