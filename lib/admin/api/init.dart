import 'dart:convert';

import 'package:http/http.dart' as http;

class Init {
  static String urlInit = "https://car-rental-backend.herokuapp.com/";
}

Future getTableCount({required String table}) async {
  String urlPost = Init.urlInit + "admin/init.php?table=${table}";
  try {
    var response = await http.get(Uri.parse(urlPost));
    return json.decode(response.body);
  } catch (e) {
    print(e);
  }
}
