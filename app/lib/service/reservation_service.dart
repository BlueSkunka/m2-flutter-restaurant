import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:flutter/foundation.dart' show kIsWeb;
import 'dart:io' show Platform;
import '../models/reservation.dart';
import '../config/env.dart';

Future<List<Reservation>> fetchReservations() async {
  final baseUrl = _getBaseUrl();
  final url = Uri.parse('$baseUrl/reservations');
  
  final response = await http.get(url, headers: Env.defaultHeaders);

  if (response.statusCode == 200) {
    final List<dynamic> data = jsonDecode(response.body);
    return data.map((json) => Reservation.fromJson(json)).toList();
  } else {
    throw Exception('Erreur de chargement des réservations');
  }
}

Future<void> updateReservationStatus(String reservationId, String newStatus) async {
  final baseUrl = _getBaseUrl();
  final url = Uri.parse('$baseUrl/reservations/$reservationId/status');

  final body = jsonEncode({
    'status': newStatus,
  });

  final response = await http.patch(url, headers: Env.defaultHeaders, body: body);

  if (response.statusCode != 200) {
    throw Exception('Erreur lors de la mise à jour du statut de la réservation');
  }
}

Future<void> bookTable({
  required String nom,
  required int personnes,
  required String date,
  required String heure,
}) async {
  final baseUrl = _getBaseUrl();
  final url = Uri.parse('$baseUrl/reservations');

  final body = jsonEncode({
    'nom': nom,
    'nombre_personnes': personnes,
    'date': date,        // Format ISO: "2025-05-30"
    'heure': heure,      // Exemple: "19:30"
  });

  final response = await http.post(url, headers: Env.defaultHeaders, body: body);

  if (response.statusCode == 200 || response.statusCode == 201) {
    print('Réservation réussie : ${response.body}');
  } else {
    print('Erreur : ${response.statusCode} - ${response.body}');
    throw Exception('Échec de la réservation');
  }
}

String _getBaseUrl() {
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
