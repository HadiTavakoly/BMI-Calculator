import 'package:flutter/material.dart';
import 'screens/homepage.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: '<--B-M-I-->',
      theme: ThemeData(
        primarySwatch: Colors.blue,
        fontFamily: 'b nazanin'
      ),
      home: const HomePage(),
    );
  }
}

