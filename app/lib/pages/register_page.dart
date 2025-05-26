// lib/pages/register_page.dart
import 'package:flutter/material.dart';
import '../service/auth_service.dart';
import 'login_page.dart';

class RegisterPage extends StatefulWidget {
  @override
  _RegisterPageState createState() => _RegisterPageState();
}

class _RegisterPageState extends State<RegisterPage> {
  final _formKey = GlobalKey<FormState>();
  String firstname = '';
  String lastname = '';
  String phone = '';
  String email = '';
  String password = '';
  String role = 'customer';

  Future<void> _submit() async {
    if (_formKey.currentState!.validate()) {
      _formKey.currentState!.save();
      try {
        final result = await AuthService.register(
          firstname: firstname,
          lastname: lastname,
          phone: phone,
          role: role,
          email: email,
          password: password,
        );
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Inscription réussie')),
        );
        // Retour à la page login
        Navigator.pop(context);
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
      appBar: AppBar(title: Text('Inscription')),
      body: Padding(
        padding: EdgeInsets.all(16),
        child: Form(
          key: _formKey,
          child: Column(
            children: [
              TextFormField(
                decoration: InputDecoration(labelText: 'Prénom'),
                keyboardType: TextInputType.text,
                validator: (val) => val!.isEmpty ? 'Champ requis' : null,
                onSaved: (val) => firstname = val!,
              ),
              TextFormField(
                decoration: InputDecoration(labelText: 'Nom'),
                keyboardType: TextInputType.text,
                validator: (val) => val!.isEmpty ? 'Champ requis' : null,
                onSaved: (val) => lastname = val!,
              ),
              TextFormField(
                decoration: InputDecoration(labelText: 'Téléphone'),
                keyboardType: TextInputType.phone,
                validator: (val) => val!.isEmpty ? 'Champ requis' : null,
                onSaved: (val) => phone = val!,
              ),
              TextFormField(
                decoration: InputDecoration(labelText: 'Email'),
                keyboardType: TextInputType.emailAddress,
                validator: (val) => val!.isEmpty ? 'Champ requis' : null,
                onSaved: (val) => email = val!,
              ),
              TextFormField(
                decoration: InputDecoration(labelText: 'Mot de passe'),
                obscureText: true,
                validator: (val) => val!.length < 3 ? 'Min 6 caractères' : null,
                onSaved: (val) => password = val!,
              ),
              SizedBox(height: 20),
              ElevatedButton(onPressed: _submit, child: Text('S\'inscrire')),
              TextButton(
                onPressed: () => Navigator.pop(context),
                child: Text('Déjà un compte ? Se connecter'),
              )
            ],
          ),
        ),
      ),
    );
  }
}
