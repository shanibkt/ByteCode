import 'package:flutter/material.dart';

class LineKeepScren extends StatelessWidget {
  const LineKeepScren({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: const Color.fromARGB(255, 84, 150, 81),
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
                    icon: const Icon(
                      Icons.menu,
                      size: 50,
                    ))
              ],
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Center(
                  child: Image.asset(
                    "assets/images/road_30.png",
                    width: 300,
                    height: 300,
                  ),
                )
              ],
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Center(
                  child: Image.asset(
                    "assets/images/speed_0.png",
                    width: 300,
                    height: 300,
                  ),
                )
              ],
            ),
          ],
        )));
  }
}
