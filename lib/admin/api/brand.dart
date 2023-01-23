import 'dart:convert';

import "package:async/async.dart";
import 'package:flutter/material.dart';
import 'package:gac_car_rental/admin/screens/brands_screen.dart';
import 'package:http/http.dart';

import 'package:path/path.dart';

import 'dart:io';

import 'package:http/http.dart' as http;

import '../api/init.dart';

AddBrand(
    {required String name,
    required File logoFile,
    required BuildContext context}) async {
  String urlPost = Init.urlInit + "admin/brands.php";
  try {
    final uri = Uri.parse(urlPost);
    var request = http.MultipartRequest('POST', uri);
    request.fields['createBrand'] = 'true';
    request.fields['name'] = name;
    var logo = await http.MultipartFile.fromPath("image", logoFile.path);
    request.files.add(logo);
    var response = await request.send();
    response.stream.transform(utf8.decoder).listen((value) {
      Map<dynamic, dynamic> result = jsonDecode(value);
      if (response.statusCode == 200 && result['status'] == "success") {
        if (result['status'] == "success") {
          ScaffoldMessenger.of(context).showSnackBar(SnackBar(
            content: Text("Brand successfully added"),
          ));
        } else {
          ScaffoldMessenger.of(context).showSnackBar(SnackBar(
            content: Text("Something went wrong"),
          ));
        }
      }
    });
  } catch (e) {
    print(e);
  }
}

Future getAllBrands() async {
  String urlPost = Init.urlInit + "admin/brands.php?getAllBrands=true";
  try {
    var response = await http.get(Uri.parse(urlPost));
    return json.decode(response.body);
  } catch (e) {
    print(e);
  }
}

Future getAllCarBrands() async {
  String urlPost = Init.urlInit + "admin/brands.php?getAllCarBrands=true";
  try {
    var response = await http.get(Uri.parse(urlPost));
    return json.decode(response.body);
  } catch (e) {
    print(e);
  }
}

deleteBrand({required int brandID}) async {
  try {
    String urlPost =
        Init.urlInit + "admin/brands.php?id=${brandID}&deleteBrand='true'";
    var res = await http.delete(Uri.parse(urlPost));
    return res;
  } catch (e) {
    print(e);
  }
}
