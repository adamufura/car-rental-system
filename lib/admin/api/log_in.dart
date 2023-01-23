import 'package:gac_car_rental/user/api/init.dart';
import 'package:http/http.dart' as http;
import 'package:http/http.dart';

Future<Response?> LogIn({
  required String username,
  required String password,
}) async {
  String urlPost = Init.urlInit + "admin/login.php";
  try {
    var res = await http.post(Uri.parse(urlPost), body: {
      "username": username,
      "password": password,
    });

    return res;
  } catch (e) {
    print(e);
  }
}
