import 'package:flutter/material.dart';
import 'package:gac_car_rental/admin/api/brand.dart';
import 'package:gac_car_rental/admin/api/init.dart';

class CountProvider with ChangeNotifier {
  var _brandCount;
  var _carCount;
  var _rentsCount;
  var _usersCount;

  bool loading = false;

  get getBrandsCount => _brandCount;
  get getCarsCount => _carCount;
  get getRentsCount => _rentsCount;
  get getUsersCount => _usersCount;

  getBrandCount(String table) async {
    loading = true;

    _brandCount = await getTableCount(table: table);

    loading = false;

    notifyListeners();
  }

  getCarCount(String table) async {
    loading = true;

    _carCount = await getTableCount(table: table);

    loading = false;

    notifyListeners();
  }

  getRentCount(String table) async {
    loading = true;

    _rentsCount = await getTableCount(table: table);

    loading = false;

    notifyListeners();
  }

  getUserCount(String table) async {
    loading = true;

    _usersCount = await getTableCount(table: table);

    loading = false;

    notifyListeners();
  }
}
