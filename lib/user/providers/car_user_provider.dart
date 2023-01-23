import 'package:flutter/material.dart';

import '../api/car.dart';

class CarUserProvider with ChangeNotifier {
  bool loading = false;

  var _brands;
  get getBrands => _brands;

  getAllBrand() async {
    loading = true;

    _brands = await getAllBrands();

    loading = false;

    notifyListeners();
  }

  var _cars;
  get getCars => _cars;

  getAllCars() async {
    loading = true;

    _cars = await getAllTheCars();

    loading = false;

    notifyListeners();
  }

  var _car;
  get getCar => _car;
  getACarWithID(int id) async {
    loading = true;

    _car = await getACar(carID: id);

    // print("${_car}hey");

    loading = false;

    notifyListeners();
  }
}
