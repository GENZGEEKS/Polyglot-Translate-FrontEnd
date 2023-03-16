// Dada KI Jay Ho

import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:flutter/material.dart';

class Output extends StatefulWidget {
  final String output;
  const Output({super.key, required this.output});

  @override
  State<Output> createState() => _OutputState();
}

class _OutputState extends State<Output> {
  TextEditingController textController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      body: SafeArea(
        child: Column(
          children: [
            Expanded(
              child: SingleChildScrollView(
                child: Column(
                  children: [
                    Container(
                      height: 36,
                    ),
                    const Text(
                      "Here's Your Translation!",
                      style: TextStyle(fontSize: 20),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(16.0),
                      child: Stack(
                        children: [
                          Container(
                            height: size.height * .6,
                            margin: const EdgeInsets.all(16),
                            padding: const EdgeInsets.all(24),
                            decoration: BoxDecoration(
                              color: const Color.fromARGB(255, 230, 230, 230),
                              borderRadius: BorderRadius.circular(16),
                              boxShadow: const [
                                BoxShadow(blurRadius: 10, spreadRadius: .1)
                              ],
                            ),
                            child: Text(widget.output),
                          ),
                          Align(
                            alignment: const Alignment(.65, -1.5),
                            child: CircleAvatar(
                              backgroundColor: Colors.green,
                              child: IconButton(
                                onPressed: () {},
                                icon: const Icon(
                                  Icons.music_note,
                                  color: Colors.white,
                                ),
                              ),
                            ),
                          ),
                          Align(
                            alignment: const Alignment(1, -1.5),
                            child: CircleAvatar(
                              backgroundColor: Colors.green,
                              child: IconButton(
                                onPressed: () {},
                                icon: const Icon(
                                  Icons.copy,
                                  color: Colors.white,
                                ),
                              ),
                            ),
                          )
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: Row(
                children: [
                  CircleAvatar(
                    backgroundColor: Colors.green,
                    radius: 40,
                    child: Image.asset(
                      "assets/images/robot_icon.png",
                      width: 120,
                    ),
                  ),
                  const SizedBox(width: 16),
                  Container(
                    margin: const EdgeInsets.all(8),
                    padding: const EdgeInsets.all(16),
                    decoration: BoxDecoration(
                      color: const Color.fromARGB(255, 230, 230, 230),
                      borderRadius: BorderRadius.circular(16),
                      boxShadow: const [
                        BoxShadow(blurRadius: 10, spreadRadius: 1)
                      ],
                    ),
                    child: Text("Want Some assistance?"),
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
