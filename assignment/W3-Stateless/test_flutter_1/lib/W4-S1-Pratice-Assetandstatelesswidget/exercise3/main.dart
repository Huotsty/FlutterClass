import 'package:flutter/material.dart';
void main() {
  runApp(const MyApp());
}
enum ButtonType {
  primary,
  secondary,
  disabled,
}
class Button {
  final ButtonType type;
  final IconData icon;
  final String label;

  Button({required this.type, required this.icon, required this.label});
}
const Color primaryColor = Colors.blue;
const Color secondaryColor = Colors.green;
const Color disabledColor = Colors.grey;
class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return const Placeholder();
  }
}