import 'package:flutter/material.dart';
import 'package:twodo/twodo/home.dart';
import 'package:twodo/twodo/input.dart';
import 'package:twodo/twodo/landing.dart';

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
        colorScheme: ColorScheme.fromSeed(seedColor: Color(0x2D9596)),
        scaffoldBackgroundColor: Colors.teal,
        useMaterial3: false,
      ),
      debugShowCheckedModeBanner: false,
      home: const LandingPage(),
    );
  }
}
