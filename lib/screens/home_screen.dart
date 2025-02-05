import 'package:bytecode/screens/drawer.dart';
import 'package:flutter/material.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color.fromARGB(255, 84, 150, 81),
      drawer: const DrawerScreen(), // Attach the drawer to the Scaffold
      body: SafeArea(
        child: Column(
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Image.asset(
                  "assets/images/Logo.png",
                  width: 150,
                  height: 150,
                ),
                Builder(
                  // Using Builder to get correct Scaffold context
                  builder: (context) => IconButton(
                    onPressed: () {
                      Scaffold.of(context).openDrawer(); // Open the drawer
                    },
                    icon: const Icon(
                      Icons.menu,
                      size: 50,
                      color: Colors.white,
                    ),
                  ),
                ),
              ],
            ),
            Center(
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Image.asset(
                    "assets/images/Logo.png",
                    width: 300,
                    height: 300,
                  ),
                  const Text(
                    "Drive Smart, Stay Safe",
                    style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                        color: Colors.white),
                  ),
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}
