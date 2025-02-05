import 'package:bytecode/screens/lane_recommendation_screen.dart';
import 'package:flutter/material.dart';
import 'package:bytecode/screens/home_screen.dart';
import 'package:bytecode/screens/safe_drive_screen.dart';

class BottomScreen extends StatefulWidget {
  const BottomScreen({super.key});

  @override
  State<BottomScreen> createState() => _BottomScreenState();
}

class _BottomScreenState extends State<BottomScreen> {
  int _selectedIndex = 0;

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  final List<Widget> _pages = [
    const HomeScreen(),
    SafeDriveScreen(),
    const LaneRecommendationScreen(),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor:
          Colors.green[700], // Add background color to match the app theme
      bottomNavigationBar: Container(
        decoration: BoxDecoration(
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.2),
              blurRadius: 10,
              offset: const Offset(0, -5),
            ),
          ],
        ),
        child: ClipRRect(
          borderRadius: const BorderRadius.only(
            topLeft: Radius.circular(30),
            topRight: Radius.circular(30),
          ),
          child: BottomNavigationBar(
            currentIndex: _selectedIndex,
            onTap: _onItemTapped,
            items: const <BottomNavigationBarItem>[
              BottomNavigationBarItem(
                icon: Icon(Icons.home),
                label: 'Home',
              ),
              BottomNavigationBarItem(
                icon: Icon(Icons.navigation),
                label: 'Schedule',
              ),
              BottomNavigationBarItem(
                icon: Icon(Icons.car_repair),
                label: 'LineKeep',
              ),
            ],
            selectedItemColor: Colors.green[700],
            unselectedItemColor: Colors.grey,
            showUnselectedLabels: false,
            selectedFontSize: 18,
            unselectedFontSize: 16,
            backgroundColor: Colors.white,
            elevation: 0,
            type: BottomNavigationBarType.fixed,
          ),
        ),
      ),
      body: Center(
        child: _pages[_selectedIndex],
      ),
    );
  }
}
