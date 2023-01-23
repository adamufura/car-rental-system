import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:gac_car_rental/user/api/user.dart';
import 'package:shared_preferences/shared_preferences.dart';

class UserProvider with ChangeNotifier {
  Map<dynamic, dynamic> _loggedInUser = {};
  bool loading = false;

  Map<dynamic, dynamic> get loggedInUser => _loggedInUser;

  getLoggedInUser() async {
    loading = true;

    final user = User();

    _loggedInUser = await user.getUser(await getUserEmail());
    loading = false;

    notifyListeners();
  }

  getUserEmail() async {
    final prefs = await SharedPreferences.getInstance();
    final String? response = prefs.getString('car-rental');
    Map<dynamic, dynamic> result = jsonDecode(response!);
    return result['email'];
  }
}
