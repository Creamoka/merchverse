import 'package:flutter/material.dart';
import 'package:merchverse/screens/auth/sign_in_page.dart';
import 'package:merchverse/screens/auth/sign_up_page.dart';
import 'package:merchverse/screens/auth/splash_screen.dart';
import 'package:merchverse/screens/home/home_page.dart';
import 'package:merchverse/screens/product/product_page.dart';

class AppRoutes {
  static const splash = '/';
  static const signIn = '/sign-in';
  static const signUp = '/sign-up';
  static const home = '/home';
  static const product = '/product';

  static Map<String, WidgetBuilder> routes = {
    splash: (_) => const SplashScreen(),
    signIn: (_) => const SignInPage(),
    signUp: (_) => const SignUpPage(),
    home: (_) => const HomePage(),
    product: (_) => const ProductPage(),
  };
}
