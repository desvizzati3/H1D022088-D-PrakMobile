import 'dart:convert';
import '/helpers/api.dart';
import '/helpers/api_url.dart';
import '/model/login.dart';
import '/helpers/user_info.dart';

class LoginBloc {
  static Future<Login> login({String? email, String? password}) async {
    String apiUrl = ApiUrl.login;
    var body = {"email": email, "password": password};
    var response = await Api().post(apiUrl, body);

    if (response.statusCode == 200) {
      var jsonObj = json.decode(response.body);
      return Login.fromJson(jsonObj);
    } else if (response.statusCode == 400) {
      throw Exception('Bad request: ${response.body}');
    } else {
      throw Exception('Login failed, check email or password');
    }
  }
}
