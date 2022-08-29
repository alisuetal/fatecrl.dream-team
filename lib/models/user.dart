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

  static Future<bool> vEmail(String email) async {
    final url = "http://192.168.15.7/dream_team_api/vEmail.php?email=$email";
    final response = await http.post(Uri.parse(url),
        body: jsonEncode({
          'email': email,
        }));
    return jsonDecode(response.body);
  }

  Future<bool> vEmailLocal() async {
    return vEmail(email);
  }

  Future<bool> signUp() async {
    final url = "http://192.168.15.7/dream_team_api/insert_signup.php?"
        "name=$name&email=$email&password=$password&birthday=$birthday";
    final response = await http.post(Uri.parse(url),
        body: jsonEncode({
          'name': name,
          'email': email,
          'password': password,
          'brithday': birthday,
        }));
    return jsonDecode(response.body);
  }
}
