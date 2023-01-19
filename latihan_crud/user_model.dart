import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class UserModel {
  final int id;
  final String name;
  final String email;
  final String gender;

  const UserModel(
      {required this.id,
      required this.name,
      required this.email,
      required this.gender});

  factory UserModel.fromJson(Map<String, dynamic> json) {
    return UserModel(
        id: json['id'],
        name: json['name'],
        email: json['email'],
        gender: json['gender']);
  }
}



Future<List<UserModel>> getAllUser() async {
  final response =
      await http.get(Uri.parse('http://192.168.144.20:8081/api/user/getAll'));
  print(response.body);
  Iterable i = jsonDecode(response.body);
  List<UserModel> usersData =
      List<UserModel>.from(i.map((e) => UserModel.fromJson(e)));
  if (response.statusCode == 200) {
    return usersData;
  } else {
    throw Exception('Failed to load data');
  }
}

// Future<http.Response> createUser(UserModel data) {
//   return http.post(Uri.parse('http://${ipAddress}:8081/api/user/insertUser'),
//       headers: <String, String>{
//         'Content-Type': 'application/json; charset=UTF-8',
//       },
//       body: jsonEncode(<String, dynamic>{
//         'name': data.name,
//         'email': data.email,
//         'gender': data.gender,
//       }));
// }

Future<http.Response> createUser(UserModel data) async {
  var result = await http.post(
      Uri.parse('http://192.168.144.20:8081/api/user/insert'),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8'
      },
      body: jsonEncode(<String, dynamic>{
        'name': data.name,
        'email': data.email,
        'gender': data.gender,
      }));
  // print(result.statusCode);
  return result;
}

Future<http.Response> updateUser(int id, UserModel data) async {
  return await http.put(
      Uri.parse('http://192.168.144.20:8081/api/user/updateUser/${id}'),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
      },
      body: jsonEncode(<String, dynamic>{
        'name': data.name,
        'email': data.email,
        'gender': data.gender,
      }));
}

Future<http.Response> deleteUser(int id) {
  return http.delete(
      Uri.parse('http://192.168.144.20:8081/api/user/delete/${id}'),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
      });
}
