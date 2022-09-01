import 'dart:convert';
import 'dart:math';
import 'package:dream_team/screens/utils/constants.dart';
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

  static Future<bool> signIn(String email, String password) async {
    final response = await http.post(
      Uri.parse(Constants.baseUrl),
      body: {
        'email': email,
        'password': password,
      },
    );

    if (response.statusCode == 200) {
      //cadastro realizado com sucesso
      final data = jsonDecode(response.body);
      User user = User(
        name: data['name'],
        email: data['email'],
        password: data['password'],
        birthday: DateTime.parse(data['birthday']),
      );
      print(user.toString());
      return true;
    } else if (response.statusCode == 400) {
      //erro ao inserir
    } else if (response.statusCode == 500) {
      //erro no sql
    }
    return false;
  }

  @override
  String toString() {
    return name + email + password + birthday.toString();
  }

  Future<bool> signUp() async {
    final response = await http.post(
      Uri.parse(Constants.baseUrl),
      body: {
        'name': name,
        'email': email,
        'password': password,
        'birthday': parseDate(birthday),
      },
    );

    if (response.statusCode == 200) {
      //cadastro realizado com sucesso
      final data = jsonDecode(response.body);
      print(data);
      return true;
    } else if (response.statusCode == 400) {
      //erro ao inserir
    } else if (response.statusCode == 500) {
      //erro no sql
    }
    return false;
  }

  static Future<bool> chekExistEmail(String email) async {
    final url = "${Constants.baseUrl}?email=$email";

    final response = await http.get(Uri.parse(url));
    if (response.statusCode == 200) {
      //email encontrado
      final data = jsonDecode(response.body);
      print(data);
      return true;
    } else if (response.statusCode == 400) {
      //email não encontrado
    } else if (response.statusCode == 500) {
      //erro no sql
    }
    return false;
  }

  Future<bool> chekExistEmailLocal() async {
    return chekExistEmail(email);
  }

  String parseDate(DateTime birthday) {
    return "${birthday.year}-${birthday.month < 10 ? "0${birthday.month}" : birthday.month}-${birthday.day < 10 ? "0${birthday.day}" : birthday.day}";
  }
}
