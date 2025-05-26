import 'package:flutter/material.dart';
import 'package:flutter_restaurant_app/models/reservation.dart';
import 'package:flutter_restaurant_app/service/reservation_service.dart';
//import 'package:intl/intl.dart';

class AdminReservationsPage extends StatefulWidget {
  const AdminReservationsPage({super.key});

  @override
  State<AdminReservationsPage> createState() => _AdminReservationsPageState();
}

class _AdminReservationsPageState extends State<AdminReservationsPage> {
  List<Reservation> _reservations = [];
  bool _isLoading = true;
  String _error = '';

  String _getStatusInFrench(String status) {
    switch (status.toLowerCase()) {
      case 'pending':
        return 'En attente';
      case 'confirmed':
        return 'Acceptée';
      case 'refused':
        return 'Refusée';
      case 'cancelled':
        return 'Annulée';
      default:
        return status;
    }
  }

  @override
  void initState() {
    super.initState();
    _loadReservations();
  }

  Future<void> _loadReservations() async {
    try {
      setState(() {
        _isLoading = true;
        _error = '';
      });

      final reservations = await fetchReservations();
      setState(() {
        _reservations = reservations;
        _isLoading = false;
      });
    } catch (e) {
      setState(() {
        _error = 'Erreur lors du chargement des réservations';
        _isLoading = false;
      });
    }
  }

  Future<void> _updateReservationStatus(Reservation reservation, String newStatus) async {
    try {
      await updateReservationStatus(reservation.id.toString(), newStatus);
      await _loadReservations();
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Statut mis à jour avec succès')),
      );
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Erreur lors de la mise à jour du statut')),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    if (_isLoading) {
      return const Center(child: CircularProgressIndicator());
    }

    if (_error.isNotEmpty) {
      return Center(child: Text(_error));
    }

    return Scaffold(
      appBar: AppBar(
        title: const Text('Gestion des Réservations'),
        actions: [
          IconButton(
            icon: const Icon(Icons.refresh),
            onPressed: _loadReservations,
          ),
        ],
      ),
      body: ListView.builder(
        itemCount: _reservations.length,
        itemBuilder: (context, index) {
          final reservation = _reservations[index];
          return Card(
            margin: const EdgeInsets.all(8.0),
            child: ListTile(
              title: Text('Table ${reservation.restaurantTable.name} - ${reservation.covers} personnes'),
              subtitle: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text('Date: ${reservation.reservationDate}'),
                  Text('Horaire: ${reservation.timeSlot.startTime} - ${reservation.timeSlot.endTime}'),
                  Text('Statut: ${_getStatusInFrench(reservation.status)}'),
                ],
              ),
              trailing: Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  if (reservation.status.toLowerCase() == 'pending')
                    IconButton(
                      icon: const Icon(Icons.check, color: Colors.green),
                      onPressed: () => _updateReservationStatus(reservation, 'CONFIRMED'),
                    ),
                  if (reservation.status.toLowerCase() == 'pending')
                    IconButton(
                      icon: const Icon(Icons.close, color: Colors.red),
                      onPressed: () => _updateReservationStatus(reservation, 'REFUSED'),
                    ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }
} 