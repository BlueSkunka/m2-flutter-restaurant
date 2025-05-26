import 'package:flutter_restaurant_app/models/restaurant_table.dart';
import 'package:flutter_restaurant_app/models/time_slots.dart';

class Reservation {
  final int id;
  final int covers;
  final String reservationDate;
  final TimeSlots timeSlot;
  final RestaurantTable restaurantTable;
  final String status;
  final DateTime createdAt;
  final DateTime updatedAt;

  Reservation({
    required this.id,
    required this.covers,
    required this.reservationDate,
    required this.timeSlot,
    required this.restaurantTable,
    required this.status,
    required this.createdAt,
    required this.updatedAt,
  });

  factory Reservation.fromJson(Map<String, dynamic> json) {
    return Reservation(
      id: json['id'],
      covers: json['covers'],
      reservationDate: json['reservationDate'],
      timeSlot: TimeSlots(
        startTime: json['timeSlot']['startTime'],
        endTime: json['timeSlot']['endTime']
      ),
      restaurantTable: RestaurantTable(
        name: json['table']['name'],
        capacity: json['table']['capacity']
      ),
      status: json['status'],
      createdAt: DateTime.parse(json['createdAt']),
      updatedAt: DateTime.parse(json['updatedAt']),
    );
  }
}
