import 'package:flutter/material.dart';
import '../routes/app_routes.dart';

class MainLayout extends StatelessWidget {
  final int currentIndex;
  final Widget body;
  final String title;
  final bool showActions;

  const MainLayout({
    super.key,
    required this.currentIndex,
    required this.body,
    this.title = 'MERCHVERSE',
    this.showActions = true,
  });

  void _onNavTap(BuildContext context, int index) {
    if (index == currentIndex) return;

    switch (index) {
      case 0:
        Navigator.pushReplacementNamed(context, AppRoutes.home);
        break;
      case 1:
        Navigator.pushReplacementNamed(context, AppRoutes.product);
        break;
      case 2:
        Navigator.pushReplacementNamed(context, AppRoutes.history);
        break;
      case 3:
        Navigator.pushReplacementNamed(context, AppRoutes.account);
        break;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,

      appBar: AppBar(
        backgroundColor: Colors.white,
        surfaceTintColor: Colors.transparent,
        elevation: 0,
        automaticallyImplyLeading: false,
        title: Text(
          title,
          style: const TextStyle(
            fontSize: 16,
            fontFamily: 'Raleway',
            color: Colors.black,
            fontWeight: FontWeight.w600,
          ),
        ),
        actions: showActions
            ? [
                IconButton(
                  icon: const Icon(Icons.favorite_border, color: Colors.black),
                  onPressed: () {
                    Navigator.pushNamed(context, AppRoutes.wishlist);
                  },
                ),
                IconButton(
                  icon: const Icon(Icons.shopping_bag_outlined,
                      color: Colors.black),
                  onPressed: () {
                    Navigator.pushNamed(context, AppRoutes.cart);
                  },
                ),
              ]
            : null,
      ),

      body: body,

      bottomNavigationBar: BottomNavigationBar(
        backgroundColor: Colors.white,
        currentIndex: currentIndex,
        onTap: (index) => _onNavTap(context, index),
        type: BottomNavigationBarType.fixed,
        selectedItemColor: const Color(0xFF6DBFFF),
        unselectedItemColor: Colors.grey,
        selectedFontSize: 12,
        unselectedFontSize: 12,
        items: const [
          BottomNavigationBarItem(
            icon: Icon(Icons.home_outlined),
            activeIcon: Icon(Icons.home),
            label: 'Home',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.shopping_bag_outlined),
            activeIcon: Icon(Icons.shopping_bag),
            label: 'Product',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.receipt_long_outlined),
            activeIcon: Icon(Icons.receipt_long),
            label: 'History',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.person_outline),
            activeIcon: Icon(Icons.person),
            label: 'Account',
          ),
        ],
      ),
    );
  }
}
