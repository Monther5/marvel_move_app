import 'dart:convert';

import 'package:flutter/foundation.dart';
import 'package:http/http.dart' as http;
import 'package:marvel_app/Model/user_model.dart';
import 'package:shared_preferences/shared_preferences.dart';

class Api {
  Future<http.Response> get(String url) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String? token = prefs.getString('token');

    var response = await http
        .get(Uri.parse(url), headers: {"Authorization": "Bearer $token"});
    if (kDebugMode) {
      print("GET: $url");
      print("Response: ${response.body}");
    }
    return response;
  }

  Future<http.Response> post(String url, {Map? body = null}) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();

    String? token = prefs.getString("token");
    print("feom api ${prefs.getString("token")}");
    final response = await http.post(
        Uri.parse(
          url,
        ),
        body: json.encode(body),
        headers: {
          "Authorization": "Bearer $token",
          "Content-Type": "application/json",
          "Accept": "application/json"
        });
    if (kDebugMode) {
      print("POST URL : $url");
      print("POST BODY : ${body}");
      print("POST STATUS CODE : ${response.statusCode}");
      print("POST RESPONSE : ${response.body}");
    }

    print("TOKEN DOWN");
    print(response.headers);
    return response;
  }

  Future<http.Response> put(String url, {UserModel? body = null}) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String? token = prefs.getString("token");
    final response = await http.put(
        Uri.parse(
          url,
        ),
        body: json.encode(body),
        headers: {
          "Authorization": "Bearer $token",
          "Content-Type": "application/json",
          "Accept": "application/json"
        });
    if (kDebugMode) {
      print("PUT URL : $url");
      print("PUT BODY : ${body}");
      print("PUT STATUS CODE : ${response.statusCode}");
      print("PUT RESPONSE : ${response.body}");
    }
    return response;
  }

  Future<http.Response> delete(String url) async {
    var response = await http.delete(Uri.parse(url));
    if (kDebugMode) {
      print("DELETE: $url");
      print("Response: ${response.body}");
    }
    return response;
  }
}