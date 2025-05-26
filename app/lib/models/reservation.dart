import 'package:flutter_restaurant_app/models/restaurant_table.dart';
import 'package:flutter_restaurant_app/models/time_slots.dart';

class Reservation {
  final String id;
  final int covers;
  final String date;
  final TimeSlots timeSlot;
  final RestaurantTable restaurantTable;
  final String status;

  Reservation({
    required this.id,
    required this.covers,
    required this.date,
    required this.timeSlot,
    required this.restaurantTable,
    required this.status,
  });

  factory Reservation.fromJson(Map<String, dynamic> json) {
    print(json);
    return Reservation(
      id: json['id'],
      covers: json['covers'],
      date: json['reservationDate'],
      timeSlot: new TimeSlots(startTime: json['timeSlot']['startTime'], endTime: json['timeSlot']['endTime']),
      restaurantTable: new RestaurantTable(name: json["table"]["name"], capacity: json["table"]["capacity"]),
      status: json["status"],
    );
  }
}
