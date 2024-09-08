import 'package:flutter/material.dart';
import 'package:tic/home.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        brightness: Brightness.dark,
        primarySwatch: Colors.blue,
        primaryColor: const Color(0xFF00061a),
        splashColor: Color(0xFF4169e8),
        shadowColor: Color(0xFF001456),
        useMaterial3: true,
      ),
      home: Home(),
    );
  }
}
