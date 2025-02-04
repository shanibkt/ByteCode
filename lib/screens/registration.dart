import 'dart:convert';
import 'dart:developer';
import 'package:bytecode/screens/login_screen.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class RegistrationScreen extends StatefulWidget {
  const RegistrationScreen({super.key});

  @override
  State<RegistrationScreen> createState() => _RegistrationScreenState();
}

class _RegistrationScreenState extends State<RegistrationScreen> {
  String? name, phone, address, username, password;
  final GlobalKey<FormState> _formkey = GlobalKey<FormState>();

  Future<void> registration(BuildContext context) async {
    log('Starting registration...');
    try {
      // Make POST request
      final response = await http.post(
        Uri.parse("http://192.168.13.97/bytcode/signup.php"),
        headers: {'Content-Type': 'application/x-www-form-urlencoded'},
        body: {
          'name': name,
          'phone': phone,
          'address': address,
          'username': username,
          'password': password,
        },
      );

      print('Response status: ${response.statusCode}');
      print('Response body: ${response.body}');

      if (response.statusCode == 200) {
        final Map<String, dynamic> responseData = jsonDecode(response.body);
        if (responseData['status'] == 'success') {
          log("Registration successfully completed");
          Navigator.pushReplacement(
            context,
            MaterialPageRoute(builder: (context) => const LoginScreen()),
          );
        } else {
          log("Registration failed: ${responseData['message']}");
        }
      } else {
        log("Server error: ${response.statusCode}");
      }
    } catch (e) {
      log("Error: $e");
      print("Error: $e");
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color.fromARGB(255, 84, 150, 81),
      body: SafeArea(
        child: SingleChildScrollView(
          child: Form(
            key: _formkey,
            child: Center(
              child: Column(
                children: [
                  const SizedBox(
                    height: 10,
                  ),
                  const Text(
                    'Register Account',
                    style: TextStyle(
                      fontSize: 28,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const Text('Complete your details'),
                  const SizedBox(
                    height: 59,
                  ),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Container(
                      height: 60,
                      width: MediaQuery.of(context).size.width,
                      decoration: const BoxDecoration(
                        color: Color(0xffE8E8E8),
                        borderRadius: BorderRadius.all(Radius.circular(10)),
                      ),
                      child: Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 15),
                        child: Center(
                          child: TextFormField(
                            style: const TextStyle(
                              fontSize: 15,
                            ),
                            decoration: const InputDecoration.collapsed(
                              hintText: 'Name',
                            ),
                            onChanged: (text) {
                              setState(() {
                                name = text;
                              });
                            },
                            validator: (value) {
                              if (value!.isEmpty) {
                                return 'Enter your name text';
                              }
                              return null;
                            },
                          ),
                        ),
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Container(
                      height: 60,
                      width: MediaQuery.of(context).size.width,
                      decoration: const BoxDecoration(
                        color: Color(0xffE8E8E8),
                        borderRadius: BorderRadius.all(Radius.circular(10)),
                      ),
                      child: Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 15),
                        child: Center(
                          child: TextFormField(
                            style: const TextStyle(
                              fontSize: 15,
                            ),
                            decoration: const InputDecoration.collapsed(
                              hintText: 'Phone',
                            ),
                            onChanged: (text) {
                              setState(() {
                                phone = text;
                              });
                            },
                            validator: (value) {
                              if (value!.isEmpty) {
                                return 'Enter your phone text';
                              } else if (value.length > 10 ||
                                  value.length < 10) {
                                return 'Enter valid phone number';
                              }
                              return null;
                            },
                          ),
                        ),
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Container(
                      height: 130,
                      width: MediaQuery.of(context).size.width,
                      decoration: const BoxDecoration(
                        color: Color(0xffE8E8E8),
                        borderRadius: BorderRadius.all(Radius.circular(10)),
                      ),
                      child: Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 15),
                        child: Center(
                          child: TextFormField(
                            maxLines: 4,
                            style: const TextStyle(
                              fontSize: 15,
                            ),
                            decoration: const InputDecoration.collapsed(
                              hintText: 'Address',
                            ),
                            onChanged: (text) {
                              setState(() {
                                address = text;
                              });
                            },
                            validator: (value) {
                              if (value!.isEmpty) {
                                return 'Enter your Address text';
                              }
                              return null;
                            },
                          ),
                        ),
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Container(
                      height: 60,
                      width: MediaQuery.of(context).size.width,
                      decoration: const BoxDecoration(
                        color: Color(0xffE8E8E8),
                        borderRadius: BorderRadius.all(Radius.circular(10)),
                      ),
                      child: Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 15),
                        child: Center(
                          child: TextFormField(
                            style: const TextStyle(
                              fontSize: 15,
                            ),
                            decoration: const InputDecoration.collapsed(
                              hintText: 'Username',
                            ),
                            onChanged: (text) {
                              setState(() {
                                username = text;
                              });
                            },
                            validator: (value) {
                              if (value!.isEmpty) {
                                return 'Enter your username text';
                              }
                              return null;
                            },
                          ),
                        ),
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Container(
                      height: 60,
                      width: MediaQuery.of(context).size.width,
                      decoration: const BoxDecoration(
                        color: Color(0xffE8E8E8),
                        borderRadius: BorderRadius.all(Radius.circular(10)),
                      ),
                      child: Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 15),
                        child: Center(
                          child: TextFormField(
                            style: const TextStyle(
                              fontSize: 15,
                            ),
                            decoration: const InputDecoration.collapsed(
                              hintText: 'Password',
                            ),
                            onChanged: (text) {
                              setState(() {
                                password = text;
                              });
                            },
                            validator: (value) {
                              if (value!.isEmpty) {
                                return 'Enter your password text';
                              }
                              return null;
                            },
                          ),
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(
                    height: 15,
                  ),
                  ElevatedButton(
                    onPressed: () {
                      if (_formkey.currentState!.validate()) {
                        log("name = $name");
                        log("phone = $phone");
                        log("address = $address");
                        log("username = $username");
                        log("password = $password");

                        registration(context);
                      }
                    },
                    style: ElevatedButton.styleFrom(
                      minimumSize: Size(
                        MediaQuery.of(context).size.width / 2,
                        50,
                      ), // Width and height
                      backgroundColor: Colors.blue[300], // Background color
                      foregroundColor: Colors.white, // Text (foreground) color
                      shadowColor: Colors.grey, // Shadow color
                    ),
                    child: const Text('Register'),
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      const Text(
                        "Do you have an account?",
                        style: TextStyle(fontWeight: FontWeight.bold),
                      ),
                      TextButton(
                        child: const Text(
                          'Login',
                          style: TextStyle(fontWeight: FontWeight.bold),
                        ),
                        onPressed: () {
                          Navigator.push(context, MaterialPageRoute(
                            builder: (context) {
                              return const LoginScreen();
                            },
                          ));
                        },
                      )
                    ],
                  )
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
