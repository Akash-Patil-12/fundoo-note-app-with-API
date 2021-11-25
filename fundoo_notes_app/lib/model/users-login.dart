import 'dart:convert';

import 'package:http/http.dart' as http;

class UserLogin {
  String email;
  String password;
  UserLogin({
    required this.email,
    required this.password,
  });
  factory UserLogin.fromJson(Map<String, dynamic> json) {
    return UserLogin(
        email: json['email'] as String, password: json['password'] as String);
  }
}

Future<bool> loginUser() async {
  var loginUserObject = json.encode({
    'email': "patil@gmail.com",
    'password': "akash123",
  });
  const headers = {'Content-Type': 'application/json'};
  var client = http.Client();
  var responce = await client.post(
      Uri.parse("http://fundoonotes.incubation.bridgelabz.com/api/user/login"),
      headers: headers,
      body: loginUserObject);
  if (responce.statusCode == 200) {
    print(
        "<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<>>>>>>>>>>>>>??????????<");
    print(responce.body);
    return true;
  } else {
    print(',,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,');
    return false;
  }
}
