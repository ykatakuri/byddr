import 'package:http/http.dart' as http;
import 'package:flutter_secure_storage/flutter_secure_storage.dart';

class NetworkHandler {
  static final client = http.Client();
  static const storage = FlutterSecureStorage();

  static Future<dynamic> post(dynamic body, String endPoint) async {
    var response = await client.post(buildURL(endPoint),
        headers: <String, String>{
          "Content-Type": "application/json; charset=UTF-8",
        },
        body: body);

    return response.body;
  }

  static Future<dynamic> get(String endPoint, String token) async {
    var response = await client.get(
      buildURL(endPoint),
      headers: <String, String>{
        "Content-Type": "application/json; charset=UTF-8",
        "Authorization": "Bearer $token",
      },
    );

    return response.body;
  }

  static Uri buildURL(String endPoint) {
    String host = "https://encheres-ynov.herokuapp.com/api/";
    final apiURL = host + endPoint;

    return Uri.parse(apiURL);
  }

  static Future<void> storeToken(String token) async {
    await storage.write(key: "token", value: token);
  }

  static Future<String?> getToken() async {
    return await storage.read(key: "token");
  }

  static Future<void> logout() async {
    await storage.delete(key: "token");
  }
}
