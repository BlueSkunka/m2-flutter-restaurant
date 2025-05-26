import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

void main() {
  runApp(const RestaurantApp());
}

class RestaurantApp extends StatelessWidget {
  const RestaurantApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Menu du Restaurant',
      theme: ThemeData(
        fontFamily: GoogleFonts.poppins().fontFamily,
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
      ),
      home: const MenuPage(title: "Votre table, quelle que soit l'occasion"),
    );
  }
}

class MenuPage extends StatefulWidget {
  const MenuPage({super.key, required this.title});
  final String title;

  @override
  State<MenuPage> createState() => _MenuPageState();
}

class _MenuPageState extends State<MenuPage> {
  final List<String> categories = [
    'Burger',
    'Pizza',
    'Café',
    'Boulangerie',
    'Asiatique',
    'Indien',
    'Italien',
    'Tacos',
    'Steak',
    'Desserts'
  ];
  String selectedCategory = 'Entrées';

  final List<Map<String, dynamic>> restaurants = [
    {
      "name": "Chez Mémé Simone",
      "address": "25 rue du Pont, Lyon",
      "rating": 4.6,
      "imageUrl": "https://media.s-bol.com/R71KZW2EDO1w/GLgxXK/550x366.jpg"
    },
    {
      "name": "Pizza Bella",
      "address": "123 Rue de Rome, Lyon",
      "rating": 4.5,
      "imageUrl": "https://images.unsplash.com/photo-1566843972142-a7fcb70de55a?q=80&w=870&auto=format&fit=crop&ixlib=rb-4.1.0&ixid=M3wxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8fA%3D%3D"
    },
    {
      "name": "Café Douceur",
      "address": "45 Avenue du Parc, Lyon",
      "rating": 4.8,
      "imageUrl": "https://images.unsplash.com/photo-1495474472287-4d71bcdd2085?q=80&w=870&auto=format&fit=crop&ixlib=rb-4.1.0&ixid=M3wxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8fA%3D%3D"
    },
    {
      "name": "Boulangerie Artisanale",
      "address": "2 Rue des Fleurs, Lyon",
      "rating": 4.6,
      "imageUrl": "https://images.unsplash.com/photo-1568254183919-78a4f43a2877?q=80&w=869&auto=format&fit=crop&ixlib=rb-4.1.0&ixid=M3wxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8fA%3D%3D"
    },
  ];

  // Catégorie de restaurants
  Map<String, String> categoryEmojis = {
    "Burger": "🍔",
    "Pizza": "🍕",
    "Café": "☕",
    "Boulangerie": "🥐",
    "Asiatique": "🍣",
    "Indien": "🥘",
    "Italien": "🍝",
    "Tacos": "🌯",
    "Steak": "🥩",
    "Desserts": "🍪"
  };

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // --- Nouveau Header personnalisé ---
            Container(
              width: double.infinity,
              padding: const EdgeInsets.symmetric(vertical: 40),
              decoration: BoxDecoration(
                color: Colors.blue[50],
              ),
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16.0), // marge gauche/droite
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start, // alignement à gauche
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Text(
                      widget.title,
                      style: const TextStyle(
                        fontSize: 36,
                        fontWeight: FontWeight.bold,
                        color: Colors.black,
                      ),
                    ),
                    const SizedBox(height: 8),
                    const Text(
                      'Découvrez et réservez les meilleurs restaurants',
                      style: TextStyle(
                        fontSize: 18,
                        fontStyle: FontStyle.italic,
                        color: Colors.black87,
                      ),
                    ),
                  ],
                ),
              ),
            ),

            const SizedBox(height: 10),

            // --- Liste horizontale des catégories ---
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        "Catégories", // Ton titre
                        style: TextStyle(
                          fontSize: 24,
                          fontWeight: FontWeight.bold,
                          fontFamily: GoogleFonts.poppins().fontFamily,
                        ),
                      ),
                      TextButton(
                        onPressed: () {
                          // Action pour "Voir tout"
                        },
                        child: Text(
                          "Voir tout",
                          style: TextStyle(
                            fontSize: 14,
                            fontWeight: FontWeight.w600,
                            color: Colors.teal,
                            fontFamily: GoogleFonts.poppins().fontFamily,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                SizedBox(
                  height: 100,
                  child: ListView.builder(
                    scrollDirection: Axis.horizontal,
                    itemCount: categories.length,
                    padding: const EdgeInsets.symmetric(horizontal: 10),
                    itemBuilder: (context, index) {
                      final category = categories[index];
                      final isSelected = category == selectedCategory;

                      return Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 8),
                        child: GestureDetector(
                          onTap: () {
                            setState(() {
                              selectedCategory = category;
                            });
                          },
                          child: Column(
                            children: [
                              Container(
                                width: 60,
                                height: 60,
                                decoration: BoxDecoration(
                                  color: isSelected ? Colors.teal : Colors.grey[300],
                                  borderRadius: BorderRadius.circular(15),
                                ),
                                child: Center(
                                  child: Text(
                                    categoryEmojis[category] ?? "🍽️",
                                    style: TextStyle(fontSize: 24),
                                  ),
                                ),
                              ),
                              const SizedBox(height: 4),
                              Text(
                                category,
                                style: TextStyle(
                                  color: isSelected ? Colors.teal : Colors.black87,
                                  fontSize: 12,
                                  fontWeight: FontWeight.w500,
                                  fontFamily: GoogleFonts.poppins().fontFamily,
                                ),
                              ),
                            ],
                          ),
                        ),
                      );
                    },
                  ),
                ),
              ],
            ),

            // Divider
            const Padding(
              padding: EdgeInsets.symmetric(horizontal: 16.0),
              child: Divider(
                  thickness: 0.5,
                  color: Colors.grey,
                  height: 32
              ),
            ),

            const SizedBox(height: 10),

            // --- Liste des plats ---
            Padding(
              padding: const EdgeInsets.only(bottom: 24, left: 16, right: 16),
              child: Text(
                "Restaurants populaires",
                style: TextStyle(
                  fontSize: 22,
                  fontWeight: FontWeight.bold,
                  fontFamily: GoogleFonts.poppins().fontFamily,
                ),
              ),
            ),

            ListView.builder(
              itemCount: restaurants.length,
              shrinkWrap: true,
              physics: NeverScrollableScrollPhysics(),
              padding: const EdgeInsets.symmetric(horizontal: 16),
              itemBuilder: (context, index) {
                final restaurant = restaurants[index];

                return Card(
                  margin: const EdgeInsets.only(bottom: 16),
                  elevation: 4,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(16),
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      ClipRRect(
                        borderRadius: const BorderRadius.vertical(top: Radius.circular(16)),
                        child: Image.network(
                          restaurant['imageUrl'],
                          height: 180,
                          width: double.infinity,
                          fit: BoxFit.cover,
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.all(12.0),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              restaurant['name'],
                              style: TextStyle(
                                fontSize: 18,
                                fontWeight: FontWeight.bold,
                                fontFamily: GoogleFonts.poppins().fontFamily,
                              ),
                            ),
                            const SizedBox(height: 4),
                            Row(
                              children: [
                                const Icon(Icons.location_on, size: 16, color: Colors.grey),
                                const SizedBox(width: 4),
                                Expanded(
                                  child: Text(
                                    restaurant['address'],
                                    style: TextStyle(
                                      color: Colors.grey[700],
                                      fontSize: 14,
                                      fontFamily: GoogleFonts.poppins().fontFamily,
                                    ),
                                  ),
                                ),
                              ],
                            ),
                            const SizedBox(height: 6),
                            Row(
                              children: [
                                const Icon(Icons.star, size: 16, color: Colors.amber),
                                const SizedBox(width: 4),
                                Text(
                                  restaurant['rating'].toString(),
                                  style: TextStyle(
                                    fontWeight: FontWeight.w600,
                                    fontSize: 14,
                                    fontFamily: GoogleFonts.poppins().fontFamily,
                                  ),
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                );
              },
            ),
          ],
        ),
      )
    );
  }
}
