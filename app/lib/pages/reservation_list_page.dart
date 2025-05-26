import 'package:flutter/material.dart';

import '../models/reservation.dart';
import '../service/reservation_service.dart';

class ReservationListPage extends StatefulWidget {
  @override
  _ReservationListPageState createState() => _ReservationListPageState();
}

class _ReservationListPageState extends State<ReservationListPage> {
  late Future<List<Reservation>> futureReservations;

  @override
  void initState() {
    super.initState();
    futureReservations = fetchReservations();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Liste des réservations du restaurant')),
      body: FutureBuilder<List<Reservation>>(
        future: futureReservations,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(child: CircularProgressIndicator());
          } else if (snapshot.hasError) {
            return Center(child: Text('Erreur : ${snapshot.error}'));
          } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
            return Center(child: Text('Aucune réservation trouvée.'));
          }

          final reservations = snapshot.data!;

          return ListView.builder(
            itemCount: reservations.length,
            itemBuilder: (context, index) {
              final res = reservations[index];
              return Card(
                margin: EdgeInsets.all(8),
                child: ListTile(
                  title: Text('${res.date} à ${res.timeSlot.startTime}'),
                  subtitle: Text('${res.restaurantTable.name} - ${res.covers} personnes'),
                  trailing: Text('${res.status}'),
                ),
              );
            },
          );
        },
      ),
    );
  }
}
