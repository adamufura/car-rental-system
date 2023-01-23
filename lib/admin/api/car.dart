import 'dart:convert';

import "package:async/async.dart";
import 'package:flutter/material.dart';
import 'package:gac_car_rental/admin/screens/brands_screen.dart';
import 'package:gac_car_rental/admin/screens/cars_screen.dart';
import 'package:http/http.dart';

import 'package:path/path.dart';

import 'dart:io';

import 'package:http/http.dart' as http;

import '../api/init.dart';

AddCar({
  required File imageFile,
  required String name,
  required String brand,
  required String price,
  required String power,
  required String type,
  required String fuel,
  required String seats,
  required String details,
  required BuildContext context,
}) async {
  String urlPost = Init.urlInit + "admin/cars.php";
  try {
    final uri = Uri.parse(urlPost);
    var request = http.MultipartRequest('POST', uri);
    request.fields['createCar'] = 'true';
    request.fields['name'] = name;
    request.fields['brand'] = brand;
    request.fields['price'] = price;
    request.fields['power'] = power;
    request.fields['type'] = type;
    request.fields['fuel'] = fuel;
    request.fields['seats'] = seats;
    request.fields['details'] = details;

    var carImage = await http.MultipartFile.fromPath("image", imageFile.path);
    request.files.add(carImage);
    var response = await request.send();
    response.stream.transform(utf8.decoder).listen((value) {
      if (response.statusCode == 200) {
        print(value);
        Map<dynamic, dynamic> result = jsonDecode(value);
        if (result['status'] == "success") {
          ScaffoldMessenger.of(context).showSnackBar(SnackBar(
            content: Text("Car successfully added"),
          ));
        } else {
          ScaffoldMessenger.of(context).showSnackBar(SnackBar(
            content: Text("Something went wrong"),
          ));
        }
      } else {
        ScaffoldMessenger.of(context).showSnackBar(SnackBar(
          content: Text("Something went wrong"),
        ));
      }
    });
  } catch (e) {
    print(e);
  }
}

Future getAllCars() async {
  String urlPost = Init.urlInit + "admin/cars.php?getAllCars=true";
  try {
    var response = await http.get(Uri.parse(urlPost));

    return json.decode(response.body);
  } catch (e) {
    print(e);
  }
}

Future getAllRentedCars() async {
  String urlPost = Init.urlInit + "admin/cars.php?getAllRents=true";
  try {
    var response = await http.get(Uri.parse(urlPost));

    return json.decode(response.body);
  } catch (e) {
    print(e);
  }
}

returnRentedCar(
    {required int id, required String carID, required String email}) async {
  String urlPost = Init.urlInit + "admin/cars.php";
  try {
    var res = await http.post(Uri.parse(urlPost), body: {
      "id": id.toString(),
      "car_id": carID.toString(),
      "email": email,
      "returnedRentedCar": "true"
    });

    return json.decode(res.body);
  } catch (e) {
    print(e);
  }
}

deleteCar({required int brandID}) async {
  try {
    String urlPost =
        Init.urlInit + "admin/cars.php?id=${brandID}&deleteCar='true'";
    var res = await http.delete(Uri.parse(urlPost));
    return res;
  } catch (e) {
    print(e);
  }
}
