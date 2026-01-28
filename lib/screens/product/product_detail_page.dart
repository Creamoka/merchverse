import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:merchverse/services/firebase/cart_service.dart';
import 'package:merchverse/services/firebase/wishlist_service.dart';
import '../../models/product_model.dart';

class ProductDetailPage extends StatefulWidget {
  final ProductModel product;

  const ProductDetailPage({super.key, required this.product});

  @override
  State<ProductDetailPage> createState() => _ProductDetailPageState();
}

class _ProductDetailPageState extends State<ProductDetailPage> {
  static const Color primary = Color(0xFF6DBFFF);

  final wishlistService = WishlistService();
  final cartService = CartService();
  bool isInWishlist = false;
  late String userId;

  @override
  void initState() {
    super.initState();
    final user = FirebaseAuth.instance.currentUser;
    if (user != null) {
      userId = user.uid;
    } else {
      userId = '';
    }
    _checkWishlistStatus();
  }

  Future<void> _checkWishlistStatus() async {
    if (userId.isEmpty) return;
    final exists = await wishlistService.isInWishlist(userId, widget.product.id);
    setState(() => isInWishlist = exists);
  }

  Future<void> _toggleWishlist() async {
    if (userId.isEmpty) return;

    if (isInWishlist) {
      await wishlistService.removeFromWishlist(userId, widget.product.id);
      setState(() => isInWishlist = false);
      _showSnackBar('Removed from wishlist!');
    } else {
      await wishlistService.addToWishlist(userId, widget.product);
      setState(() => isInWishlist = true);
      _showSnackBar('Added to wishlist!');
    }
  }

  void _showSnackBar(String message) {
    if (!context.mounted) return;

    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(message),
        behavior: SnackBarBehavior.floating,
        duration: const Duration(seconds: 1),
        margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        surfaceTintColor: Colors.transparent,
        elevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: Colors.black),
          onPressed: () => Navigator.pop(context),
        ),
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
                  widget.product.imageUrl,
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
                _TagChip(text: 'Original Product', color: primary),
                if (widget.product.exclusive)
                  _TagChip(text: 'Exclusive', color: primary),
                if (widget.product.collaboration)
                  _TagChip(text: 'Collaboration', color: primary),
              ],
            ),
            const SizedBox(height: 14),
            // NAME
            Text(
              widget.product.title,
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
              '\$${widget.product.price.toStringAsFixed(2)}',
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
            // ADD TO CART BUTTON
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
                onPressed: () async {
                  try {
                    await CartService().addToCart(widget.product);
                    if (!context.mounted) return;

                    _showSnackBar('Product added to cart!');
                  } catch (e) {
                    if (!context.mounted) return;

                    _showSnackBar('Failed to add product to cart!');
                  }
                },
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
              widget.product.description ?? 'Creativity flows wherever Hatsune Miku goes...',
              style: TextStyle(
                fontSize: 12,
                fontFamily: 'Montserrat',
                color: Colors.grey[700],
                height: 1.7,
              ),
            ),
            const SizedBox(height: 22),
          ],
        ),
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
        color: color.withOpacity(0.10),
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
