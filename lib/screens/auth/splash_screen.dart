import 'package:flutter/material.dart';
<<<<<<< HEAD
=======
import 'dart:async';
>>>>>>> rizal
import '../../routes/app_routes.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    super.initState();
<<<<<<< HEAD
    _navigate();
  }

  void _navigate() async {
    await Future.delayed(const Duration(seconds: 2));
    if (!mounted) return;

    Navigator.pushReplacementNamed(
      context,
      AppRoutes.product, // langsung ke product dulu
    );
=======
    _navigateToHome();
  }

  Future<void> _navigateToHome() async {
    // Tunggu 2 detik untuk menampilkan splash screen
    await Future.delayed(const Duration(seconds: 2));

    if (!mounted) return;

    // Langsung arahkan ke home tanpa cek auth status
    Navigator.pushReplacementNamed(context, AppRoutes.home);
>>>>>>> rizal
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Center(
<<<<<<< HEAD
        child: Text(
          'MERCHVERSE',
          style: TextStyle(
            fontSize: 26,
            fontWeight: FontWeight.bold,
=======
        child: Padding(
          padding: const EdgeInsets.only(bottom: 45),
          child: const Text(
            'MERCHVERSE',
            style: TextStyle(
              fontSize: 29,
              fontFamily: 'Raleway',
              color: Colors.black,
            ),
>>>>>>> rizal
          ),
        ),
      ),
    );
  }
}
