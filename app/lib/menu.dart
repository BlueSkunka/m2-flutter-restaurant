import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class MenuWidget extends StatelessWidget {
  final int currentIndex;

  const MenuWidget({
    Key? key,
    required this.currentIndex,
  }) : super(key: key);

  void _navigate(BuildContext context, int index) {
    if (index == currentIndex) return; // Evite de recharger la même page

    switch (index) {
      case 0:
        Navigator.pushReplacementNamed(context, '/home');
        break;
      case 1:
        Navigator.pushReplacementNamed(context, '/menu');
        break;
      case 2:
        Navigator.pushReplacementNamed(context, '/reservation');
        break;
      case 3:
        Navigator.pushReplacementNamed(context, '/profile');
        break;
    }
  }

  @override
  Widget build(BuildContext context) {
    return BottomNavigationBar(
      currentIndex: currentIndex,
      onTap: (index) => _navigate(context, index),
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
    );
  }
}
