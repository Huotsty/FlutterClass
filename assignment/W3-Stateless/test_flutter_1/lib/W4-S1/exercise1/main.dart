import 'package:flutter/material.dart';

void main() {
  Scaffold(
    appBar: AppBar(title: const Text('My hobbies')),
    body: const Padding(
      padding: EdgeInsets.fromLTRB(40, 40, 40, 10),
      child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          
            Center(
              Row(
                MainAxisAlignment mainAxisAlignment = MainAxisAlignment.start,
                Padding(
                    padding: EdgeInsets.fromLTRB(30, 0, 20, 0),
                    Icon(
                      Icons.travel_explore,
                      color: Colors.white,
                      size: 24.0
                    )
                    ),
                 Text('Travelling')
                )
                )
          ),
    ),
  );
}
