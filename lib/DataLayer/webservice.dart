import 'dart:convert';
import 'package:http/http.dart' as http;
import '../constants/helper.dart';
import '../SharedPrefrence/SharedPref.dart';

class HttpService {
  Future<String?> token = getToken();

  Future<int> loginWebService(Map<String, String> data) async {
    try {
      final url = Uri.parse(MyUrl.loginUrl);
      final body = jsonEncode(data);
      final response = await http.post(
        url,
        headers: {'Content-Type': 'application/json'},
        body: body,
      );
      final res = jsonDecode(response.body);
      if (response.statusCode == 200 || response.statusCode == 201) {
        setToken(token: res["token"]);
        setString(key: userTypeKey, data: res["user"]["userType"]);
        setString(key: nameKey, data: res["user"]["username"]);
        setString(key: emailKey, data: res["user"]["email"]);
        setString(key: cityKey, data: res["user"]["city"]);
        setString(key: addressKey, data: res["user"]["address"]);
      }

      return response.statusCode;
    } catch (e) {
      // Handle error
      print('Error sending POST request: $e');
      rethrow; // Rethrow the error to be handled by caller
    }
  }

  Future<int> patchRequest({required Map<String, dynamic> data}) async {
    try {
      final url = Uri.parse(MyUrl.loginUrl);
      final body = jsonEncode(data);
      final response = await http.patch(
        url,
        headers: {'Content-Type': 'application/json'},
        body: body,
      );
      return response.statusCode;
    } catch (e) {
      // Handle error
      print('Error sending POST request: $e');
      rethrow; // Rethrow the error to be handled by caller
    }
  }

  Future<http.Response> registerWebService(Map<String, String> data) async {
    try {
      // Define the endpoint URL
      final url = Uri.parse(MyUrl.signUpUrl);
      // Convert the data map to JSON
      final body = jsonEncode(data);
      // Send POST request
      http.Response response = await http.post(
        url,
        headers: {'Content-Type': 'application/json'},
        body: body,
      );
      final res = jsonDecode(response.body);

      if (response.statusCode == 200 || response.statusCode == 201) {
        setToken(token: res["token"]);
        setString(key: nameKey, data: res["user"]["username"]);
        setString(key: emailKey, data: res["user"]["email"]);
        setString(key: cityKey, data: res["user"]["city"]);
        setString(key: addressKey, data: res["user"]["address"]);
        setString(key: userIdKey, data: res["user"]["id"].toString());
      }

      return response;
    } catch (e) {
      print("-" * 20);
      // Handle error
      print('Error sending POST request: $e');
      rethrow; // Rethrow the error to be handled by caller
    }
  }
}
