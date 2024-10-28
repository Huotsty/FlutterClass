import 'package:flutter/material.dart';
class GradiantButton extends StatelessWidget {
  final String text;
  final Color startColor;
  final Color endColor;
  const GradiantButton({super.key,required this.text, required this.startColor, required this.endColor});

  @override
  Widget build(BuildContext context) {
    return Container(
              margin: const EdgeInsets.all(10),
              padding: const EdgeInsets.all(30),
              decoration: BoxDecoration(
                borderRadius:  BorderRadius.circular(35),
              gradient:  LinearGradient(colors: [
                startColor,
                endColor,
              ])
              ),
              child:  Text(
                text,
                style: const TextStyle(
                    color: Colors.white,
                    fontSize: 35,
                    decoration: TextDecoration.none),
              ),
            );
  }
}
