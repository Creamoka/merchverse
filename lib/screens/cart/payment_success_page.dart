import 'package:flutter/material.dart';
import '../../routes/app_routes.dart';

class PaymentSuccessPage extends StatefulWidget {
  const PaymentSuccessPage({super.key});

  @override
  State<PaymentSuccessPage> createState() => _PaymentSuccessPageState();
}

class _PaymentSuccessPageState extends State<PaymentSuccessPage> {
  @override
  void initState() {
    super.initState();

    // Delay 3 detik, lalu otomatis kembali ke home
    Future.delayed(const Duration(seconds: 3), () {
      if (mounted) {
        Navigator.pushNamedAndRemoveUntil(
          context,
          AppRoutes.home,
          (route) => false,
        );
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(22),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Icon(Icons.check_circle, size: 90, color: Color(0xFF6DBFFF)),
              const SizedBox(height: 18),
              const Text(
                "Payment Successful!",
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.w700),
              ),
              const SizedBox(height: 8),
              Text(
                "Thank you for your purchase.",
                style: TextStyle(color: Colors.grey.shade700),
              ),
              const SizedBox(height: 26),
              SizedBox(
                width: double.infinity,
                height: 46,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
