class TimeSlots {
  final String startTime;
  final String endTime;

  TimeSlots({
    required this.startTime,
    required this.endTime,
  });

  factory TimeSlots.fromJson(Map<String, dynamic> json) {
    return TimeSlots(
      startTime: json['startTime'],
      endTime: json['endTime'],
    );
  }
}
