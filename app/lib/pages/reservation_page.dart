import 'package:flutter/material.dart';
import 'dart:async';

class TimeSlot {
  final String start;
  final String end;
  TimeSlot(this.start, this.end);
}

class FakeApi {
  static Future<List<int>> getAvailableTables(DateTime date) async {
    await Future.delayed(const Duration(milliseconds: 500));
    return [1, 3, 5, 7, 9];
  }

  static Future<List<TimeSlot>> getAvailableSlots(int tableNumber, DateTime date) async {
    await Future.delayed(const Duration(milliseconds: 500));
    return [
      TimeSlot("12:00", "13:00"),
      TimeSlot("13:30", "14:30"),
      TimeSlot("19:00", "20:00"),
    ];
  }
}

class ReservationPage extends StatefulWidget {
  const ReservationPage({super.key});

  @override
  State<ReservationPage> createState() => _ReservationPageState();
}

class _ReservationPageState extends State<ReservationPage> {
  DateTime? selectedDate;
  List<int> availableTables = [];
  int? selectedTable;
  List<TimeSlot> availableSlots = [];
  TimeSlot? selectedSlot;

  final TextEditingController peopleController = TextEditingController();

  Future<void> _selectDate(BuildContext context) async {
    final picked = await showDatePicker(
      context: context,
      initialDate: DateTime.now().add(const Duration(days: 1)),
      firstDate: DateTime.now(),
      lastDate: DateTime.now().add(const Duration(days: 30)),
    );
    if (picked != null) {
      setState(() {
        selectedDate = picked;
        selectedTable = null;
        availableSlots = [];
        selectedSlot = null;
      });
      _fetchAvailableTables(picked);
    }
  }

  void _fetchAvailableTables(DateTime date) async {
    final tables = await FakeApi.getAvailableTables(date);
    setState(() {
      availableTables = tables;
    });
  }

  void _fetchAvailableSlots(int tableNumber) async {
    if (selectedDate != null) {
      final slots = await FakeApi.getAvailableSlots(tableNumber, selectedDate!);
      setState(() {
        availableSlots = slots;
        selectedSlot = null;
      });
    }
  }

  void _confirmReservation() {
    if (selectedSlot != null && peopleController.text.isNotEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(
              "Réservation : table $selectedTable le ${selectedDate!.toLocal().toString().split(' ')[0]} de ${selectedSlot!.start} à ${selectedSlot!.end} pour ${peopleController.text} personnes."),
        ),
      );
    }
  }

  @override
  void dispose() {
    peopleController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Réserver une table")),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          children: [
            ElevatedButton(
              onPressed: () => _selectDate(context),
              child: const Text("Choisir une date"),
            ),
            if (selectedDate != null) ...[
              const SizedBox(height: 10),
              Text(
                "Tables disponibles le ${selectedDate!.toLocal().toString().split(' ')[0]}",
                style: const TextStyle(fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 10),
              Wrap(
                spacing: 10,
                runSpacing: 10,
                children: availableTables.map((tableNumber) {
                  return ChoiceChip(
                    label: Text("Table $tableNumber"),
                    selected: selectedTable == tableNumber,
                    onSelected: (_) {
                      setState(() {
                        selectedTable = tableNumber;
                        selectedSlot = null;
                      });
                      _fetchAvailableSlots(tableNumber);
                    },
                  );
                }).toList(),
              ),
            ],
            if (availableSlots.isNotEmpty) ...[
              const SizedBox(height: 20),
              const Text("Créneau horaire :"),
              DropdownButtonFormField<TimeSlot>(
                value: selectedSlot,
                hint: const Text("Choisir un créneau"),
                items: availableSlots.map((slot) {
                  return DropdownMenuItem(
                    value: slot,
                    child: Text("${slot.start} - ${slot.end}"),
                  );
                }).toList(),
                onChanged: (value) {
                  setState(() {
                    selectedSlot = value;
                  });
                },
              ),
              const SizedBox(height: 10),
              TextField(
                controller: peopleController,
                keyboardType: TextInputType.number,
                decoration: const InputDecoration(
                  labelText: 'Nombre de personnes',
                  border: OutlineInputBorder(),
                ),
              ),
              const SizedBox(height: 12),
              ElevatedButton(
                onPressed: _confirmReservation,
                child: const Text("Valider la réservation"),
              ),
            ]
          ],
        ),
      ),
    );
  }
}
