import 'package:flutter/material.dart';

void main() {
  runApp(const MerchVerseApp());
}

class MerchVerseApp extends StatelessWidget {
  const MerchVerseApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'MerchVerse',
      theme: ThemeData(
        primarySwatch: Colors.blue,
        scaffoldBackgroundColor: Colors.white,
      ),
      home: const OrderSummaryPage(),
    );
  }
}

class OrderSummaryPage extends StatelessWidget {
  const OrderSummaryPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF5F5F5),
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        leading: const SizedBox(),
        title: const Text(
          'Cart - Order Summary',
          style: TextStyle(
            color: Colors.black,
            fontSize: 16,
            fontWeight: FontWeight.w500,
          ),
        ),
        centerTitle: false,
      ),
      body: SingleChildScrollView(
        child: Container(
          color: Colors.white,
          margin: const EdgeInsets.only(top: 16),
          padding: const EdgeInsets.all(24),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              // Logo
              const Text(
                'MERCHVERSE',
                style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                  letterSpacing: 2,
                  color: Colors.black,
                ),
              ),
              const SizedBox(height: 8),

              // Order Summary Header
              const Text(
                'Order Summary',
                style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.w600,
                  color: Colors.black,
                ),
              ),
              const SizedBox(height: 4),
              const Text(
                'Check the stuff of your order before proceeding',
                style: TextStyle(fontSize: 12, color: Colors.grey),
                textAlign: TextAlign.center,
              ),
              const SizedBox(height: 24),

              // Divider
              Divider(color: Colors.grey[300], thickness: 1),
              const SizedBox(height: 16),

              // Order Items
              const OrderItem(
                imagePath:
                    'assets/images/hatsune_miku_figure.jpeg', // GANTI: Gambar Hatsune Miku figure
                title:
                    'Hatsune Miku - Hatsune Miku Trio Try-iT Prize Figure Figure Cat Ver.',
                price: '\$310.00',
              ),
              const SizedBox(height: 16),

              const OrderItem(
                imagePath:
                    'assets/images/sakura_miku.jpeg', // GANTI: Gambar Sakura Miku
                title:
                    'Hatsune Miku - Sakura Miku Noodle Stopper Prize Figure [FuRyu-Ver]',
                price: '\$310.00',
              ),
              const SizedBox(height: 16),

              const OrderItem(
                imagePath:
                    'assets/images/hatsune_dress.jpeg', // GANTI: Gambar Hatsune Miku dress
                title:
                    'Hatsune Miku - Hatsune Miku Trio Try-iT Prize Figure Figure Retro Ver.',
                price: '\$310.00',
              ),
              const SizedBox(height: 24),

              // Divider
              Divider(color: Colors.grey[300], thickness: 1),
              const SizedBox(height: 16),

              // Price Summary
              const Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    'Order Subtotal',
                    style: TextStyle(fontSize: 14, color: Colors.black87),
                  ),
                  Text(
                    '\$930.00',
                    style: TextStyle(
                      fontSize: 14,
                      fontWeight: FontWeight.w500,
                      color: Colors.black87,
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 8),

              const Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    'Estimate Shipping',
                    style: TextStyle(fontSize: 14, color: Colors.black87),
                  ),
                  Text(
                    'FREE',
                    style: TextStyle(
                      fontSize: 14,
                      fontWeight: FontWeight.w600,
                      color: Colors.green,
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 8),

              const Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    'Estimate tax',
                    style: TextStyle(fontSize: 14, color: Colors.black87),
                  ),
                  Text(
                    '\$10.00',
                    style: TextStyle(
                      fontSize: 14,
                      fontWeight: FontWeight.w500,
                      color: Colors.black87,
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 16),

              // Divider
              Divider(color: Colors.grey[300], thickness: 1),
              const SizedBox(height: 16),

              // Total
              const Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    'Total',
                    style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                      color: Colors.black,
                    ),
                  ),
                  Text(
                    '\$940.00',
                    style: TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                      color: Colors.black,
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 4),

              const Align(
                alignment: Alignment.centerLeft,
                child: Text(
                  'Including \$89.00 in taxes & 3 in handling',
                  style: TextStyle(fontSize: 11, color: Colors.grey),
                ),
              ),
              const SizedBox(height: 24),

              // Secure Info
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(Icons.lock_outline, size: 16, color: Colors.grey[600]),
                  const SizedBox(width: 6),
                  Text(
                    'Secure checkout. Privacy & safety with end-secure',
                    style: TextStyle(fontSize: 11, color: Colors.grey[600]),
                  ),
                ],
              ),
              const SizedBox(height: 24),

              // Pay Now Button
              SizedBox(
                width: double.infinity,
                child: ElevatedButton(
                  onPressed: () {
                    // Handle payment
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: const Color(0xFF4DA6E8),
                    foregroundColor: Colors.white,
                    padding: const EdgeInsets.symmetric(vertical: 16),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(8),
                    ),
                    elevation: 0,
                  ),
                  child: const Text(
                    'Pay Now',
                    style: TextStyle(fontSize: 15, fontWeight: FontWeight.w600),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class OrderItem extends StatelessWidget {
  final String imagePath;
  final String title;
  final String price;

  const OrderItem({
    Key? key,
    required this.imagePath,
    required this.title,
    required this.price,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        // Image
        ClipRRect(
          borderRadius: BorderRadius.circular(8),
          child: Container(
            width: 50,
            height: 50,
            color: Colors.grey[100],
            child: Image.asset(
              imagePath,
              fit: BoxFit.cover,
              errorBuilder: (context, error, stackTrace) {
                return Center(
                  child: Icon(Icons.image, size: 25, color: Colors.grey[400]),
                );
              },
            ),
          ),
        ),
        const SizedBox(width: 12),

        // Title
        Expanded(
          child: Text(
            title,
            style: const TextStyle(
              fontSize: 12,
              color: Colors.black87,
              height: 1.4,
            ),
            maxLines: 3,
            overflow: TextOverflow.ellipsis,
          ),
        ),
        const SizedBox(width: 12),

        // Price
        Text(
          price,
          style: const TextStyle(
            fontSize: 14,
            fontWeight: FontWeight.w600,
            color: Colors.black,
          ),
        ),
      ],
    );
  }
}
