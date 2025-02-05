import 'package:bytecode/screens/lane_recommendation_screen.dart';
import 'package:flutter/material.dart';
import 'dart:async';

class ChatbotScreen extends StatefulWidget {
  final String startLocation;
  final String endLocation;
  final DateTime dateTime;

  const ChatbotScreen({
    super.key,
    required this.startLocation,
    required this.endLocation,
    required this.dateTime,
  });

  @override
  _ChatbotScreenState createState() => _ChatbotScreenState();
}

class _ChatbotScreenState extends State<ChatbotScreen> {
  List<String> messages = [];

  Future<void> sendScheduleMessage() async {
    await Future.delayed(const Duration(seconds: 2));

    List<String> schedule = [
      "Trip from ${widget.startLocation} to ${widget.endLocation} scheduled on ${widget.dateTime.toLocal()}",
      "Here's your travel plan:",
      "Breakfast at ${widget.startLocation} - 8:00 AM",
      "Lunch near ${widget.endLocation} - 12:30 PM",
      "Dinner at ${widget.endLocation} - 7:00 PM",
      "Total Distance: 350 km",
      "Estimated Travel Time: 5 hours (excluding breaks)",
    ];

    setState(() {
      messages.addAll(schedule);
    });
  }

  @override
  void initState() {
    super.initState();
    sendScheduleMessage();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color.fromARGB(
          255, 84, 150, 81), // 🔹 FULL PAGE BACKGROUND COLOR
      appBar: AppBar(
        backgroundColor:
            const Color.fromARGB(255, 84, 150, 81), // 🔹 APPBAR COLOR
        foregroundColor: Colors.white, // 🔹 TEXT/ICONS COLOR
        title: const Text(
          'Travel Scheduler Bot',
          style: TextStyle(color: Colors.white),
        ),
      ),
      body: Column(
        children: [
          Expanded(
            child: ListView.builder(
              itemCount: messages.length,
              itemBuilder: (context, index) {
                return ListTile(
                  title: Text(
                    messages[index],
                    style:
                        const TextStyle(color: Colors.white), // 🔹 WHITE TEXT
                  ),
                );
              },
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: ElevatedButton(
              onPressed: () {
                Navigator.push(context, MaterialPageRoute(
                  builder: (context) {
                    return LaneRecommendationScreen();
                  },
                ));
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.blue, // 🔹 BUTTON COLOR
                minimumSize: Size(
                  MediaQuery.of(context).size.width / 2,
                  50,
                ),
              ),
              child: const Text(
                'Submit',
                style: TextStyle(color: Colors.white), // 🔹 WHITE BUTTON TEXT
              ),
            ),
          ),
        ],
      ),
    );
  }
}
