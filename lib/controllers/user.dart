import 'dart:convert';
import 'package:dream_team/screens/utils/constants.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import '../models/user.dart';
import 'package:http/http.dart' as http;

class UserControler with ChangeNotifier {
  late User user;

  setUser(User user) {
    this.user = user;
    notifyListeners();
  }

  Future<bool> signIn(String email, String password) async {
    const url = "${Constants.baseUrl}User/SignIn";
    final response = await http.post(
      Uri.parse(url),
      body: {
        'email': email,
        'password': password,
      },
    );
    if (response.statusCode == 201) {
      final data = jsonDecode(response.body);
      for (var u in data) {
        User user = User(
          name: u['name'],
          email: u['email'],
          birthday: DateTime.parse(u['birthday']),
          leonita: int.parse(u['leonita']),
          ametista: int.parse(u['ametista']),
          password: u['password'],
          nickname: u['nickname'],
          point: int.parse(u['point']),
          sponsorsLeague: u['sponsorsLeague'],
        );
        setUser(user);
      }
      return true;
    }
    return false;
  }

  @override
  String toString() {
    final name = user.name ?? "";
    final email = user.email ?? "";
    final birthday = parseDate(user.birthday);
    final leonita = user.leonita.toString();
    final ametista = user.ametista.toString();
    final password = user.password ?? "";
    final nickname = user.nickname ?? "";
    final point = user.point.toString();
    final leagueid = user.sponsorsLeague.toString();
    return name +
        email +
        birthday +
        leonita +
        ametista +
        password +
        nickname +
        point +
        leagueid;
  }

  Future<bool> signUp() async {
    const url = "${Constants.baseUrl}User/Insert";
    final response = await http.post(
      Uri.parse(url),
      body: {
        'name': user.name,
        'email': user.email,
        'birthday': parseDate(user.birthday),
        'leonita': user.leonita.toString(),
        'ametista': user.ametista.toString(),
        'password': user.password,
        'nickname': user.nickname,
        'point': user.point.toString(),
        'sponsorsLeague': user.sponsorsLeague.toString(),
      },
    );
    if (response.statusCode == 201) {
      notifyListeners();
      return true;
    }
    return false;
  }

  Future<bool> chekExistEmail(String email) async {
    const url = "${Constants.baseUrl}User/CheckEmail";
    final response = await http.post(
      Uri.parse(url),
      body: {
        'email': email,
      },
    );
    if (response.statusCode == 201) {
      return false;
    } else if (response.statusCode == 400) {
      return true;
    } else if (response.statusCode == 500) {
      return false;
    }
    return false;
  }

  String parseDate(DateTime? birthday) {
    if (birthday != null) {
      return "${birthday.year}-${birthday.month < 10 ? "0${birthday.month}" : birthday.month}-${birthday.day < 10 ? "0${birthday.day}" : birthday.day}";
    }
    return "";
  }
}
