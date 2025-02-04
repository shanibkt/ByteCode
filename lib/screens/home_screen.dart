import 'package:flutter/material.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color.fromARGB(255, 84, 150, 81),
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
                IconButton(
                    onPressed: () {},
                    icon: Icon(
                      Icons.menu,
                      size: 50,
                    ))
              ],
            ),
            Center(
              child: Column(
                mainAxisSize: MainAxisSize.min, // Keeps the column compact
                children: [
                  Image.asset(
                    "assets/images/Logo.png",
                    width: 300,
                    height: 300,
                  ),
                  Text(
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
