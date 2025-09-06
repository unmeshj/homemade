import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Login UI',
      debugShowCheckedModeBanner: false,
      home: const LoginScreen(),
    );
  }
}

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  bool _obscureText = true;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 25.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const SizedBox(height: 40),
              const Text(
                "Welcome\nBack!",
                style: TextStyle(
                  fontSize: 32,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(height: 50),

              // Username or Email
              TextField(
                decoration: InputDecoration(
                  prefixIcon: const Icon(Icons.person),
                  suffix: Container(
                    padding: const EdgeInsets.symmetric(horizontal: 8),
                    child: const Text("select", style: TextStyle(color: Colors.grey)),
                  ),
                  hintText: 'Username or Email',
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10),
                  ),
                  filled: true,
                  fillColor: Colors.grey.shade100,
                ),
              ),
              const SizedBox(height: 20),

              // Password
              TextField(
                obscureText: _obscureText,
                decoration: InputDecoration(
                  prefixIcon: const Icon(Icons.lock),
                  suffixIcon: IconButton(
                    icon: Icon(_obscureText ? Icons.visibility : Icons.visibility_off),
                    onPressed: () {
                      setState(() {
                        _obscureText = !_obscureText;
                      });
                    },
                  ),
                  hintText: 'Password',
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10),
                  ),
                  filled: true,
                  fillColor: Colors.grey.shade100,
                ),
              ),
              const SizedBox(height: 10),

              // Forgot password
              Align(
                alignment: Alignment.centerRight,
                child: TextButton(
                  onPressed: () {},
                  child: const Text(
                    "Forgot Password?",
                    style: TextStyle(color: Colors.pinkAccent),
                  ),
                ),
              ),
              const SizedBox(height: 20),

              // Social Buttons
              const Center(child: Text("- OR Continue with -")),
              const SizedBox(height: 20),

              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: const [
                  SocialButton(icon: Icons.g_mobiledata, label: "Google"),
                  SocialButton(icon: Icons.apple, label: "Apple"),
                  SocialButton(icon: Icons.facebook, label: "Facebook"),
                ],
              ),
              const SizedBox(height: 30),

              // Sign up
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Text("Create An Account "),
                  GestureDetector(
                    onTap: () {},
                    child: const Text(
                      "Sign Up",
                      style: TextStyle(color: Colors.red),
                    ),
                  ),
                ],
              )
            ],
          ),
        ),
      ),
    );
  }
}

class SocialButton extends StatelessWidget {
  final IconData icon;
  final String label;

  const SocialButton({super.key, required this.icon, required this.label});

  @override
  Widget build(BuildContext context) {
    return CircleAvatar(
      radius: 25,
      backgroundColor: Colors.transparent,
      child: Icon(icon, color: Colors.black),
      foregroundColor: Colors.redAccent,
    );
  }
}
