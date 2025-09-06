import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Trending Products',
      theme: ThemeData(
        primarySwatch: Colors.blue,
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      home: const HomeScreen(),
    );
  }
}

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final FocusNode _searchFocusNode = FocusNode();
  bool _isSearchFocused = false;

  @override
  void initState() {
    super.initState();
    _searchFocusNode.addListener(() {
      setState(() {
        _isSearchFocused = _searchFocusNode.hasFocus;
      });
    });
  }

  @override
  void dispose() {
    _searchFocusNode.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Settings'),
        centerTitle: true,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            SearchBox(
              focusNode: _searchFocusNode,
              isFocused: _isSearchFocused,
            ),
            const SizedBox(height: 20),
            Expanded(
              child: ListView(
                children: [
                  _buildSettingOption(Icons.shopping_cart, 'ORDERS'),
                  _buildSettingOption(Icons.payment, 'PAYMENTS'),
                  _buildSettingOption(Icons.local_shipping, 'LOGISTICS'),
                  _buildSettingOption(Icons.person, 'PROFILE'),
                  _buildSettingOption(Icons.account_balance, 'BANK DETAILS'),
                  _buildSettingOption(Icons.account_circle, 'ACCOUNT'),
                ],
              ),
            ),
          ],
        ),
      ),


    );
  }

  Widget _buildSettingOption(IconData icon, String title) {
    return Card(
      margin: const EdgeInsets.symmetric(vertical: 8.0),
      child: ListTile(
        leading: Icon(icon, size: 30, color: Colors.blue),
        title: Text(
          title,
          style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
        ),
        trailing: const Icon(Icons.arrow_forward_ios),
        onTap: () {
          // Add navigation logic here
        },
      ),
    );
  }
}

class SearchBox extends StatelessWidget {
  final FocusNode focusNode;
  final bool isFocused;

  const SearchBox({
    super.key,
    required this.focusNode,
    required this.isFocused,
  });

  @override
  Widget build(BuildContext context) {
    return TextField(
      focusNode: focusNode,
      decoration: InputDecoration(
        hintText: 'Search any Field..',
        prefixIcon: const Icon(Icons.search),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(8.0),
          borderSide: BorderSide(
            color: isFocused ? Colors.red : Colors.grey,
            width: 2.0,
          ),
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(8.0),
          borderSide: BorderSide(
            color: isFocused ? Colors.red : Colors.grey,
            width: 1.0,
          ),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(8.0),
          borderSide: const BorderSide(
            color: Colors.red,
            width: 2.0,
          ),
        ),
      ),
    );
  }
}