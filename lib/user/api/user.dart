import 'dart:convert';

import 'package:gac_car_rental/user/api/init.dart';
import 'package:http/http.dart' as http;
import 'package:http/http.dart';

class User {
  Future getUser(String email) async {
    String urlPost = "${Init.urlInit}user/user.php";
    try {
      var res = await http
          .post(Uri.parse(urlPost), body: {'email': email, 'getUser': 'true'});
      if (res.statusCode == 200) {
        final result = jsonDecode(res.body);
        return result;
      }
    } catch (e) {
      print(e);
    }
  }
}
