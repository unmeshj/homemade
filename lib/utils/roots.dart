import 'package:flutter/material.dart';
import '../screens/login.dart';
import '../screens/splash.dart';
import '../screens/AddProduct.dart';
import '../screens/place_order.dart';
import '../screens/payment.dart';
import '../screens/successful.dart';
import '../screens/review.dart';
import '../screens/setting.dart';
import 'dart:typed_data';

final Map<String, WidgetBuilder> appRoutes = {
  '/': (context) => const SplashScreen(),
  '/login': (context) => const LoginScreen(),
  '/add_product': (context) => const AddProduct(),
  '/setting': (context) => const HomeScreen(),

  // Place Order route (example placeholder)
  '/place_order': (context) => const Scaffold(
        body: Center(
          child: Text('Navigate to this screen with MaterialPageRoute'),
        ),
      ),

  // Payment Screen with safe argument handling
  '/payment': (context) {
    final args =
        ModalRoute.of(context)?.settings.arguments as Map<String, dynamic>?;
    if (args == null) {
      return const Scaffold(
        body: Center(child: Text('No data received for payment!')),
      );
    }
    return PaymentScreen(
      imageList: args['imageList'] as List<Uint8List>,
      name: args['name'] as String,
      description: args['description'] as String,
      price: args['price'] as String,
      manufacturing: args['manufacturing'] as String,
    );
  },

  // Successful / Checkout Screen
  '/successful': (context) {
    final args =
        ModalRoute.of(context)?.settings.arguments as Map<String, dynamic>?;
    if (args == null) {
      return const Scaffold(
        body: Center(child: Text('No data received for checkout!')),
      );
    }
    return CheckoutPage(
      imageList: args['imageList'] as List<Uint8List>,
      name: args['name'] as String,
      description: args['description'] as String,
      price: args['price'] as String,
      manufacturing: args['manufacturing'] as String,
      size: args['size'] as String? ?? '7 UK',
      discount: args['discount'] as String? ?? '50% Off',
      originalPrice: args['originalPrice'] as String? ?? '2,999',
    );
  },

  // Product Review Page
  '/review': (context) {
    final args =
        ModalRoute.of(context)?.settings.arguments as Map<String, dynamic>?;
    if (args == null) {
      return const Scaffold(
        body: Center(child: Text('No data received for review!')),
      );
    }
    return ProductPage(
      imageList: args['imageList'] as List<Uint8List>,
      name: args['name'] as String,
      description: args['description'] as String,
      price: args['price'] as String,
      manufacturing: args['manufacturing'] as String,
      size: args['size'] as String,
      discount: args['discount'] as String,
      originalPrice: args['originalPrice'] as String,
    );
  },
};
