import 'dart:typed_data'; // Required for Uint8List
import 'package:flutter/material.dart';
import 'payment.dart'; // Ensure this path is correct

class PlaceOrder extends StatelessWidget {
  final List<Uint8List> imageList;
  final String name;
  final String description;
  final String price;
  final String manufacturing; // Consistent spelling

  const PlaceOrder({
    super.key,
    required this.imageList,
    required this.name,
    required this.description,
    required this.price,
    required this.manufacturing,
  });

  void _navigateToPayment(BuildContext context) {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => PaymentScreen( // Changed _ to context for better practice
          imageList: imageList,
          name: name,
          description: description,
          price: price,
          manufacturing: manufacturing,
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Place Order'),
        backgroundColor: Colors.white,
        foregroundColor: Colors.black,
        elevation: 0,
      ),
      backgroundColor: Colors.white,
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              "Confirm Product Details",
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 16),

            // Product Image
            ClipRRect(
              borderRadius: BorderRadius.circular(10),
              child: Image.memory(
                imageList[0],
                height: 200,
                width: double.infinity,
                fit: BoxFit.cover,
              ),
            ),

            const SizedBox(height: 16),
            // Product Details
            Text("Name: $name", style: const TextStyle(fontSize: 16)),
            Text("Price: ₹$price", style: const TextStyle(fontSize: 16)),
            Text("Manufacturing: $manufacturing", style: const TextStyle(fontSize: 16)),
            const SizedBox(height: 10),
            const Text(
              "Description:",
              style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
            ),
            Text(
              description,
              style: const TextStyle(fontSize: 16),
            ),

            const Spacer(),

            // Proceed to Payment Button
            ElevatedButton(
              onPressed: () => _navigateToPayment(context),
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.black,
                minimumSize: const Size(double.infinity, 50),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(8),
                ),
              ),
              child: const Text(
                "Proceed to Payment",
                style: TextStyle(color: Colors.white, fontSize: 16),
              ),
            ),
          ],
        ),
      ),
    );
  }
}