import 'package:flutter/material.dart';
import 'package:gac_car_rental/admin/api/brand.dart';

class CarProvider with ChangeNotifier {
  var _brands;
  bool loading = false;

  get getBrands => _brands;

  getAllCarBrand() async {
    loading = true;

    _brands = await getAllCarBrands();

    loading = false;

    notifyListeners();
  }
}
