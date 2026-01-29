import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:merchverse/routes/app_routes.dart';
import '../../models/cart_item_model.dart';
import '../../services/firebase/cart_service.dart';

class OrderSummaryPage extends StatelessWidget {
  final List<CartItemModel> cartItems;
  final String shippingMethod;
  final int shippingPrice;
  final String paymentMethod;

  const OrderSummaryPage({
    super.key,
    required this.cartItems,
    required this.shippingMethod,
    required this.shippingPrice,
    required this.paymentMethod,
  });

  @override
  Widget build(BuildContext context) {
    // Hitung subtotal
    double subtotal = cartItems.fold(
      0,
      (sum, item) => sum + item.price * item.qty,
    );
    double tax = subtotal * 0.1; // 10% tax
    double total = subtotal + tax + shippingPrice;

    final _auth = FirebaseAuth.instance;
    final _firestore = FirebaseFirestore.instance;

    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () => Navigator.pop(context),
        ),
        title: const Text(
          'Order Summary',
          style: TextStyle(fontSize: 18, fontWeight: FontWeight.w500),
        ),
        backgroundColor: Colors.white,
        foregroundColor: Colors.black,
        elevation: 0,
        bottom: PreferredSize(
          preferredSize: const Size.fromHeight(1),
          child: Container(color: Colors.grey[300], height: 1),
        ),
      ),
      backgroundColor: Colors.white,
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              'Order Summary',
              style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 16),

            // List Cart Items
            ...cartItems.map((item) {
              return Padding(
                padding: const EdgeInsets.only(bottom: 12),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Expanded(child: Text('${item.title} x${item.qty}')),
                    Text('\$${(item.price * item.qty).toStringAsFixed(2)}'),
                  ],
                ),
              );
            }).toList(),

            const SizedBox(height: 16),
            Divider(color: Colors.grey[300], thickness: 1),
            const SizedBox(height: 8),

            // Subtotal / Shipping / Tax / Total
            _buildPriceRow('Subtotal', subtotal),
            _buildPriceRow(
              'Shipping ($shippingMethod)',
              shippingPrice.toDouble(),
            ),
            _buildPriceRow('Tax', tax),
            const SizedBox(height: 8),
            _buildPriceRow('Total', total, isTotal: true),

            const SizedBox(height: 24),

            // Pay Now Button
            SizedBox(
              width: double.infinity,
              height: 50,
              child: ElevatedButton(
                onPressed: () async {
                  final user = _auth.currentUser;
                  if (user == null) return;

                  try {
                    // Simpan ke Firestore
                    await _firestore.collection('orders').add({
                      'userId': user.uid,
                      'items': cartItems.map((e) => e.toFirestore()).toList(),
                      'shippingMethod': shippingMethod,
                      'shippingPrice': shippingPrice,
                      'paymentMethod': paymentMethod,
                      'subtotal': subtotal,
                      'tax': tax,
                      'total': total,
                      'timestamp': FieldValue.serverTimestamp(),
                    });

                    // Hapus semua cart items setelah order berhasil
                    final cartService = CartService();
                    await cartService.clearCart();

                    Navigator.pushNamed(context, AppRoutes.paymentSuccess);
                  } catch (e) {
                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(content: Text('Failed to place order: $e')),
                    );
                  }
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: const Color(0xFF0EA5E9),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(8),
                  ),
                  elevation: 0,
                ),
                child: const Text(
                  'Pay Now',
                  style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.w500,
                    color: Colors.white,
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildPriceRow(String label, double value, {bool isTotal = false}) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 4),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            label,
            style: TextStyle(
              fontWeight: isTotal ? FontWeight.bold : FontWeight.normal,
            ),
          ),
          Text(
            '\$${value.toStringAsFixed(2)}',
            style: TextStyle(
              fontWeight: isTotal ? FontWeight.bold : FontWeight.normal,
            ),
          ),
        ],
      ),
    );
  }
}
