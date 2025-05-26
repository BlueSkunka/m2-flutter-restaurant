import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter/foundation.dart' show kIsWeb;

import '../config/env.dart';

class ApiProvider with ChangeNotifier {
  String getBaseUrl() {
    if (kIsWeb) {
      return Env.apiUrl;
    }

    if (Platform.isAndroid) {
      return Env.androidApiUrl;
    }

    if (Platform.isIOS) {
      return Env.iosApiUrl;
    }

    return Env.apiUrl;
  }
}