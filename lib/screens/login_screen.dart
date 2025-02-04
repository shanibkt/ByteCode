import 'dart:developer';
import 'package:bytecode/screens/registration.dart';
import 'package:flutter/material.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  String? username, password;
  bool processing = false;

  final GlobalKey<FormState> _formkey = GlobalKey<FormState>();
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
                  Image.asset("assets/images/Logo.png"),
                  const SizedBox(height: 200),
                  const Text(
                    'Drive Smart, Stay Safe',
                    style: TextStyle(
                      color: Colors.black,
                      fontWeight: FontWeight.normal,
                    ),
                  ),
                  const SizedBox(height: 50),
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
                              hintText: 'enter mail or phone number',
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
                            obscureText: true,
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
                    height: 35,
                  ),
                  ElevatedButton(
                    onPressed: () {
                      if (_formkey.currentState!.validate()) {
                        log("username = $username");
                        log("password = $password");
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
                    child: const Text('Login'),
                  ),
                  const SizedBox(
                    height: 15,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      const Text(
                        "Dont't have anccout?",
                        style: TextStyle(fontWeight: FontWeight.bold),
                      ),
                      TextButton(
                        child: const Text(
                          'Go to Register',
                          style: TextStyle(fontWeight: FontWeight.bold),
                        ),
                        onPressed: () {
                          Navigator.push(context, MaterialPageRoute(
                            builder: (context) {
                              return const RegistrationScreen();
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
