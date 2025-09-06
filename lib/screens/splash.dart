import 'package:flutter/material.dart';
import 'dart:async';
import '../screens/homepage.dart';

void main() {
  runApp(const MyApp());
}

// Root widget
class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Handmade App',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primarySwatch: Colors.deepOrange,
      ),
      home: const SplashScreen(),
    );
  }
}

// Splash Screen Widget with 3 image sequence
class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  int _currentImageIndex = 0;
  late Timer _timer;

  final List<String> _images = [
    'assets/images/logo.png',
    'assets/images/Splash screen-1.jpg',
    'assets/images/Splash screen-2.jpg',
  ];

  @override
  void initState() {
    super.initState();

    // Change image every second
    _timer = Timer.periodic(const Duration(seconds: 3), (timer) {
      if (_currentImageIndex < _images.length - 1) {
        setState(() {
          _currentImageIndex++;
        });
      } else {
        // Stop timer and navigate to home
        _timer.cancel();
        Navigator.of(context).pushReplacement(
          MaterialPageRoute(builder: (_) => const HomePage()),
        );
      }
    });
  }

  @override
  void dispose() {
    _timer.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Center(
        child: Image.asset(
          _images[_currentImageIndex],
          width: MediaQuery.of(context).size.width * 0.8,
          fit: BoxFit.contain,
        ),
      ),
    );
  }
}