import 'dart:convert';

import 'package:flutter/material.dart';

import 'package:http/http.dart' as http;

import '../api/init.dart';

Future getAllUsers() async {
  String urlPost = Init.urlInit + "admin/users.php?getAllUsers=true";
  try {
    var response = await http.get(Uri.parse(urlPost));

    return json.decode(response.body);
  } catch (e) {
    print(e);
  }
}
