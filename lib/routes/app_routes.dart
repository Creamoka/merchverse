import 'package:flutter/material.dart';
import 'package:merchverse/screens/account/account_page.dart';
import '../screens/auth/splash_screen.dart';
import '../screens/auth/sign_in_page.dart';
import '../screens/auth/sign_up_page.dart';
import '../screens/home/home_page.dart';
import '../screens/cart/cart_page.dart';
import '../screens/wishlist/wishlist_page.dart';
import '../screens/account/history_page.dart';
import '../screens/product/product_page.dart';
import '../screens/cart/shipping_address_page.dart';
import '../screens/cart/shipping_method_page.dart';
import '../screens/cart/payment_page.dart';
import '../screens/cart/order_summary_page.dart';
import '../screens/cart/payment_success_page.dart';

class AppRoutes {
  static const splash = '/';
  static const signIn = '/sign-in';
  static const signUp = '/sign-up';
  static const home = '/home';
  static const product = '/product';
  static const cart = '/cart';
  static const wishlist = '/wishlist';
  static const history = '/history';
  static const account = '/account';
  static const shippingAddress = '/shipping-address';
  static const shippingMethod = '/shipping-method';
  static const payment = '/payment';
  static const orderSummary = '/order-summary';
  static const paymentSuccess = '/payment-success';

  static Map<String, WidgetBuilder> routes = {
    splash: (_) => const SplashScreen(),
    signIn: (_) => const SignInPage(),
    signUp: (_) => const SignUpPage(),
    home: (_) => const HomePage(),
    product: (_) => const ProductPage(),
    cart: (_) => const CartPage(),
    wishlist: (_) => const WishlistPage(),
    history: (_) => const HistoryPage(),
    account: (_) => const AccountPage(),
    shippingAddress: (context) {
      final args =
          ModalRoute.of(context)!.settings.arguments as Map<String, dynamic>? ??
          {};
      return ShippingAddressPage(cartItems: args['cartItems'] ?? []);
    },
    shippingMethod: (_) => const ShippingMethodSelectionPage(),
    payment: (context) {
      final args =
          ModalRoute.of(context)!.settings.arguments as Map<String, dynamic>? ??
          {};
      return PaymentPage(
        cartItems: args['cartItems'] ?? [],
        shippingAddress: args['shippingAddress'] ?? {},
        shippingMethod: args['shippingMethod'] ?? '',
        shippingPrice: args['shippingPrice'] ?? 0,
      );
    },
    orderSummary: (context) {
      final args =
          ModalRoute.of(context)!.settings.arguments as Map<String, dynamic>? ??
          {};
      return OrderSummaryPage(
        cartItems: args['cartItems'] ?? [],
        shippingMethod: args['shippingMethod'] ?? '',
        shippingPrice: args['shippingPrice'] ?? 0,
        paymentMethod: args['paymentMethod'] ?? '',
      );
    },
    paymentSuccess: (_) => const PaymentSuccessPage(),
  };
}
