import 'dart:convert';

import 'package:http/http.dart' as http;

class UserLogin {
  String firstName;
  String lastName;
  String password;
  String email;
  String service;
  UserLogin(
      {required this.firstName,
      required this.lastName,
      required this.email,
      required this.password,
      required this.service});
  factory UserLogin.fromJson(Map<String, dynamic> json) {
    return UserLogin(
        firstName: json['firstName'] as String,
        lastName: json['lastName'] as String,
        email: json['email'] as String,
        password: json['password'] as String,
        service: json['service'] as String);
  }
}

Future<bool> userSignup(firstName, lastName, email, password) async {
  var loginUserObject = json.encode({
    'firstName': firstName,
    'lastName': lastName,
    'email': email,
    'password': password,
    'service': "advance"
  });
  const headers = {'Content-Type': 'application/json'};
  var client = http.Client();
  var responce = await client.post(
      Uri.parse(
          "http://fundoonotes.incubation.bridgelabz.com/api/user/userSignUp"),
      headers: headers,
      body: loginUserObject);
  if (responce.statusCode == 200) {
    print(
        "<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<hhhhhhhhhhhhhhhhhhhh>>>>>>>>>>>>>??????????<");
    print(responce.body);
    return true;
  } else {
    print(',,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,');
    return false;
  }
}
