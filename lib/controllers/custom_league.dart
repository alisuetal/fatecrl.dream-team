import 'dart:convert';
import 'package:dream_team/models/custom_league.dart';
import 'package:dream_team/models/sponsors_league_member.dart';
import 'package:dream_team/utils/constants.dart';
import 'package:flutter/cupertino.dart';
import 'package:http/http.dart' as http;

class CustomLeagueController with ChangeNotifier {
  final List<CustomLeague> _leagues = [];
  final List<LeagueMember> _members = [];
  final List<CustomLeague> _openLeagues = [];
  List<CustomLeague> _duplcateOpenLeagues = [];

  Future<void> preLoad(String email) async {
    await loadOpenLeagues(email);
    searchLeagues("");
    notifyListeners();
  }

  void searchLeagues(String code) {
    List<CustomLeague> dummySearchList = [];
    dummySearchList.addAll(_duplcateOpenLeagues);
    if (code.isNotEmpty) {
      _openLeagues.clear();
      _openLeagues.addAll(
          dummySearchList.where((CustomLeague c) => c.privateId == code));
      return;
    } else {
      _openLeagues.clear();
      _openLeagues.addAll(_duplcateOpenLeagues);
    }
    notifyListeners();
  }

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
    try {
      return _leagues.where((l) => l.id == id).first.name;
    } catch (e) {
      return _openLeagues.where((l) => l.id == id).first.name;
    }
  }

  String getCreatorNameId(int id) {
    try {
      return _leagues.where((l) => l.id == id).first.creator;
    } catch (e) {
      return _openLeagues.where((l) => l.id == id).first.creator;
    }
  }

  String getCodeId(int id) {
    try {
      return _leagues.where((l) => l.id == id).first.privateId;
    } catch (e) {
      return _openLeagues.where((element) => element.id == id).first.privateId;
    }
  }

  double getUserPointsId(int id) {
    try {
      return double.parse(
          _leagues.where((l) => l.id == id).first.userPoints.toString());
    } catch (e) {
      return double.parse(
          _openLeagues.where((l) => l.id == id).first.members.toString());
    }
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

  String getOpenLeagueNameIndex(int index) {
    return _openLeagues.elementAt(index).name;
  }

  String getOpenLeagueCreatorIndex(int index) {
    return _openLeagues.elementAt(index).creator;
  }

  int getOpenLeagueMembersIndex(int index) {
    return _openLeagues.elementAt(index).players;
  }

  String getOpenLeagueMembersId(int id) {
    return _openLeagues
        .where((element) => element.id == id)
        .first
        .players
        .toString();
  }

  int openLeaguesLength() {
    return _openLeagues.length;
  }

  int getOpenLeagueId(int index) {
    return _openLeagues.elementAt(index).id;
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
          entry: int.parse(l['entry']),
          players: int.parse(l['players']),
        );
        _leagues.add(league);
      }
      notifyListeners();
      return true;
    }
    return false;
  }

  bool isPrivate(int id) {
    if (_leagues.where((l) => l.id == id).isEmpty) {
      return false;
    }
    return true;
  }

  String getEntryValueId(int id) {
    return _openLeagues.where((l) => l.id == id).first.entry.toString();
  }

  Future<bool> loadOpenLeagues(String email) async {
    _duplcateOpenLeagues.clear();
    final url = "${Constants.baseUrl}CustomLeague/GetOpenLeagues?email=$email";
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
          entry: int.parse(l['entry']),
          players: int.parse(l['players']),
        );
        _duplcateOpenLeagues.add(league);
      }
      notifyListeners();
      return true;
    }
    return false;
  }

  Future<bool> addUser(String email, int id) async {
    const url = "${Constants.baseUrl}CustomLeague/AddUser";
    final response = await http.post(
      Uri.parse(url),
      body: {
        'email': email,
        'leagueId': id.toString(),
      },
    );
    if (response.statusCode == 201) {
      _leagues.add(_openLeagues.where((l) => l.id == id).first);
      _duplcateOpenLeagues.removeWhere((l) => l.id == id);
      searchLeagues("");
      notifyListeners();
      return true;
    }
    return false;
  }

  Future<bool> removeUser(String email, int id) async {
    const url = "${Constants.baseUrl}CustomLeague/RemoveUser";
    final response = await http.post(
      Uri.parse(url),
      body: {
        'email': email,
        'leagueId': id.toString(),
      },
    );
    if (response.statusCode == 201) {
      _duplcateOpenLeagues.add(_leagues.where((l) => l.id == id).first);
      _leagues.removeWhere((l) => l.id == id);
      searchLeagues("");
      notifyListeners();
      return true;
    }
    return false;
  }
}
