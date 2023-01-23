import 'dart:convert';

import 'package:gac_car_rental/user/api/init.dart';
import 'package:http/http.dart' as http;
import 'package:http/http.dart';

Future getAllBrands() async {
  String urlPost = Init.urlInit + "admin/brands.php?getAllBrands=true";
  try {
    var response = await http.get(Uri.parse(urlPost));
    return json.decode(response.body);
  } catch (e) {
    print(e);
  }
}

Future getAllTheCars() async {
  String urlPost = Init.urlInit + "user/cars.php?getAllCars=true";
  try {
    var response = await http.get(Uri.parse(urlPost));

    return json.decode(response.body);
  } catch (e) {
    print(e);
  }
}

Future getACar({required int carID}) async {
  String urlPost = Init.urlInit + "user/cars.php?id=${carID}&getCar='true'";
  try {
    var response = await http.get(Uri.parse(urlPost));

    // print(response.body);

    return json.decode(response.body);
  } catch (e) {
    print(e);
  }
}

Future RentCar({
  required String email,
  required int carID,
  required String days,
  required int amount,
}) async {
  String urlPost = Init.urlInit + "user/cars.php";
  try {
    var res = await http.post(Uri.parse(urlPost), body: {
      "email": email,
      "car_id": carID.toString(),
      "number_of_days": days,
      "amount": amount.toString(),
    });

    return res;
  } catch (e) {
    print(e);
  }
}

Future getUserRentedCars({
  required String email,
}) async {
  String urlPost =
      Init.urlInit + "user/cars.php?email=${email}&getAllUserRents=true";
  try {
    var response = await http.get(Uri.parse(urlPost));

    return json.decode(response.body);
  } catch (e) {
    print(e);
  }
}
