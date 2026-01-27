import 'package:flutter/material.dart';
import '../screens/auth/splash_screen.dart';
import '../screens/auth/sign_in_page.dart';
import '../screens/auth/sign_up_page.dart';
import '../screens/home/home_page.dart';
import '../screens/cart/cart_page.dart';
import '../screens/wishlist/wishlist_page.dart';
import '../screens/account/history_page.dart';

class AppRoutes {
  static const splash = '/';
  static const signIn = '/sign-in';
  static const signUp = '/sign-up';
  static const home = '/home';
  static const cart = '/cart';
  static const wishlist = '/wishlist';
  static const history = '/history';

  static Map<String, WidgetBuilder> routes = {
    splash: (_) => const SplashScreen(),
    signIn: (_) => const SignInPage(),
    signUp: (_) => const SignUpPage(),
    home: (_) => const HomePage(),
    cart: (_) => const CartPage(),
    wishlist: (_) => const WishlistPage(),
    history: (_) => const HistoryPage(),
  };
}