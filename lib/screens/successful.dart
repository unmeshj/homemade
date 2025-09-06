import 'package:flutter/material.dart';
import 'dart:typed_data';
import 'review.dart';

class CheckoutPage extends StatefulWidget {
  final List<Uint8List> imageList;
  final String name;
  final String description;
  final String price;
  final String manufacturing;
  final String size;
  final String discount;
  final String originalPrice;

  const CheckoutPage({
    super.key,
    required this.imageList,
    required this.name,
    required this.description,
    required this.price,
    required this.manufacturing,
    required this.size,
    required this.discount,
    required this.originalPrice,
  });

  @override
  State<CheckoutPage> createState() => _CheckoutPageState();
}

class _CheckoutPageState extends State<CheckoutPage> {
  void _showSuccessDialog() {
    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (BuildContext context) {
        Future.delayed(const Duration(seconds: 3), () {
          Navigator.of(context).pop();
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => ProductPage(
                imageList: widget.imageList,
                name: widget.name,
                description: widget.description,
                price: widget.price,
                manufacturing: widget.manufacturing,
                size: widget.size,
                discount: widget.discount,
                originalPrice: widget.originalPrice,
              ),
            ),
          );
        });

        return AlertDialog(
          backgroundColor: Colors.white,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(12.0),
          ),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Image.asset('assets/images/successfully.jpg', height: 120),
              const SizedBox(height: 16),
              const Text(
                'Payment done successfully.',
                style: TextStyle(
                  fontWeight: FontWeight.w500,
                  fontSize: 16,
                  color: Colors.black,
                ),
              ),
            ],
          ),
        );
      },
    );
  }

  int selectedIndex = 0;

  final List<Map<String, dynamic>> paymentMethods = [
    {'icon': Icons.account_balance_wallet_outlined, 'last4': '2109'},
    {'icon': Icons.apple, 'last4': '2109'},
  ];

  void _onBottomNavTap(int index) {
    setState(() => selectedIndex = index);
  }

  @override
  Widget build(BuildContext context) {
    double productPrice =
        double.tryParse(widget.price.replaceAll(RegExp(r'[^0-9.]'), '')) ?? 0.0;

    double platformFee = productPrice * 0.03;
    double tax = platformFee * 0.02;
    double total = platformFee + tax;

    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        leading: const BackButton(color: Colors.black),
        title: const Text(
          'Checkout',
          style: TextStyle(color: Colors.black, fontWeight: FontWeight.w600, fontSize: 20),
        ),
        centerTitle: true,
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 8),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const SizedBox(height: 12),
            _buildSummaryRow('Platform Fee', '₹ ${platformFee.toStringAsFixed(2)}'),
            const SizedBox(height: 8),
            _buildSummaryRow('Tax', '₹ ${tax.toStringAsFixed(2)}'),
            const Divider(thickness: 1),
            _buildSummaryRow('Total', '₹ ${total.toStringAsFixed(2)}', isBold: true),
            const SizedBox(height: 30),
            for (var method in paymentMethods) _buildPaymentCard(method['icon'], method['last4']),
            const Spacer(),
            SizedBox(
              width: double.infinity,
              height: 50,
              child: ElevatedButton(
                onPressed: _showSuccessDialog,
                style: ElevatedButton.styleFrom(
                  backgroundColor: const Color(0xFFE9445B),
                  shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
                ),
                child: const Text(
                  'Continue',
                  style: TextStyle(fontSize: 16, fontWeight: FontWeight.w600, color: Colors.white),
                ),
              ),
            ),
            const SizedBox(height: 20),
          ],
        ),
      ),
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: selectedIndex,
        selectedItemColor: const Color(0xFFE9445B),
        unselectedItemColor: Colors.grey,
        onTap: _onBottomNavTap,
        items: const [
          BottomNavigationBarItem(icon: Icon(Icons.home_outlined), label: 'Home'),
          BottomNavigationBarItem(icon: Icon(Icons.favorite_border), label: 'Wishlist'),
          BottomNavigationBarItem(icon: Icon(Icons.shopping_cart_outlined), label: ''),
          BottomNavigationBarItem(icon: Icon(Icons.search), label: 'Search'),
          BottomNavigationBarItem(icon: Icon(Icons.settings), label: 'Setting'),
        ],
      ),
    );
  }

  Widget _buildSummaryRow(String label, String amount, {bool isBold = false}) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(label, style: TextStyle(fontSize: 16, fontWeight: isBold ? FontWeight.w600 : FontWeight.w400)),
        Text(amount, style: TextStyle(fontSize: 16, fontWeight: isBold ? FontWeight.w600 : FontWeight.w400)),
      ],
    );
  }

  Widget _buildPaymentCard(IconData icon, String last4) {
    return Container(
      margin: const EdgeInsets.only(bottom: 16),
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
      decoration: BoxDecoration(
        color: const Color(0xFFF6F6F6),
        borderRadius: BorderRadius.circular(12),
      ),
      child: Row(
        children: [
          Icon(icon, size: 28),
          const SizedBox(width: 16),
          Text("********$last4", style: const TextStyle(fontSize: 16, fontWeight: FontWeight.w500)),
        ],
      ),
    );
  }
}
