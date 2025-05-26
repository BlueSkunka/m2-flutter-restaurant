import 'dart:convert';

import 'package:http/http.dart' as http;

import '../models/reservation.dart';

Future<List<Reservation>> fetchReservations() async {
  // TODO En fonction de l'utilisateur changé la route appelé

  final url = Uri.parse('http://10.0.2.2:3000/reservations');
  final headers = {
    'Content-Type': 'application/json',
    'Authorization': 'Bearer eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJlbWFpbCI6ImFkbWluQGFkbWluLmNvbSIsImlkIjoiYzk2ZTNlNjctNTVjZC00YmRhLTgzNDItNThjZjA4MTA5MzExIiwicm9sZXMiOlsiYWRtaW4iXSwiaWF0IjoxNzQ4MjY1Mjc1LCJleHAiOjE3NDgyNjg4NzV9.e4ubDT46erHIjYIjkk_3JScRJive9LztvPccI5dsfxc',
  };

  final response = await http.get(url, headers: headers);

  if (response.statusCode == 200) {
    final List<dynamic> data = jsonDecode(response.body);

    return data.map((json) => Reservation.fromJson(json)).toList();
  } else {
    throw Exception('Erreur de chargement des réservations');
  }
}

Future<void> bookTable({
  required String nom,
  required int personnes,
  required String date,
  required String heure,
}) async {
  final url = Uri.parse('https://tonapi.com/reservations');

  final body = jsonEncode({
    'nom': nom,
    'nombre_personnes': personnes,
    'date': date,        // Format ISO: "2025-05-30"
    'heure': heure,      // Exemple: "19:30"
  });

  final headers = {
    'Content-Type': 'application/json',
    'Authorization': 'Bearer ton_token_si_necessaire',
  };

  final response = await http.post(url, headers: headers, body: body);

  if (response.statusCode == 200 || response.statusCode == 201) {
    print('Réservation réussie : ${response.body}');
  } else {
    print('Erreur : ${response.statusCode} - ${response.body}');
    throw Exception('Échec de la réservation');
  }
}
