// lib/service/auth_service.dart
import 'dart:convert';
import 'package:flutter/widgets.dart';
import 'package:http/http.dart' as http;
import 'package:provider/provider.dart';

import '../prodivers/ApiProvider.dart';

class AuthService {
  BuildContext context;

  AuthService({required BuildContext this.context});

  Future<Map<String, dynamic>> login({
    required String email,
    required String password,
  }) async {
    String _baseUrl = context.read<ApiProvider>().getBaseUrl();
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

  Future<Map<String, dynamic>> register({
    required String firstname,
    required String lastname,
    required String phone,
    required String email,
    required String password,
    required String role,
  }) async {
    String _baseUrl = context.read()<ApiProvider>(context).getBaseUrl();
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

  Map<String, dynamic> _handleResponse(http.Response response) {
    final body = jsonDecode(response.body);
    if (response.statusCode == 200 || response.statusCode == 201) {
      print(body);
      return body;
    } else {
      throw Exception(body['message'] ?? 'Erreur inconnue');
    }
  }
}
