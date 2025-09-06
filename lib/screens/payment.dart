import 'dart:typed_data';
import 'package:flutter/material.dart';
import 'successful.dart';

class PaymentScreen extends StatefulWidget {
  final List<Uint8List> imageList;
  final String name;
  final String description;
  final String price;
  final String manufacturing;

  const PaymentScreen({
    super.key,
    required this.imageList,
    required this.name,
    required this.description,
    required this.price,
    required this.manufacturing,
  });

  @override
  State<PaymentScreen> createState() => _PaymentScreenState();
}

class _PaymentScreenState extends State<PaymentScreen> {
  int selectedIndex = 0;

  final List<Map<String, dynamic>> paymentMethods = [
    {'icon': Icons.credit_card, 'title': 'VISA', 'number': '********2109'},
    {'icon': Icons.payment, 'title': 'PayPal', 'number': '********2109'},
    {'icon': Icons.credit_score, 'title': 'Mastercard', 'number': '********2109'},
    {'icon': Icons.apple, 'title': 'Apple Pay', 'number': '********2109'},
  ];

  @override
  Widget build(BuildContext context) {
    double productPrice =
        double.tryParse(widget.price.replaceAll(RegExp(r'[^0-9.]'), '')) ?? 0.0;

    double platformFee = productPrice * 0.03;
    double tax = platformFee * 0.02;
    double total = platformFee + tax;

    return Scaffold(
      appBar: AppBar(
        title: const Text("Checkout"),
        centerTitle: true,
        backgroundColor: Colors.white,
        foregroundColor: Colors.black,
        elevation: 0.5,
      ),
      backgroundColor: Colors.white,
      body: Column(
        children: [
          // Product summary
          Padding(
            padding: const EdgeInsets.all(16),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(widget.name, style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 18)),
                const SizedBox(height: 8),
                Text("Price: ₹${widget.price}"),
                const SizedBox(height: 4),
                Text("Manufactured by: ${widget.manufacturing}"),
                const Divider(height: 24),
              ],
            ),
          ),

          Padding(
            padding: const EdgeInsets.all(16),
            child: Column(
              children: [
                _buildPriceRow("Platform Fee", "₹${platformFee.toStringAsFixed(2)}"),
                const SizedBox(height: 8),
                _buildPriceRow("Tax", "₹${tax.toStringAsFixed(2)}"),
                const Divider(height: 24),
                _buildPriceRow("Total", "₹${total.toStringAsFixed(2)}", bold: true),
              ],
            ),
          ),
          const Divider(height: 32),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16),
            child: const Align(
              alignment: Alignment.centerLeft,
              child: Text(
                "Payment",
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
              ),
            ),
          ),
          const SizedBox(height: 16),
          Expanded(
            child: ListView.builder(
              itemCount: paymentMethods.length,
              padding: const EdgeInsets.symmetric(horizontal: 16),
              itemBuilder: (context, index) {
                final method = paymentMethods[index];
                final isSelected = index == selectedIndex;
                return GestureDetector(
                  onTap: () => setState(() => selectedIndex = index),
                  child: Container(
                    margin: const EdgeInsets.only(bottom: 12),
                    padding: const EdgeInsets.all(16),
                    decoration: BoxDecoration(
                      color: isSelected ? Colors.red[50] : Colors.grey[100],
                      border: Border.all(
                        color: isSelected ? Colors.red : Colors.transparent,
                        width: 1.5,
                      ),
                      borderRadius: BorderRadius.circular(10),
                    ),
                    child: Row(
                      children: [
                        Icon(method['icon'], size: 30),
                        const SizedBox(width: 16),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              method['title'],
                              style: const TextStyle(
                                fontWeight: FontWeight.bold,
                                fontSize: 16,
                              ),
                            ),
                            const SizedBox(height: 4),
                            Text(
                              method['number'],
                              style: const TextStyle(fontSize: 14),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                );
              },
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(16),
            child: SizedBox(
              width: double.infinity,
              height: 50,
              child: ElevatedButton(
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => CheckoutPage(
                        imageList: widget.imageList,
                        name: widget.name,
                        description: widget.description,
                        price: widget.price,
                        manufacturing: widget.manufacturing,
                        size: '',
                        discount: '',
                        originalPrice: widget.price,
                      ),
                    ),
                  );
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.red,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(8),
                  ),
                ),
                child: const Text(
                  "Continue",
                  style: TextStyle(fontSize: 18, color: Colors.white),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildPriceRow(String title, String value, {bool bold = false}) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(title, style: TextStyle(fontSize: 16, fontWeight: bold ? FontWeight.bold : FontWeight.normal)),
        Text(value, style: TextStyle(fontSize: 16, fontWeight: bold ? FontWeight.bold : FontWeight.normal)),
      ],
    );
  }
}
