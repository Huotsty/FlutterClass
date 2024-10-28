import 'package:flutter/material.dart';
import 'package:test_flutter_1/w3-s2-first-flutter/EX-4/gradiantstateless1.dart';

void main() {
  runApp(
     const MaterialApp(
      home: Center(
        child:  Column(
          children:  <Widget>[
            GradiantButton(text: 'Welcome', startColor: Colors.black, endColor: Colors.white),
            GradiantButton(text: 'C', startColor: Colors.red, endColor: Colors.blue),
            GradiantButton(text: 'A', startColor: Colors.green, endColor: Colors.yellow),
            GradiantButton(text: 'D', startColor: Colors.purple, endColor: Colors.pink),
            GradiantButton(text: 'T', startColor: Color.fromARGB(255, 130, 94, 40), endColor: Colors.brown),
          ],
        ),
      ),
    ),
  );
}