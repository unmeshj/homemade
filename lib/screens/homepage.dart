import 'package:flutter/material.dart';
import '../screens/Addproduct.dart';
import '../screens/setting.dart'; // Make sure you have this file created

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  int _currentIndex = 0;

  // List of screens for bottom navigation
  final List<Widget> _pages = [
    const HomeContent(), // Home screen content
    const AddProduct(), // Products screen
    const Placeholder(), // Cart screen (replace with your actual cart screen)
    const Placeholder(), // Search screen (replace with your actual search screen)
    const HomeScreen(), // Settings screen
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        leading: const Icon(Icons.menu, color: Colors.black),
        title: Image.asset(
          'assets/images/logo.png',
          height: 40,
        ),
        actions: const [
          Padding(
            padding: EdgeInsets.all(8.0),
            child: CircleAvatar(
              backgroundImage: AssetImage('assets/images/user.png'),
            ),
          )
        ],
      ),
      backgroundColor: Colors.white,
      body: _pages[_currentIndex],
      bottomNavigationBar: BottomNavigationBar(
        selectedItemColor: Colors.red,
        unselectedItemColor: Colors.grey,
        currentIndex: _currentIndex,
        onTap: (index) {
          setState(() {
            _currentIndex = index;
          });
        },
        items: const [
          BottomNavigationBarItem(icon: Icon(Icons.home), label: "Home"),
          BottomNavigationBarItem(icon: Icon(Icons.dashboard), label: "Products"),
          BottomNavigationBarItem(icon: Icon(Icons.shopping_cart), label: "Cart"),
          BottomNavigationBarItem(icon: Icon(Icons.search), label: "Search"),
          BottomNavigationBarItem(icon: Icon(Icons.settings), label: "Setting"),
        ],
      ),
    );
  }
}

// Extracted home content widget
class HomeContent extends StatelessWidget {
  const HomeContent({super.key});

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 15),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 10),
              decoration: BoxDecoration(
                color: Colors.grey.shade100,
                borderRadius: BorderRadius.circular(10),
              ),
              child: const TextField(
                decoration: InputDecoration(
                  hintText: "Search any Product...",
                  border: InputBorder.none,
                  icon: Icon(Icons.search),
                ),
              ),
            ),
            const SizedBox(height: 20),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: const [
                Text("All Categories", style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
                Row(
                  children: [
                    Icon(Icons.sort),
                    SizedBox(width: 10),
                    Icon(Icons.filter_alt_outlined),
                  ],
                )
              ],
            ),
            const SizedBox(height: 20),
            SizedBox(
              height: 100,
              width: 450,
              child: ListView(
                scrollDirection: Axis.horizontal,
                children: [
                  _categoryItem("assets/images/women.png", "Women", context),
                  _categoryItem("assets/images/pots.jpg", "Pots", context),
                  _categoryItem("assets/images/crafts.jpg", "Crafts", context),
                  _categoryItem("assets/images/decor.jpg", "Decoration", context),
                  _categoryItem("assets/images/men.png", "Mens", context),
                  _categoryItem("assets/images/beauty.png", "Beauty", context),
                ],
              ),
            ),
            const SizedBox(height: 20),
            Image.asset("assets/images/Home page.jpg", height: 200),
            const SizedBox(height: 20),
            Container(
              width: double.infinity,
              padding: const EdgeInsets.symmetric(vertical: 20, horizontal: 15),
              decoration: BoxDecoration(
                color: Colors.blue.shade100,
                borderRadius: BorderRadius.circular(10),
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: const [
                  Text("Start Your Business", style: TextStyle(fontWeight: FontWeight.bold)),
                  Text("View all →", style: TextStyle(color: Colors.blue)),
                ],
              ),
            ),
            const SizedBox(height: 20),
            GridView.count(
              crossAxisCount: 2,
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              mainAxisSpacing: 10,
              crossAxisSpacing: 10,
              childAspectRatio: 0.75,
              children: [
                _productItem("assets/images/men.png", "Men", context),
                _productItem("assets/images/crafts.jpg", "Crafts", context),
                _productItem("assets/images/beauty.png", "Beauty", context),
                _productItem("assets/images/decor.jpg", "Decor", context),
              ],
            ),
            const SizedBox(height: 20),
          ],
        ),
      ),
    );
  }

  // Updated: Navigates to AddProduct page
  static Widget _categoryItem(String imagePath, String label, BuildContext context) {
    return GestureDetector(
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => const AddProduct()),
        );
      },
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 10),
        child: Column(
          children: [
            CircleAvatar(
              backgroundImage: AssetImage(imagePath),
              radius: 25,
            ),
            const SizedBox(height: 5),
            Text(label, style: const TextStyle(fontSize: 12)),
          ],
        ),
      ),
    );
  }

  // Updated: Navigates to AddProduct page
  static Widget _productItem(String imagePath, String label, BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(8),
      decoration: BoxDecoration(
        border: Border.all(color: Colors.grey.shade200),
        borderRadius: BorderRadius.circular(10),
      ),
      child: Column(
        children: [
          GestureDetector(
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => const AddProduct()),
              );
            },
            child: ClipRRect(
              borderRadius: BorderRadius.circular(50),
              child: Image.asset(
                imagePath,
                fit: BoxFit.cover,
                height: 100,
                width: 100,
              ),
            ),
          ),
          const SizedBox(height: 5),
          Text(label, style: const TextStyle(fontSize: 14)),
        ],
      ),
    );
  }
}
