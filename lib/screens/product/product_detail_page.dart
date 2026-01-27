import 'package:flutter/material.dart';
import '../../models/product_model.dart';

class ProductDetailPage extends StatelessWidget {
  final ProductModel product;

  const ProductDetailPage({super.key, required this.product});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,

      appBar: AppBar(
        elevation: 0,
        backgroundColor: Colors.white,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: Colors.black),
          onPressed: () => Navigator.pop(context),
        ),
        actions: [
          IconButton(
            icon: const Icon(Icons.favorite_border, color: Colors.black),
            onPressed: () {},
          ),
        ],
      ),

      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [

            // 🔥 PRODUCT IMAGE
            Center(
              child: Image.network(
                product.image,
                height: 260,
                fit: BoxFit.contain,
              ),
            ),

            const SizedBox(height: 16),

            // TAG
            const Center(
              child: Text(
                '✨ Original Product',
                style: TextStyle(
                  color: Colors.blue,
                  fontWeight: FontWeight.w500,
                ),
              ),
            ),

            const SizedBox(height: 16),

            // PRODUCT NAME
            Text(
              product.name,
              style: const TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
              ),
            ),

            const SizedBox(height: 8),

            Text(
              'This pre-order item is expected to start shipping 1+ weeks after the order date.',
              style: TextStyle(
                fontSize: 12,
                color: Colors.grey.shade600,
              ),
            ),

            const SizedBox(height: 16),

            // ADD TO CART
            SizedBox(
              width: double.infinity,
              height: 50,
              child: ElevatedButton(
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.lightBlue,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(25),
                  ),
                ),
                onPressed: () {},
                child: const Text(
                  'Add to Cart',
                  style: TextStyle(fontSize: 16),
                ),
              ),
            ),

            const SizedBox(height: 20),

            // DESCRIPTION
            Text(
              product.description ??
                  'Creativity flows wherever Hatsune Miku goes...',
              style: const TextStyle(
                fontSize: 14,
                height: 1.5,
              ),
            ),

            const SizedBox(height: 20),

            // FEATURES
            const Text(
              'Features',
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
              ),
            ),

            const SizedBox(height: 8),

            _featureItem('Officially licensed'),
            _featureItem('Brand: FuRyu'),
            _featureItem('Material: PVC'),
            _featureItem('Height: 190mm'),
            _featureItem('Mint condition graded packaging not guaranteed'),
          ],
        ),
      ),
    );
  }

  Widget _featureItem(String text) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 6),
      child: Row(
        children: [
          const Icon(Icons.circle, size: 6),
          const SizedBox(width: 8),
          Expanded(child: Text(text)),
        ],
      ),
    );
  }
}
