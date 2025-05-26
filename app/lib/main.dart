import 'package:flutter/material.dart';
import 'package:flutter_restaurant_app/pages/reservation_page.dart';
import 'package:flutter_restaurant_app/pages/restaurant_detail_page.dart';
import 'package:flutter_restaurant_app/pages/restaurant_menu_page.dart';
import 'package:flutter_restaurant_app/pages/utilisateur_page.dart';
import 'package:flutter_restaurant_app/models/dish_category.dart';
import 'package:flutter_restaurant_app/models/restaurant.dart';
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
      title: 'Mémé Simone',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
      ),
      home: const MainScreen(title: 'Mémé Simone'),
    );
  }
}

class MainScreen extends StatefulWidget {
  const MainScreen({super.key, required this.title});
  final String title;

  @override
  State<MainScreen> createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {
  // Gestion de l'index du menu choisis (écran)
  int _selectedIndex = 0;

  // Liste des écrans dispo
  final List<Widget> _screens = [
    const RestaurantDetailPage(),
    const RestaurantMenuPage(title: ''),
    const ReservationPage(),
    const UtilisateurPage()
  ];

  // Récupère l'écran à partir d'un index
  Widget get _currentScreen => _screens[_selectedIndex];

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        title: Text(widget.title),
      ),
      body: Center(
        child: _currentScreen,
      ),
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _selectedIndex,
        onTap: (index) => _onItemTapped(index),
        type: BottomNavigationBarType.fixed,
        backgroundColor: Colors.blue,
        selectedItemColor: Colors.black,
        items: const [
          BottomNavigationBarItem(
              icon: Icon(Icons.home),
              label: 'Accueil'
          ),
          BottomNavigationBarItem(
              icon: Icon(Icons.restaurant_menu),
              label: 'Menu'
          ),
          BottomNavigationBarItem(
              icon: Icon(Icons.account_circle),
              label: 'Réservation'
          ),
          BottomNavigationBarItem(
              icon: Icon(Icons.event_note),
              label: 'Profile'
          )
        ],
      ), // Current index dépend de la page affiché
    );
  }
}


