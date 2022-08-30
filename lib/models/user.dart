import 'dart:convert';
import 'dart:math';
import 'package:http/http.dart' as http;

class User {
  final String name;
  final String email;
  final String password;
  final DateTime birthday;

  User({
    required this.name,
    required this.email,
    required this.password,
    required this.birthday,
  });

  Future<bool> signUp() async {
    final url = "http://192.168.15.7/dream_team_api/insert_usuario.php";

    final response = await http.post(
      Uri.parse(url),
      body: {
        'name': name,
        'email': email,
        'password': password,
        'birthday': parseDate(),
      },
    );

    final data = jsonDecode(response.body);
    print(data['result']);
    // if (!data["error"]) {
    //   return data["result"];
    // }

    return false;
  }

  static Future<bool> vEmail(String email) async {
    final url = "http://192.168.15.7/dream_team_api/vEmail.php";

    final response = await http.post(
      Uri.parse(url),
      body: {
        'email': email,
      },
    );

    final data = jsonDecode(response.body);

    if (!data["error"]) {
      return data["result"];
    }

    return false;
  }

  Future<bool> vEmailLocal() async {
    return vEmail(email);
  }

  @override
  String toString() {
    return name + email + password + parseDate();
  }

  String parseDate() {
    return "${birthday.year}-${birthday.month < 10 ? "0${birthday.month}" : birthday.month}-${birthday.day}";
  }
}
