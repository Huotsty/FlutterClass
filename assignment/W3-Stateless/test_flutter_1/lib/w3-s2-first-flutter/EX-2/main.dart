import 'package:flutter/material.dart';

void main() {
  runApp(MaterialApp(
    home: Container(
      
      padding: const EdgeInsets.all(50),
      margin: const EdgeInsets.all(40),
      color: Colors.blue[300],
      child: Container(
        // Text('data'),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(10.0),
          color: Colors.blue[600],

          ),
          child: const Center(
            child: Text('CADT STUDENTS',
            style: TextStyle(
              color: Colors.white,
              decoration: TextDecoration.none,
            ),
          ),
          ),
          
        ),
      ),
    ),
  );
}
