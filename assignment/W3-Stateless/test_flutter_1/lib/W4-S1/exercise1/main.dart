import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(title: const Text('My hobbies')),
        body: const Padding(
          padding: EdgeInsets.all(40),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              HobbyCard(
                hobbyTitle: 'Travelling',
                icon: Icons.travel_explore,
              ),
              HobbyCard(
                hobbyTitle: 'Skating',
                icon: Icons.skateboarding,
              ),
              HobbyCard(
                hobbyTitle: 'basketball',
                icon: Icons.sports_basketball,
              )
            ],
          ),
        ),
      ),
    );
  }
}

class HobbyCard extends StatelessWidget {
  const HobbyCard(
      {super.key,
      required this.hobbyTitle,
      required this.icon,
      this.backgroundColor = Colors.blue});
  final String hobbyTitle;
  final IconData icon;
  final Color backgroundColor;
  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.fromLTRB(0, 0, 0, 20),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(20),
        color: backgroundColor,
      ),
      child: Center(
        child: Row(
          children: [
            Padding(
              padding: const EdgeInsets.fromLTRB(30, 0, 0, 0),
              child: Row(
                children: [
                  Icon(icon, color: Colors.white, size: 20.0),
                  const SizedBox(width: 20.0),
                  Text(hobbyTitle,
                      style: const TextStyle(
                          fontSize: 30, color: Colors.white)) // Added style
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}
