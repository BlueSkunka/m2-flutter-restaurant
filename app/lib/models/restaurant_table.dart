class RestaurantTable {
  final String name;
  final int capacity;

  RestaurantTable({
    required this.name,
    required this.capacity,
  });

  factory RestaurantTable.fromJson(Map<String, dynamic> json) {
    return RestaurantTable(
      name: json['name'],
      capacity: json['capacity'],
    );
  }
}
