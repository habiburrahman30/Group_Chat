import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:group_app/src/pages/group_page.dart';
import 'package:uuid/uuid.dart';

import 'Individual_chat_page.dart';

class HomePage extends StatefulWidget {
  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  void _incrementCounter() {
    setState(() {});
  }

  TextEditingController nameController = TextEditingController();
  final formKey = GlobalKey<FormState>();
  var uuid = Uuid();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Group Chat App'),
        centerTitle: true,
      ),
      body: Center(
        child: TextButton(
          onPressed: () {
            showDialog(
                context: context,
                builder: (BuildContext context) {
                  return AlertDialog(
                    title: Text('Please enter your name'),
                    content: Form(
                      key: formKey,
                      child: TextFormField(
                        controller: nameController,
                        validator: (value) {
                          if (value == null || value.length < 3) {
                            return "User must have proper name.";
                          }
                          return null;
                        },
                      ),
                    ),
                    actions: [
                      TextButton(
                        onPressed: () {
                          Navigator.pop(context);
                          nameController.clear();
                        },
                        child: Text(
                          'Cancel',
                          style: TextStyle(
                            fontSize: 16,
                            color: Colors.green,
                          ),
                        ),
                      ),
                      TextButton(
                        onPressed: () {
                          if (formKey.currentState!.validate()) {
                            final name = nameController.text.trim();
                            Navigator.pop(context);
                            Navigator.push(
                              context,
                              MaterialPageRoute(builder: (context) {
                                return GroupPage(
                                  name: name,
                                  userId: uuid.toString(),
                                );
                              }),
                            );
                          }
                        },
                        child: Text(
                          'Enter',
                          style: TextStyle(
                            fontSize: 16,
                            color: Colors.blue,
                          ),
                        ),
                      ),
                    ],
                  );
                });
          },
          child: Text('Join Group'),
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Get.to(() => IndividualChatPage());
        },
        tooltip: 'Increment',
        child: const Icon(Icons.add),
      ), // This trailing comma makes auto-formatting nicer for build methods.
    );
  }
}
