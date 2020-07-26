import 'package:flutter/material.dart';
import 'package:forkwalls/views/home.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Fork Walls',
      theme: ThemeData(
        primaryColor: Colors.blueGrey[900],
      ),
      home: Home(),
    );
  }
}
