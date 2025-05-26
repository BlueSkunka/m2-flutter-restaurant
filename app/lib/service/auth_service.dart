// lib/service/auth_service.dart
import 'dart:convert';
import 'package:http/http.dart' as http;

class AuthService {
  static const _baseUrl = 'http://10.0.2.2:3000/auth'; // à adapter

  static Future<Map<String, dynamic>> login({
    required String email,
    required String password,
  }) async {
    final response = await http.post(
      Uri.parse('$_baseUrl/login'),
      headers: {'Content-Type': 'application/json'},
      body: jsonEncode({
        'email': email,
        'password': password,
      }),
    );

    return _handleResponse(response);
  }

  static Future<Map<String, dynamic>> register({
    required String firstname,
    required String lastname,
    required String phone,
    required String email,
    required String password,
    required String role,
  }) async {
    final response = await http.post(
      Uri.parse('$_baseUrl/register'),
      headers: {'Content-Type': 'application/json'},
      body: jsonEncode({
        'email': email,
        'firstname': firstname,
        'lastname': lastname,
        'phone': phone,
        'plainPassword': password,
        'roles': role,
      }),
    );

    return _handleResponse(response);
  }

  static Map<String, dynamic> _handleResponse(http.Response response) {
    final body = jsonDecode(response.body);
    if (response.statusCode == 200 || response.statusCode == 201) {
      print(body);
      return body;
    } else {
      throw Exception(body['message'] ?? 'Erreur inconnue');
    }
  }
}
