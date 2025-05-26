// lib/pages/login_page.dart
import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_restaurant_app/prodivers/UserProvider.dart';
import 'package:http/http.dart' as http;
import 'package:provider/provider.dart';
import '../prodivers/ApiProvider.dart';
import '../service/auth_service.dart';
import 'register_page.dart';

class LoginPage extends StatefulWidget {
  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final _formKey = GlobalKey<FormState>();
  String email = '';
  String password = '';

  Future<void> _submit(BuildContext context) async {
    AuthService authService = AuthService(context: context);

    print("submit");
    if (_formKey.currentState!.validate()) {
      _formKey.currentState!.save();
      try {
        String _baseUrl = Provider.of<ApiProvider>(context, listen: false).getBaseUrl();
        final response = await http.post(
          Uri.parse('$_baseUrl/auth/login'),
          headers: {'Content-Type': 'application/json'},
          body: jsonEncode({
            'email': email,
            'password': password,
          }),
        );

        final body = jsonDecode(response.body);
        if (response.statusCode == 200 || response.statusCode == 201) {
          print(body);
        } else {
          throw Exception(body['message'] ?? 'Erreur inconnue');
        }

        // Ajout du token dans le provider
        if (body.access_token) {
          Provider.of<UserProvider>(context, listen: false).updateToken(body.access_token);
        }

        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Connexion réussie')),
        );
        // TODO : Rediriger vers l'accueil
      } catch (e) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Erreur : $e')),
        );
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Connexion')),
      body: Padding(
        padding: EdgeInsets.all(16),
        child: Form(
          key: _formKey,
          child: Column(
            children: [
              TextFormField(
                decoration: InputDecoration(labelText: 'Email'),
                keyboardType: TextInputType.emailAddress,
                validator: (val) => val!.isEmpty ? 'Champ requis' : null,
                onSaved: (val) => email = val!,
              ),
              TextFormField(
                decoration: InputDecoration(labelText: 'Mot de passe'),
                obscureText: true,
                validator: (val) => val!.length < 3 ? 'Min 3 caractères' : null,
                onSaved: (val) => password = val!,
              ),
              SizedBox(height: 20),
              ElevatedButton(onPressed: () => _submit(context), child: Text('Se connecter')),
              TextButton(
                onPressed: () => Navigator.push(
                  context,
                  MaterialPageRoute(builder: (_) => RegisterPage()),
                ),
                child: Text('Créer un compte'),
              )
            ],
          ),
        ),
      ),
    );
  }
}
