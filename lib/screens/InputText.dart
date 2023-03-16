// Dada KI Jay Ho

import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:flutter/material.dart';

class InputText extends StatefulWidget {
  final String language;
  const InputText({super.key, required this.language});

  @override
  State<InputText> createState() => _InputTextState();
}

class _InputTextState extends State<InputText> {
  TextEditingController textController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            children: [
              Container(
                height: 36,
              ),
              const Text(
                "Type Your Text below",
                style: TextStyle(fontSize: 20),
              ),
              Padding(
                padding: const EdgeInsets.all(16.0),
                child: TextField(
                  controller: textController,
                  minLines: 20,
                  maxLines: 20,
                  decoration:
                      const InputDecoration(border: OutlineInputBorder()),
                ),
              ),
              const SizedBox(height: 12),
              Padding(
                padding: const EdgeInsets.symmetric(
                    vertical: 16.0, horizontal: 24.0),
                child: ElevatedButton(
                  onPressed: () async {
                    print("Calling api");
                    http.Response response = await http
                        .post(
                          Uri.parse(
                              "https://polyglot-translation-text.onrender.com/translate"),
                          headers: {
                            'accept': 'application/json',
                            'Content-Type': 'application/json'
                          },
                          body: jsonEncode(
                            <String, String>{
                              "text_TBT": textController.text.toString(),
                              "language": widget.language
                            },
                          ),
                        )
                        .catchError(print)
                        .whenComplete(() {
                      setState(() {
                        // isLoading = false;
                      });
                    });
                    print(response.body);
                  },
                  child: const Padding(
                    padding: EdgeInsets.all(16.0),
                    child: Text(
                      "Get Translation",
                      style: TextStyle(fontSize: 18),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
