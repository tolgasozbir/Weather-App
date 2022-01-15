import 'package:flutter/material.dart';
import 'package:weather_app/main_screen.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Weather App',
      debugShowCheckedModeBanner: false,
      home: SafeArea(child: MainScreen())
    );
  }
}