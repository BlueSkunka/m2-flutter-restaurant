import 'package:flutter_restaurant_app/models/dish_category.dart';

class Restaurant {
  final String name;
  final String address;
  final double rating;
  final String description;
  final String imageUrl;
  final List<DishCategory> menu;

  Restaurant({
    required this.name,
    required this.address,
    required this.rating,
    required this.description,
    required this.imageUrl,
    required this.menu
  });
}