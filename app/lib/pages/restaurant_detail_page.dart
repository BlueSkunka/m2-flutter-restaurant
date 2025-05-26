import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import '../models/dish_category.dart';
import '../../components/restaurant_card.dart';
import '../../models/dish.dart';
import '../models/dish_category.dart';
import '../models/restaurant.dart';

final Restaurant restaurant = Restaurant(
  name: "Chez Mémé Simone",
  address: "25 rue du Pont, Lyon",
  rating: 4.6,
  description: "Bienvenue Chez Mémé Simone, une adresse où le temps semble suspendu. Ici, chaque plat raconte une histoire : celle des recettes transmises de génération en génération, mijotées avec amour comme le faisait Mémé Simone dans sa cuisine lyonnaise. Entre nappes à carreaux rouges, vaisselle d'époque et odeur envoûtante de gratin doré, vous retrouverez le goût simple et sincère des bons repas d’autrefois. Que vous veniez pour le fameux bœuf bourguignon, la tarte aux pommes caramélisée ou simplement pour une pause conviviale autour d’un verre de vin, Chez Mémé Simone vous ouvre les bras comme à la maison. Installez-vous, détendez-vous, et laissez vos papilles voyager dans le temps.",
  imageUrl: "https://media.s-bol.com/R71KZW2EDO1w/GLgxXK/550x366.jpg",
  menu: [DishCategory(name: "Boeuf bourguignon", price: 15.0)],
);
final List<DishCategory> menu = [DishCategory(name: "Boeuf bourguignon", price: 15.0)];

class RestaurantDetailPage extends StatelessWidget {

  const RestaurantDetailPage({
    super.key
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(restaurant.name),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Image.network(restaurant.imageUrl),
            const SizedBox(height: 16),
            Text(
              restaurant.name,
              style: Theme.of(context).textTheme.headlineMedium,
            ),
            const SizedBox(height: 8),
            Row(
              children: [
                const Icon(Icons.location_on, color: Colors.grey, size: 20),
                const SizedBox(width: 6),
                Expanded(
                  child: Text(
                    restaurant.address,
                    style: GoogleFonts.poppins(fontSize: 14, color: Colors.grey[700]),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 8),
            Row(
              children: [
                const Icon(Icons.star, color: Colors.amber, size: 20),
                const SizedBox(width: 6),
                Text(
                  restaurant.rating.toString(),
                  style: GoogleFonts.poppins(fontSize: 14, fontWeight: FontWeight.w600),
                ),
              ],
            ),
            const SizedBox(height: 8),
            Text(
              restaurant.description,
              style: Theme.of(context).textTheme.bodyMedium,
            ),
            const SizedBox(height: 24),
            ...menu.map((category) => Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  category.name,
                  style: Theme.of(context).textTheme.titleLarge,
                ),
                const SizedBox(height: 8),
                ListTile(title: Text('${category.price.toStringAsFixed(2)} €',)),
                const SizedBox(height: 24),
              ],
            )),
            const SizedBox(height: 24),
            SafeArea(
              child: Padding(
                padding: const EdgeInsets.all(16),
                child: SizedBox(
                  width: double.infinity,
                  child: ElevatedButton.icon(
                    onPressed: () {
                      // Action du bouton : navigation ou popup
                      showDialog(
                        context: context,
                        builder: (ctx) => AlertDialog(
                          title: const Text("Réservation"),
                          content: const Text("Souhaitez-vous réserver une table ?"),
                          actions: [
                            TextButton(
                              onPressed: () => Navigator.of(ctx).pop(),
                              child: const Text("Annuler"),
                            ),
                            TextButton(
                              onPressed: () {
                                Navigator.of(ctx).pop();
                                ScaffoldMessenger.of(context).showSnackBar(
                                  const SnackBar(content: Text("Table réservée !")),
                                );
                              },
                              child: const Text("Oui"),
                            ),
                          ],
                        ),
                      );
                    },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.blue[100],
                      padding: const EdgeInsets.symmetric(vertical: 14),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(12),
                      ),
                    ),
                    icon: const Icon(Icons.event_seat, color: Colors.black,),
                    label: Text(
                      "Réserver une table",
                      style: GoogleFonts.poppins(fontSize: 16, fontWeight: FontWeight.w500, color: Colors.black),
                    ),
                  ),
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}