import 'package:flutter/material.dart';
import '../routes/app_routes.dart';

class MerchverseAppBar extends StatelessWidget implements PreferredSizeWidget {
  final bool showBack;
  final List<Widget>? actions;
  final String title;

  const MerchverseAppBar({
    super.key,
    this.showBack = false,
    this.actions,
    this.title = 'MERCHVERSE',
  });

  @override
  Widget build(BuildContext context) {
    return AppBar(
      elevation: 0,
      backgroundColor: Colors.white,
      surfaceTintColor: Colors.transparent,
      automaticallyImplyLeading: false,

      leading: showBack
          ? IconButton(
              icon: const Icon(Icons.arrow_back_ios_new, size: 18),
              color: Colors.black,
              onPressed: () => Navigator.pop(context),
            )
          : null,

      title: Text(
        title,
        style: const TextStyle(
          fontSize: 16,
          fontWeight: FontWeight.w600,
          color: Colors.black,
          letterSpacing: 0.5,
        ),
      ),

      actions: actions ??
          [
            IconButton(
              icon: const Icon(Icons.favorite_border, color: Colors.black),
              onPressed: () => Navigator.pushNamed(context, AppRoutes.wishlist),
            ),
            IconButton(
              icon: const Icon(Icons.shopping_bag_outlined, color: Colors.black),
              onPressed: () => Navigator.pushNamed(context, AppRoutes.cart),
            ),
          ],
    );
  }

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);
}
