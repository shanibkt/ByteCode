import 'package:flutter/material.dart';

class SafeDriveScreen extends StatefulWidget {
  @override
  _SafeDriveScreenState createState() => _SafeDriveScreenState();
}

class _SafeDriveScreenState extends State<SafeDriveScreen> {
  DateTime? selectedDate;

  Future<void> _selectDate(BuildContext context) async {
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime(2020),
      lastDate: DateTime(2030),
    );
    if (picked != null && picked != selectedDate) {
      setState(() {
        selectedDate = picked;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.green[600], // Background color
      appBar: AppBar(
        backgroundColor: Colors.green[600],
        elevation: 0,
        title: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Image.asset('assets/images/Logo.png', height: 100), // Logo
            Icon(Icons.menu, color: Colors.white), // Menu Icon
          ],
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            TextField(
              decoration: InputDecoration(
                prefixIcon: Icon(Icons.circle, color: Colors.white),
                labelText: 'Starting Place',
                labelStyle: TextStyle(color: Colors.white),
                enabledBorder: OutlineInputBorder(
                  borderSide: BorderSide(color: Colors.white),
                  borderRadius: BorderRadius.circular(10),
                ),
              ),
              style: TextStyle(color: Colors.white),
            ),
            SizedBox(height: 15),
            TextField(
              decoration: InputDecoration(
                prefixIcon: Icon(Icons.location_pin, color: Colors.white),
                labelText: 'Ending Place',
                labelStyle: TextStyle(color: Colors.white),
                enabledBorder: OutlineInputBorder(
                  borderSide: BorderSide(color: Colors.white),
                  borderRadius: BorderRadius.circular(10),
                ),
              ),
              style: TextStyle(color: Colors.white),
            ),
            SizedBox(height: 15),
            Row(
              children: [
                ElevatedButton.icon(
                  onPressed: () => _selectDate(context),
                  icon: Icon(Icons.calendar_today),
                  label: Text(selectedDate == null
                      ? "Reporting time"
                      : "${selectedDate!.day}/${selectedDate!.month}/${selectedDate!.year}"),
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.white,
                    foregroundColor: Colors.black,
                  ),
                ),
                SizedBox(width: 10),
                ElevatedButton(
                  onPressed: () {},
                  child: Text("Submit"),
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.white,
                    foregroundColor: Colors.black,
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
      bottomNavigationBar: BottomNavigationBar(
        backgroundColor: Colors.green[800],
        selectedItemColor: Colors.white,
        unselectedItemColor: Colors.white70,
        items: [
          BottomNavigationBarItem(icon: Icon(Icons.home), label: ''),
          BottomNavigationBarItem(icon: Icon(Icons.alt_route), label: ''),
          BottomNavigationBarItem(icon: Icon(Icons.car_rental), label: ''),
        ],
      ),
    );
  }
}
