import 'dart:convert';
import 'package:dream_team/utils/constants.dart';
import 'package:flutter/cupertino.dart';
import '../models/user.dart';
import 'package:http/http.dart' as http;

class UserController with ChangeNotifier {
  late User user;

  setUser(User user) {
    this.user = user;
    notifyListeners();
  }

  Future<bool> upDateLeonita(int leonita) async {
    const url = "${Constants.baseUrl}User/UpdateLeonitas";
    final response = await http.post(
      Uri.parse(url),
      body: {
        'email': user.email,
        'leonitas': leonita.toString(),
      },
    );
    if (response.statusCode == 201) {
      user.leonita = leonita;
      return true;
    }
    return false;
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
        'tatic': user.tatic.toString(),
        'sponsorsLeague': user.sponsorsLeague.toString(),
      },
    );
    if (response.statusCode == 201) {
      user.position = await getPosition(user.nickname!, user.sponsorsLeague!);
      notifyListeners();
      return true;
    }
    return false;
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
        final position = await getPosition(u['nickname'], u['sponsorsLeague']);
        User user = User(
          name: u['name'],
          email: u['email'],
          birthday: DateTime.parse(u['birthday']),
          leonita: int.parse(u['leonita']),
          ametista: int.parse(u['ametista']),
          password: u['password'],
          nickname: u['nickname'],
          point: int.parse(u['point']),
          tatic: int.parse(u['tatic']),
          sponsorsLeague: u['sponsorsLeague'],
          position: position,
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

  Future<bool> checkExistEmail(String email) async {
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

  Future<User?> getUser(String email) async {
    String url = "${Constants.baseUrl}User/GetUser?email=$email";
    final response = await http.get(
      Uri.parse(url),
    );
    if (response.statusCode == 201) {
      final data = jsonDecode(response.body);

      for (var u in data) {
        final position = await getPosition(u['nickname'], u['sponsorsLeague']);
        User user = User(
          name: u['name'],
          email: u['email'],
          birthday: DateTime.parse(u['birthday']),
          leonita: int.parse(u['leonita']),
          ametista: int.parse(u['ametista']),
          password: u['password'],
          nickname: u['nickname'],
          point: int.parse(u['point']),
          tatic: int.parse(u['tatic']),
          sponsorsLeague: u['sponsorsLeague'],
          position: position,
        );
        setUser(user);
      }
      return user;
    } else if (response.statusCode == 400) {
      return null;
    } else if (response.statusCode == 500) {
      return null;
    }
    return null;
  }

  Future<int> getPosition(String nickname, int sponsorLeague) async {
    String url = "${Constants.baseUrl}User/GetUserPosition";
    final response = await http.post(
      Uri.parse(url),
      body: {
        'sponsorLeague': sponsorLeague.toString(),
        'nickname': nickname,
      },
    );
    if (response.statusCode == 201) {
      final data = jsonDecode(response.body);
      return data[0];
    }
    return 0;
  }

  Future<bool> changeNickname(String email, String nickname) async {
    const url = "${Constants.baseUrl}User/ChangeNickname";
    final response = await http.post(
      Uri.parse(url),
      body: {
        'email': email,
        'nickname': nickname,
      },
    );
    print(response.statusCode);
    if (response.statusCode == 204) {
      user.nickname = nickname;
      notifyListeners();
      return true;
    }
    return false;
  }

  Future<bool> changeEmail(String email, String newEmail) async {
    const url = "${Constants.baseUrl}User/ChangeEmail";
    final response = await http.post(
      Uri.parse(url),
      body: {
        'email': email,
        'newEmail': newEmail,
      },
    );
    if (response.statusCode == 204) {
      user.email = newEmail;
      notifyListeners();
      return true;
    }
    return false;
  }

  Future<bool> changePassword(String email, String password) async {
    const url = "${Constants.baseUrl}User/ChangePassword";
    final response = await http.post(
      Uri.parse(url),
      body: {
        'email': email,
        'password': password,
      },
    );
    if (response.statusCode == 204) {
      user.password = password;
      notifyListeners();
      return true;
    }
    return false;
  }

  Future<bool> changeTatic(String email, int tatic) async {
    const url = "${Constants.baseUrl}User/UpdateTatic";
    final response = await http.post(
      Uri.parse(url),
      body: {
        'email': email,
        'tatic': tatic.toString(),
      },
    );
    if (response.statusCode == 201) {
      user.tatic = tatic;
      notifyListeners();
      return true;
    }
    return false;
  }

  int getLeague() {
    return user.sponsorsLeague ?? 0;
  }

  double getPoint() {
    return double.parse(user.point.toString());
  }
}
