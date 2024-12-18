import 'package:flutter/material.dart';
import 'package:test_flutter_1/Week6-s2-practice/EXERCISE-3/screen/temperature.dart';
import 'package:test_flutter_1/Week6-s2-practice/EXERCISE-3/screen/welcome.dart';


class TemperatureApp extends StatefulWidget {
  const TemperatureApp({super.key});

  @override
  State<TemperatureApp> createState() {
    return _TemperatureAppState();
  }
}

class _TemperatureAppState extends State<TemperatureApp> {
  bool showWelcomeScreen = true;

  void switchScreen() {
    setState(() {
      showWelcomeScreen = !showWelcomeScreen;
    });
  }
  @override
  Widget build(context) {

    return MaterialApp(
      home: Scaffold(
        body: Container(
          decoration: const BoxDecoration(
            gradient: LinearGradient(
              colors: [
                Color(0xff16C062),
                Color(0xff00BCDC),
              ],
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
            ),
          ),
          child: showWelcomeScreen?  Welcome(onStart: switchScreen): Temperature(),
        ),
      ),
    );
  }
}

void main() {
  runApp(const TemperatureApp());
}
