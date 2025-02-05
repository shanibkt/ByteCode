import 'package:bytecode/chatbot__screen.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(SafeDriveApp());
}

class SafeDriveApp extends StatelessWidget {
  const SafeDriveApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: SafeDriveScreen(),
    );
  }
}

class SafeDriveScreen extends StatefulWidget {
  const SafeDriveScreen({super.key});

  @override
  _SafeDriveScreenState createState() => _SafeDriveScreenState();
}

class _SafeDriveScreenState extends State<SafeDriveScreen> {
  TextEditingController startController = TextEditingController();
  TextEditingController endController = TextEditingController();
  DateTime? selectedDate;
  TimeOfDay? selectedTime;
  bool showOptions = false;
  Map<String, bool> options = {
    'Breakfast': false,
    'Lunch': false,
    'Dinner': false,
    'Stay': false,
    'Oil': false,
  };

  Future<void> _pickDateTime(BuildContext context) async {
    DateTime? pickedDate = await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime(2000),
      lastDate: DateTime(2100),
    );

    if (pickedDate != null) {
      TimeOfDay? pickedTime = await showTimePicker(
        context: context,
        initialTime: TimeOfDay.now(),
      );

      if (pickedTime != null) {
        setState(() {
          selectedDate = pickedDate;
          selectedTime = pickedTime;
        });
      }
    }
  }

  void _submitDateTime() {
    if (selectedDate != null && selectedTime != null) {
      debugPrint('Start: ${startController.text}');
      debugPrint('End: ${endController.text}');
      debugPrint(
          'Reporting Date: ${selectedDate!.toLocal().toString().split(' ')[0]}');
      debugPrint('Reporting Time: ${selectedTime!.format(context)}');
      setState(() {
        showOptions = true;
      });
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Please select both date and time')),
      );
    }
  }

  void _submitOptions() {
    debugPrint('Selected options:');
    options.forEach((key, value) {
      if (value) {
        debugPrint('- $key');
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.green[700],
      appBar: AppBar(
        backgroundColor: Colors.green[700],
        title: const Row(
          children: [
            Icon(Icons.directions_car, color: Colors.white),
            SizedBox(width: 8),
            Text("SAFE DRIVE", style: TextStyle(color: Colors.white)),
          ],
        ),
        actions: [
          IconButton(
              icon: const Icon(Icons.menu, color: Colors.white),
              onPressed: () {}),
        ],
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              TextField(
                controller: startController,
                decoration: const InputDecoration(
                  hintText: "Starting Place",
                  filled: true,
                  fillColor: Colors.white,
                  border: OutlineInputBorder(),
                ),
              ),
              const SizedBox(height: 10),
              TextField(
                controller: endController,
                decoration: const InputDecoration(
                  hintText: "Ending Place",
                  filled: true,
                  fillColor: Colors.white,
                  border: OutlineInputBorder(),
                ),
              ),
              const SizedBox(height: 20),
              // Date and Time Section
              Container(
                padding: const EdgeInsets.all(10),
                decoration: BoxDecoration(
                  border: Border.all(color: Colors.white),
                  borderRadius: BorderRadius.circular(8),
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    ElevatedButton.icon(
                      onPressed: () => _pickDateTime(context),
                      icon: const Icon(Icons.calendar_today),
                      label: const Text("Select Date & Time"),
                    ),
                    const SizedBox(height: 10),
                    Text(
                      'Selected Date: ${selectedDate?.toLocal().toString().split(' ')[0] ?? "Not selected"}',
                      style: const TextStyle(color: Colors.white),
                    ),
                    Text(
                      'Selected Time: ${selectedTime?.format(context) ?? "Not selected"}',
                      style: const TextStyle(color: Colors.white),
                    ),
                    const SizedBox(height: 10),
                    Center(
                      child: ElevatedButton(
                        onPressed: _submitDateTime,
                        child: const Text("Submit Date & Time"),
                      ),
                    ),
                  ],
                ),
              ),
              // Options Section - Only shown after date/time submission
              if (showOptions) ...[
                const SizedBox(height: 20),
                Container(
                  padding: const EdgeInsets.all(10),
                  decoration: BoxDecoration(
                    border: Border.all(color: Colors.white),
                    borderRadius: BorderRadius.circular(8),
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Text(
                        "Select Options:",
                        style: TextStyle(
                            color: Colors.white,
                            fontSize: 16,
                            fontWeight: FontWeight.bold),
                      ),
                      const SizedBox(height: 10),
                      Wrap(
                        spacing: 10,
                        children: options.keys.map((key) {
                          return Row(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              Checkbox(
                                value: options[key],
                                onChanged: (bool? value) {
                                  setState(() {
                                    options[key] = value!;
                                  });
                                },
                              ),
                              Text(key,
                                  style: const TextStyle(color: Colors.white)),
                            ],
                          );
                        }).toList(),
                      ),
                      const SizedBox(height: 10),
                      Center(
                        child: ElevatedButton(
                          onPressed: () {
                            _submitOptions();

                            String startLocation = startController.text;
                            String endLocation = endController.text;

                            if (startLocation.isNotEmpty &&
                                endLocation.isNotEmpty &&
                                selectedDate != null &&
                                selectedTime != null) {
                              // Convert Date and Time into a DateTime object
                              DateTime dateTime = DateTime(
                                selectedDate!.year,
                                selectedDate!.month,
                                selectedDate!.day,
                                selectedTime!.hour,
                                selectedTime!.minute,
                              );

                              // Navigate to ChatbotScreen with valid parameters
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) {
                                    return ChatbotScreen(
                                      startLocation: startLocation,
                                      endLocation: endLocation,
                                      dateTime:
                                          dateTime, // Now passing a proper DateTime object
                                    );
                                  },
                                ),
                              );
                            } else {
                              ScaffoldMessenger.of(context).showSnackBar(
                                const SnackBar(
                                    content: Text(
                                        'Please enter all required details')),
                              );
                            }
                          },
                          child: const Text("Submit Options"),
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ],
          ),
        ),
      ),
    );
  }
}
