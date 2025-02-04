import 'package:bytecode/screens/home_screen.dart';
import 'package:bytecode/screens/login_screen.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    super.initState();
    _checkAuthenticationState(); // Check authentication state on initialization
  }

  // Method to check the user's authentication state
  Future<void> _checkAuthenticationState() async {
    await Future.delayed(
        const Duration(seconds: 2)); // Added delay to show splash screen
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    final bool isLoggedIn = prefs.getBool('isLoggedIn') ?? false;

    // Navigate based on the login state
    if (isLoggedIn) {
      Navigator.of(context).pushReplacement(
        MaterialPageRoute(
            builder: (ctx) =>
                const HomeScreen()), // Ensure HomePage is imported and defined
      );
    } else {
      Navigator.of(context).pushReplacement(
        MaterialPageRoute(builder: (ctx) => const LoginScreen()),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color.fromARGB(255, 84, 150, 81),
      body: Center(
        // Center widget to ensure proper alignment
        child: Image.asset(
          'assets/images/Logo.png',
          width: 200,
          height: 200,
        ),
      ),
    );
  }
}
