import 'package:flutter/material.dart';

void main() {
  runApp(
     MaterialApp( 
      home : Scaffold(
        appBar: AppBar(
          title: const Text('Excercise 1', ),
        ),
        body: const Center(
          child: Text('Hello my name is PENGHUOT!',
          style: TextStyle(fontSize: 50, fontWeight: FontWeight.bold, color: Colors.orange),

        ),
           
          
          
        ),
      )
    ),
  );
}