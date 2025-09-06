import 'dart:async';
import 'dart:typed_data';
import 'package:flutter/material.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';

class ProductPage extends StatefulWidget {
  final List<Uint8List> imageList;
  final String name;
  final String description;
  final String price;
  final String manufacturing;
  final String size;
  final String discount;
  final String originalPrice;
  final String ratingCount;

  const ProductPage({
    super.key,
    required this.imageList,
    required this.name,
    required this.description,
    required this.price,
    required this.manufacturing,
    required this.size,
    required this.discount,
    required this.originalPrice,
    this.ratingCount = '56,890',
  });

  @override
  State<ProductPage> createState() => _ProductPageState();
}

class _ProductPageState extends State<ProductPage> {
  final PageController _pageController = PageController();
  Timer? _timer;
  int _currentIndex = 0;

  @override
  void initState() {
    super.initState();
    if (widget.imageList.length > 1) {
      _startAutoSlide();
    }
  }

  void _startAutoSlide() {
    _timer = Timer.periodic(const Duration(seconds: 3), (Timer timer) {
      if (_pageController.hasClients) {
        int nextPage = (_currentIndex + 1) % widget.imageList.length;
        _pageController.animateToPage(
          nextPage,
          duration: const Duration(milliseconds: 500),
          curve: Curves.easeInOut,
        );
        setState(() => _currentIndex = nextPage);
      }
    });
  }

  @override
  void dispose() {
    _pageController.dispose();
    _timer?.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.name, overflow: TextOverflow.ellipsis),
        centerTitle: true,
        backgroundColor: Colors.white,
        foregroundColor: Colors.black,
        elevation: 0,
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            SizedBox(
              height: 280,
              child: Stack(
                children: [
                  PageView.builder(
                    controller: _pageController,
                    itemCount: widget.imageList.length,
                    onPageChanged: (index) => setState(() => _currentIndex = index),
                    itemBuilder: (context, index) {
                      return Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 16),
                        child: ClipRRect(
                          borderRadius: BorderRadius.circular(12),
                          child: Image.memory(
                            widget.imageList[index],
                            fit: BoxFit.cover,
                            width: double.infinity,
                          ),
                        ),
                      );
                    },
                  ),
                  if (widget.imageList.length > 1)
                    Positioned(
                      bottom: 10,
                      left: 0,
                      right: 0,
                      child: Center(
                        child: SmoothPageIndicator(
                          controller: _pageController,
                          count: widget.imageList.length,
                          effect: const WormEffect(
                            activeDotColor: Colors.red,
                            dotHeight: 8,
                            dotWidth: 8,
                          ),
                        ),
                      ),
                    ),
                ],
              ),
            ),
            const SizedBox(height: 20),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text("Size: ${widget.size}", style: const TextStyle(fontWeight: FontWeight.bold)),
                  const SizedBox(height: 10),
                  Wrap(
                    spacing: 8,
                    children: [ " "].map((size) {
                      return Chip(
                        label: Text(size),
                        backgroundColor: size == widget.size ? Colors.pink : Colors.grey[200],
                        labelStyle: TextStyle(
                          color: size == widget.size ? Colors.white : Colors.black,
                        ),
                      );
                    }).toList(),
                  ),
                  const SizedBox(height: 16),
                  Text(widget.name, style: const TextStyle(fontSize: 22, fontWeight: FontWeight.bold)),
                  const SizedBox(height: 4),
                  Text(widget.manufacturing, style: const TextStyle(fontSize: 16, color: Colors.grey)),
                  const SizedBox(height: 8),
                  Row(
                    children: [
                      const Icon(Icons.star, size: 18, color: Colors.amber),
                      const Icon(Icons.star, size: 18, color: Colors.amber),
                      const Icon(Icons.star, size: 18, color: Colors.amber),
                      const Icon(Icons.star, size: 18, color: Colors.amber),
                      const Icon(Icons.star, size: 18, color: Colors.amber),
                      const SizedBox(width: 8),
                      Text(widget.ratingCount, style: const TextStyle(fontSize: 14)),
                    ],
                  ),
                  const SizedBox(height: 8),
                  Row(
                    children: [
                      Text("₹${widget.originalPrice}",
                          style: const TextStyle(decoration: TextDecoration.lineThrough)),
                      const SizedBox(width: 10),
                      Text("₹${widget.price}",
                          style: const TextStyle(
                            fontSize: 20,
                            fontWeight: FontWeight.bold,
                            color: Colors.black,
                          )),
                      const SizedBox(width: 8),
                      Container(
                        padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                        decoration: BoxDecoration(
                          color: Colors.red[50],
                          borderRadius: BorderRadius.circular(4),
                        ),
                        child: Text(widget.discount, style: const TextStyle(color: Colors.red)),
                      ),
                    ],
                  ),
                  const SizedBox(height: 16),
                  const Text("Product Details", style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
                  const SizedBox(height: 8),
                  Text(widget.description, style: const TextStyle(fontSize: 16)),
                  const SizedBox(height: 8),
                  Wrap(
                    spacing: 8,
                    children: [
                      _buildChip("Nearest Store"),
                      _buildChip("VIP"),
                      _buildChip("Return policy"),
                    ],
                  ),
                  const SizedBox(height: 16),
                  Container(
                    width: double.infinity,
                    padding: const EdgeInsets.all(12),
                    color: Colors.pink[100],
                    child: const Text("Launch\n1 within Hour", style: TextStyle(fontWeight: FontWeight.bold)),
                  ),
                  const SizedBox(height: 16),
                  Row(
                    children: [
                      Expanded(
                        child: OutlinedButton(
                          onPressed: () {},
                          child: const Text("View Similar"),
                        ),
                      ),
                      const SizedBox(width: 8),
                      Expanded(
                        child: OutlinedButton(
                          onPressed: () {},
                          child: const Text("Add to Compare"),
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 80),
                ],
              ),
            ),
          ],
        ),
      ),
      persistentFooterButtons: [
        Row(
          children: [
            Expanded(
              child: ElevatedButton(
                onPressed: () {},
                style: ElevatedButton.styleFrom(backgroundColor: Colors.grey[200]),
                child: const Text("Go to cart", style: TextStyle(color: Colors.black)),
              ),
            ),
            Expanded(
              child: ElevatedButton(
                onPressed: () {},
                child: const Text("Buy Now"),
              ),
            ),
          ],
        )
      ],
      bottomNavigationBar: BottomNavigationBar(
        type: BottomNavigationBarType.fixed,
        currentIndex: 2,
        selectedItemColor: Colors.red,
        unselectedItemColor: Colors.grey,
        items: const [
          BottomNavigationBarItem(icon: Icon(Icons.home), label: "Home"),
          BottomNavigationBarItem(icon: Icon(Icons.favorite_border), label: "Wishlist"),
          BottomNavigationBarItem(icon: Icon(Icons.shopping_cart), label: ""),
          BottomNavigationBarItem(icon: Icon(Icons.search), label: "Search"),
          BottomNavigationBarItem(icon: Icon(Icons.settings), label: "Setting"),
        ],
      ),
    );
  }

  Widget _buildChip(String label) {
    return ActionChip(
      label: Text(label),
      onPressed: () {},
      backgroundColor: Colors.grey[200],
    );
  }
}