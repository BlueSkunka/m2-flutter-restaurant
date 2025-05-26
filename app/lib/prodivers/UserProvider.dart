import 'package:flutter/material.dart';

class UserProvider with ChangeNotifier {
  String _token = "";

  void updateToken(String token) {
    _token = token;
    notifyListeners();
  }
}