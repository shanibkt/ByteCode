import 'package:flutter/material.dart';

void main() {
  runApp(SafeDriveApp());
}

class SafeDriveApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: SafeDriveScreen(),
    );
  }
}

class SafeDriveScreen extends StatefulWidget {
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
        SnackBar(content: Text('Please select both date and time')),
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
        title: Row(
          children: [
            Icon(Icons.directions_car, color: Colors.white),
            SizedBox(width: 8),
            Text("SAFE DRIVE", style: TextStyle(color: Colors.white)),
          ],
        ),
        actions: [
          IconButton(
              icon: Icon(Icons.menu, color: Colors.white), onPressed: () {}),
        ],
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              TextField(
                controller: startController,
                decoration: InputDecoration(
                  hintText: "Starting Place",
                  filled: true,
                  fillColor: Colors.white,
                  border: OutlineInputBorder(),
                ),
              ),
              SizedBox(height: 10),
              TextField(
                controller: endController,
                decoration: InputDecoration(
                  hintText: "Ending Place",
                  filled: true,
                  fillColor: Colors.white,
                  border: OutlineInputBorder(),
                ),
              ),
              SizedBox(height: 20),
              // Date and Time Section
              Container(
                padding: EdgeInsets.all(10),
                decoration: BoxDecoration(
                  border: Border.all(color: Colors.white),
                  borderRadius: BorderRadius.circular(8),
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    ElevatedButton.icon(
                      onPressed: () => _pickDateTime(context),
                      icon: Icon(Icons.calendar_today),
                      label: Text("Select Date & Time"),
                    ),
                    SizedBox(height: 10),
                    Text(
                      'Selected Date: ${selectedDate?.toLocal().toString().split(' ')[0] ?? "Not selected"}',
                      style: TextStyle(color: Colors.white),
                    ),
                    Text(
                      'Selected Time: ${selectedTime?.format(context) ?? "Not selected"}',
                      style: TextStyle(color: Colors.white),
                    ),
                    SizedBox(height: 10),
                    Center(
                      child: ElevatedButton(
                        onPressed: _submitDateTime,
                        child: Text("Submit Date & Time"),
                      ),
                    ),
                  ],
                ),
              ),
              // Options Section - Only shown after date/time submission
              if (showOptions) ...[
                SizedBox(height: 20),
                Container(
                  padding: EdgeInsets.all(10),
                  decoration: BoxDecoration(
                    border: Border.all(color: Colors.white),
                    borderRadius: BorderRadius.circular(8),
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        "Select Options:",
                        style: TextStyle(
                            color: Colors.white,
                            fontSize: 16,
                            fontWeight: FontWeight.bold),
                      ),
                      SizedBox(height: 10),
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
                              Text(key, style: TextStyle(color: Colors.white)),
                            ],
                          );
                        }).toList(),
                      ),
                      SizedBox(height: 10),
                      Center(
                        child: ElevatedButton(
                          onPressed: _submitOptions,
                          child: Text("Submit Options"),
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
