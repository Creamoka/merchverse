import 'package:flutter/material.dart';
import 'package:merchverse/routes/app_routes.dart';
import '../../models/cart_item_model.dart';

class PaymentPage extends StatefulWidget {
  final List<CartItemModel>? cartItems;
  final Map<String, dynamic>? shippingAddress;
  final String? shippingMethod;
  final int? shippingPrice;

  const PaymentPage({
    super.key,
    this.cartItems,
    this.shippingAddress,
    this.shippingMethod,
    this.shippingPrice,
  });

  @override
  State<PaymentPage> createState() => _PaymentPageState();
}

class _PaymentPageState extends State<PaymentPage> {
  String _selectedPaymentMethod = 'Credit/Card';

  @override
  Widget build(BuildContext context) {
     // Ambil data dari arguments jika tersedia, jika tidak gunakan dari widget properties
    final args =
        ModalRoute.of(context)!.settings.arguments as Map<String, dynamic>?;
    final cartItems = args?['cartItems'] ?? widget.cartItems ?? [];
    final shippingAddress =
        args?['shippingAddress'] ?? widget.shippingAddress ?? {};
    final shippingMethod =
        args?['shippingMethod'] ?? widget.shippingMethod ?? '';
    final shippingPrice = args?['shippingPrice'] ?? widget.shippingPrice ?? 0;

    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () => Navigator.pop(context),
        ),
        title: const Text(
          'Payment',
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
      backgroundColor: Colors.grey[50],
      body: Padding(
        padding: const EdgeInsets.all(24.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const SizedBox(height: 20),
            const Text(
              'Payment',
              style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 24),

            // Payment Options
            _buildPaymentOption('Credit/Card', 'VISA'),
            const SizedBox(height: 12),
            _buildPaymentOption('Paypal', 'P'),
            const SizedBox(height: 12),
            _buildPaymentOption('Alternative', 'a/Pay'),
            const SizedBox(height: 24),

            // Return link
            InkWell(
              onTap: () => Navigator.pop(context),
              child: Row(
                children: [
                  Icon(Icons.arrow_back_ios, size: 14, color: Colors.blue[600]),
                  const SizedBox(width: 4),
                  Text(
                    'Return to Method',
                    style: TextStyle(
                      fontSize: 14,
                      color: Colors.blue[600],
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 16),

            // Continue to Order Summary
            SizedBox(
              width: double.infinity,
              height: 50,
              child: ElevatedButton(
                onPressed: () {
                  Navigator.pushNamed(
                    context,
                    AppRoutes.orderSummary,
                    arguments: {
                      'cartItems': cartItems, // tetap List<CartItemModel>
                      'shippingAddress': shippingAddress,
                      'shippingMethod': shippingMethod,
                      'shippingPrice': shippingPrice,
                      'paymentMethod': _selectedPaymentMethod,
                    },
                  );
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: const Color(0xFF0EA5E9),
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(8)),
                  elevation: 0,
                ),
                child: const Text(
                  'Order Summary',
                  style: TextStyle(fontSize: 16, fontWeight: FontWeight.w500, color: Colors.white),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildPaymentOption(String method, String logo) {
    final isSelected = _selectedPaymentMethod == method;
    return GestureDetector(
      onTap: () {
        setState(() => _selectedPaymentMethod = method);
      },
      child: Container(
        width: double.infinity,
        padding: const EdgeInsets.symmetric(horizontal: 18, vertical: 16),
        decoration: BoxDecoration(
          color: Colors.white,
          border: Border.all(
            color: isSelected ? const Color(0xFF0EA5E9) : Colors.grey[300]!,
            width: isSelected ? 2 : 1,
          ),
          borderRadius: BorderRadius.circular(8),
        ),
        child: Row(
          children: [
            Icon(
              isSelected ? Icons.radio_button_checked : Icons.radio_button_off,
              color: isSelected ? const Color(0xFF0EA5E9) : Colors.grey[400],
              size: 22,
            ),
            const SizedBox(width: 12),
            Expanded(
              child: Text(
                method,
                style: TextStyle(
                  fontSize: 15,
                  color: isSelected ? const Color(0xFF0EA5E9) : Colors.grey[800],
                  fontWeight: isSelected ? FontWeight.w600 : FontWeight.normal,
                ),
              ),
            ),
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
              decoration: BoxDecoration(
                color: Colors.grey[100],
                borderRadius: BorderRadius.circular(4),
              ),
              child: Text(
                logo,
                style: TextStyle(fontSize: 12, fontWeight: FontWeight.w600, color: Colors.grey[700]),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
