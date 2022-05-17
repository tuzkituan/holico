import 'dart:convert';

import 'package:hrms_app/config/api.dart';
import 'package:hrms_app/utils/shared_preference.dart';
import 'package:http/http.dart' as http;

class HttpService {
  static Future<dynamic> getAPI(String url, Object payload) async {
    return http.get(
      Uri.parse("$API_URL$url"),
      headers: {
        'Content-Type': 'application/json;charset=UTF-8',
        'Access-Control-Allow-Origin': '*',
      },
    ).then((http.Response response) {
      final int statusCode = response.statusCode;
      if (statusCode < 200 || statusCode > 400) {
        throw Exception("Error while fetching data");
      }
      return response.body;
    });
  }

  static Future<dynamic> postAPI(String url, Object payload) async {
    String token = await UserPreferences().getToken();

    return http.post(
      Uri.parse("$API_URL$url"),
      body: json.encode(payload),
      headers: {
        'Content-Type': 'application/json;charset=UTF-8',
        'Access-Control-Allow-Origin': '*',
        'Authorization': 'Bearer $token',
      },
    ).then((http.Response response) {
      final int statusCode = response.statusCode;
      if (statusCode < 200 || statusCode > 400) {
        throw Exception("Error while fetching data");
      }
      return response;
    });
  }
}
