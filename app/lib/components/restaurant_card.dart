import 'package:flutter/material.dart';
import '../models/restaurant.dart';
import '../pages/restaurant_detail_page.dart';
import '../models/dish.dart';
import '../models/dish_category.dart';

class RestaurantCard extends StatelessWidget {
  final Restaurant restaurant;
  final List<DishCategory> menu;

  const RestaurantCard({
    super.key,
    required this.restaurant,
    required this.menu,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (_) => RestaurantDetailPage(
              restaurant: restaurant,
              menu: menu,
            ),
          ),
        );
      },
      child: Card(
        margin: const EdgeInsets.symmetric(vertical: 10),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(12),
        ),
        elevation: 4,
        child: Column(
          children: [
            ClipRRect(
              borderRadius: const BorderRadius.vertical(top: Radius.circular(12)),
              child: Image.network(
                restaurant.imageUrl,
                height: 180,
                width: double.infinity,
                fit: BoxFit.cover,
              ),
            ),
            ListTile(
              title: Text(restaurant.name, style: const TextStyle(fontWeight: FontWeight.bold)),
              subtitle: Text(restaurant.address),
              trailing: const Icon(Icons.arrow_forward_ios_rounded, size: 16),
            ),
          ],
        ),
      ),
    );
  }
}
