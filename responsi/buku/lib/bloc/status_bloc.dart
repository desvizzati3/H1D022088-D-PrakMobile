import 'dart:convert';
import '/helpers/api.dart';
import '/helpers/api_url.dart';
import '/model/status.dart';
import 'package:http/http.dart' as http;

class StatusBloc {
  final String baseUrl = 'http://103.196.155.42/api/buku/status';
  // Fetching list of statuses
  static Future<List<Status>> getStatuses() async {
    String apiUrl = ApiUrl.listStatus;
    var response = await Api().get(apiUrl);
    var jsonObj = json.decode(response.body);
    List<dynamic> listStatus = (jsonObj as Map<String, dynamic>)['data'];
    List<Status> statuses = [];
    for (int i = 0; i < listStatus.length; i++) {
      statuses.add(Status.fromJson(listStatus[i]));
    }
    return statuses;
  }

  // Adding new status
  static Future addStatus({Status? status}) async {
    String apiUrl = ApiUrl.createStatus;

    var body = jsonEncode({
      "availability": status!.availability,
      "borrower_name": status.borrower_name,
      "due_days": status.due_days.toString()
    });

    var response = await Api().post(apiUrl, body);
    print('Response status: ${response.statusCode}');
    print('Response body: ${response.body}');
    var jsonObj = json.decode(response.body);
    return jsonObj['status'];
  }

  // Fungsi untuk memperbarui status
  Future<bool> updateStatus(
      int id, String availability, String borrowerName, int dueDays) async {
    var apiUrl = '$baseUrl/$id';
    var data = jsonEncode({
      "availability": availability,
      "borrower_name": borrowerName,
      "due_days": dueDays
    });

    var response = await http.put(
      Uri.parse(apiUrl),
      body: data,
      headers: {"Content-Type": "application/json"},
    );

    if (response.statusCode == 200) {
      var jsonObj = json.decode(response.body);
      return jsonObj['status'] == true; // Memastikan operasi berhasil
    } else {
      throw Exception('Failed to update status');
    }
  }

  // Fungsi untuk menghapus status
  Future<bool> deleteStatus(int id) async {
    var apiUrl = '$baseUrl/$id/delete';
    var response = await http.delete(Uri.parse(apiUrl));

    if (response.statusCode == 200) {
      var jsonObj = json.decode(response.body);
      return jsonObj['status'] == true; // Memastikan operasi berhasil
    } else {
      throw Exception('Failed to delete status');
    }
  }
}
