import 'package:flutter/material.dart';
import '../../models/product_model.dart';

class ProductDetailPage extends StatelessWidget {
  final ProductModel product;

  const ProductDetailPage({super.key, required this.product});

  @override
  Widget build(BuildContext context) {
    const primary = Color(0xFF6DBFFF);

    return Scaffold(
      backgroundColor: Colors.white,

      // ✅ CONSISTENT APPBAR
      appBar: AppBar(
        backgroundColor: Colors.white,
        surfaceTintColor: Colors.transparent,
        elevation: 0,
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
        padding: const EdgeInsets.fromLTRB(22, 8, 22, 24),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // IMAGE
            Center(
              child: ClipRRect(
                borderRadius: BorderRadius.circular(14),
                child: Image.network(
                  product.image,
                  height: 260,
                  fit: BoxFit.contain,
                  errorBuilder: (context, error, stackTrace) {
                    return Container(
                      height: 260,
                      width: double.infinity,
                      alignment: Alignment.center,
                      color: Colors.grey[200],
                      child: const Icon(Icons.image_outlined, size: 60),
                    );
                  },
                ),
              ),
            ),

            const SizedBox(height: 14),

            // TAGS
            Wrap(
              spacing: 10,
              runSpacing: 10,
              children: [
                _TagChip(
                  text: 'Original Product',
                  color: primary,
                ),
                if (product.exclusive)
                  _TagChip(
                    text: 'Exclusive',
                    color: primary,
                  ),
                if (product.collaboration)
                  _TagChip(
                    text: 'Collaboration',
                    color: primary,
                  ),
              ],
            ),

            const SizedBox(height: 14),

            // NAME
            Text(
              product.name,
              style: const TextStyle(
                fontSize: 18,
                fontFamily: 'Montserrat',
                fontWeight: FontWeight.w700,
                color: Colors.black87,
              ),
            ),

            const SizedBox(height: 10),

            // PRICE
            Text(
              '\$${product.price.toStringAsFixed(2)}',
              style: const TextStyle(
                fontSize: 18,
                fontFamily: 'Montserrat',
                fontWeight: FontWeight.w700,
                color: Colors.black,
              ),
            ),

            const SizedBox(height: 10),

            // SHIPPING NOTE
            Text(
              'This pre-order item is expected to start shipping 1+ weeks after the order date.',
              style: TextStyle(
                fontSize: 12,
                fontFamily: 'Montserrat',
                color: Colors.grey[700],
                height: 1.6,
              ),
            ),

            const SizedBox(height: 18),

            // BUTTON
            SizedBox(
              width: double.infinity,
              height: 48,
              child: ElevatedButton(
                style: ElevatedButton.styleFrom(
                  backgroundColor: primary,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(25),
                  ),
                  elevation: 0,
                ),
                onPressed: () {},
                child: const Text(
                  'Add to Cart',
                  style: TextStyle(
                    fontFamily: 'Montserrat',
                    fontSize: 14,
                    fontWeight: FontWeight.w600,
                    color: Colors.white,
                  ),
                ),
              ),
            ),

            const SizedBox(height: 22),

            // DESCRIPTION
            const Text(
              'Description',
              style: TextStyle(
                fontSize: 16,
                fontFamily: 'Montserrat',
                fontWeight: FontWeight.w700,
              ),
            ),
            const SizedBox(height: 8),
            Text(
              product.description ??
                  'Creativity flows wherever Hatsune Miku goes...',
              style: TextStyle(
                fontSize: 12,
                fontFamily: 'Montserrat',
                color: Colors.grey[700],
                height: 1.7,
              ),
            ),

            const SizedBox(height: 22),

            // FEATURES
            const Text(
              'Features',
              style: TextStyle(
                fontSize: 16,
                fontFamily: 'Montserrat',
                fontWeight: FontWeight.w700,
              ),
            ),
            const SizedBox(height: 10),

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
      padding: const EdgeInsets.only(bottom: 10),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            margin: const EdgeInsets.only(top: 6),
            width: 6,
            height: 6,
            decoration: BoxDecoration(
              color: Colors.black,
              borderRadius: BorderRadius.circular(99),
            ),
          ),
          const SizedBox(width: 10),
          Expanded(
            child: Text(
              text,
              style: const TextStyle(
                fontFamily: 'Montserrat',
                fontSize: 12,
                height: 1.6,
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class _TagChip extends StatelessWidget {
  final String text;
  final Color color;

  const _TagChip({required this.text, required this.color});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 6),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(20),
        border: Border.all(color: color),
        color: color.withValues(alpha: 0.10),
      ),
      child: Text(
        text,
        style: TextStyle(
          fontFamily: 'Montserrat',
          fontSize: 11,
          fontWeight: FontWeight.w600,
          color: color,
        ),
      ),
    );
  }
}
