import 'dart:convert';

import 'package:http/http.dart' as http;

class Users {
  String firstName;
  String lastName;
  //String phoneNumber;
  // String imageUrl;
  String role;
  String service;
  String createdDate;
  String modifiedDate;
  String username;
  String email;
  bool emailVerified;
  String id;
  Users(
      {required this.firstName,
      required this.lastName,
      // required this.phoneNumber,
      // required this.imageUrl,
      required this.role,
      required this.service,
      required this.createdDate,
      required this.modifiedDate,
      required this.username,
      required this.email,
      required this.emailVerified,
      required this.id});
  factory Users.fromJson(Map<String, dynamic> json) {
    return Users(
        firstName: json['firstName'] as String,
        lastName: json['lastName'] as String,
        //  phoneNumber: json['phoneNumber'] as String,
        //imageUrl: json['imageUrl'] as String,
        role: json['role'] as String,
        service: json['service'] as String,
        createdDate: json['createdDate'] as String,
        modifiedDate: json['modifiedDate'] as String,
        username: json['username'] as String,
        email: json['email'] as String,
        emailVerified: json['emailVerified'] as bool,
        id: json['id'] as String);
  }
}

Future<List<Users>> getUsers() async {
  List<Users> UsersJsonData = [];
  var url = Uri.parse('http://fundoonotes.incubation.bridgelabz.com/api/user');
  var client = http.Client();
  var responce = await client.get(url);
  if (responce.statusCode == 200) {
    var userData = jsonDecode(responce.body);
    print(userData);
    for (var user in userData) {
      print("ggggggggggggggggggggggg");
      print(user);
      // user['firestName'];
      UsersJsonData.add(Users.fromJson(user));
    }
  }
  print("<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<>>>>>>>>>>>>>??????????<");
  print(responce.body);

  return UsersJsonData;
}
