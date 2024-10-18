import 'dart:convert';
import '/helpers/api.dart';
import '/helpers/api_url.dart';
import '/model/registrasi.dart';

class RegistrasiBloc {
  static Future<Registrasi> registrasi(
      {String? nama, String? email, String? password}) async {
    String apiUrl = ApiUrl.registrasi;

    var body = {"nama": nama, "email": email, "password": password};

    var response = await Api().post(apiUrl, body);
    if (response.statusCode == 200) {
      var jsonObj = json.decode(response.body);
      return Registrasi.fromJson(jsonObj);
    } else if (response.statusCode == 400) {
      throw Exception('Bad request: ${response.body}');
    } else {
      throw Exception('Registrasi gagal, silahkan cek data yang dimasukkan');
    }

    var jsonObj = json.decode(response.body);
    return Registrasi.fromJson(jsonObj);
  }
}
