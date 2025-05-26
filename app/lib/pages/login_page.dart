// lib/pages/login_page.dart
import 'package:flutter/material.dart';
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
        final result = await authService.login(email: email, password: password);
        print(result);
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
