import 'package:flutter/material.dart';
import '../models/product_model.dart';
import '../screens/product/product_detail_page.dart';
import '../services/firebase/wishlist_service.dart';

class ProductCard extends StatefulWidget {
  final ProductModel product;

  const ProductCard({super.key, required this.product});

  @override
  State<ProductCard> createState() => _ProductCardState();
}

class _ProductCardState extends State<ProductCard> {
  final wishlistService = WishlistService();
  bool isInWishlist = false;
  final String userId = 'currentUserId'; // TODO: ganti pakai FirebaseAuth.instance.currentUser!.uid

  @override
  void initState() {
    super.initState();
    _checkWishlist();
  }

  Future<void> _checkWishlist() async {
    final exists = await wishlistService.isInWishlist(userId, widget.product.id);
    setState(() => isInWishlist = exists);
  }

  Future<void> _toggleWishlist() async {
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
    const primary = Color(0xFF6DBFFF);

    return GestureDetector(
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (_) => ProductDetailPage(product: widget.product),
          ),
        );
      },
      child: Container(
        margin: const EdgeInsets.only(bottom: 16),
        padding: const EdgeInsets.all(12),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(12),
          border: Border.all(color: Colors.grey.shade200),
        ),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // IMAGE
            ClipRRect(
              borderRadius: BorderRadius.circular(12),
              child: Image.network(
                widget.product.imageUrl,
                width: 90,
                height: 110,
                fit: BoxFit.cover,
                errorBuilder: (_, __, ___) => Container(
                  width: 90,
                  height: 110,
                  color: Colors.grey.shade200,
                  child: const Icon(Icons.image_not_supported),
                ),
              ),
            ),

            const SizedBox(width: 14),

            // INFO
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    widget.product.title,
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                    style: const TextStyle(
                      fontFamily: 'Montserrat',
                      fontSize: 14,
                      fontWeight: FontWeight.w700,
                      color: Colors.black87,
                    ),
                  ),
                  const SizedBox(height: 8),
                  Text(
                    '\$${widget.product.price.toStringAsFixed(2)}',
                    style: TextStyle(
                      fontFamily: 'Montserrat',
                      fontSize: 13,
                      fontWeight: FontWeight.w600,
                      color: Colors.grey.shade700,
                    ),
                  ),
                  const SizedBox(height: 10),
                  Wrap(
                    spacing: 8,
                    runSpacing: 8,
                    children: [
                      _chip('Original', primary),
                      if (widget.product.exclusive) _chip('Exclusive', primary),
                      if (widget.product.collaboration) _chip('Collaboration', primary),
                    ],
                  ),
                ],
              ),
            ),

            // FAVORITE ICON
            InkWell(
              onTap: _toggleWishlist,
              borderRadius: BorderRadius.circular(50),
              child: AnimatedSwitcher(
                duration: const Duration(milliseconds: 300),
                transitionBuilder: (child, animation) =>
                    ScaleTransition(scale: animation, child: child),
                child: Icon(
                  isInWishlist ? Icons.favorite : Icons.favorite_border,
                  key: ValueKey(isInWishlist),
                  color: Colors.redAccent,
                  size: 28,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  static Widget _chip(String text, Color color) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(20),
        border: Border.all(color: color),
        color: color.withOpacity(0.1),
      ),
      child: Text(
        text,
        style: TextStyle(
          fontFamily: 'Montserrat',
          fontSize: 10,
          fontWeight: FontWeight.w600,
          color: color,
        ),
      ),
    );
  }
}
