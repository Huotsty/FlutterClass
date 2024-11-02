import 'dart:math';
import 'package:flutter/material.dart';

const String diceImage1 = 'assets/dice-images/dice-1.png';
const String diceImage2 = 'assets/dice-images/dice-2.png';
const String diceImage3 = 'assets/dice-images/dice-3.png';
const String diceImage4 = 'assets/dice-images/dice-4.png';
const String diceImage5 = 'assets/dice-images/dice-5.png';
const String diceImage6 = 'assets/dice-images/dice-6.png';

String activeDiceImage = diceImage2;

class DiceRoller extends StatefulWidget {
  const DiceRoller({super.key});

  @override
  State<DiceRoller> createState() => _DiceRollerState();
}

class _DiceRollerState extends State<DiceRoller> with SingleTickerProviderStateMixin {
  final Random _random = Random();
  late AnimationController _controller;
  late Animation<double> _animation;

  @override
  void initState() {
    super.initState();

    // Initialize the AnimationController and set a longer duration for the drop effect
    _controller = AnimationController(
      duration: const Duration(milliseconds: 1500), // Longer duration for tumbling effect
      vsync: this,
    );

    // Define a curve to simulate quick spin followed by slow stop
    _animation = Tween<double>(begin: 0, end: 12 * pi).animate(
      CurvedAnimation(
        parent: _controller,
        curve: Curves.easeOut, // Fast at the beginning, then gradually slows down
      ),
    );

    // Listen to animation status to update dice image when it completes
    _controller.addStatusListener((status) {
      if (status == AnimationStatus.completed) {
        setState(() {
          // Pick a random dice image after the spin animation completes
          int diceNumber = _random.nextInt(6) + 1;
          switch (diceNumber) {
            case 1:
              activeDiceImage = diceImage1;
              break;
            case 2:
              activeDiceImage = diceImage2;
              break;
            case 3:
              activeDiceImage = diceImage3;
              break;
            case 4:
              activeDiceImage = diceImage4;
              break;
            case 5:
              activeDiceImage = diceImage5;
              break;
            case 6:
              activeDiceImage = diceImage6;
              break;
          }
        });
      }
    });
  }

  @override
  void dispose() {
    _controller.dispose(); // Dispose of the controller when the widget is removed
    super.dispose();
  }

  void _rollDice() {
    _controller.forward(from: 0); // Start the tumbling animation
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        GestureDetector(
          onTap: _rollDice, // Detects tap on the dice image
          child: RotationTransition(
            turns: _animation,
            child: Image.asset(
              activeDiceImage,
              width: 200,
            ),
          ),
        ),
        const SizedBox(height: 20),
        TextButton(
          onPressed: _rollDice,
          style: TextButton.styleFrom(
            foregroundColor: Colors.white,
            textStyle: const TextStyle(
              fontSize: 28,
            ),
          ),
          child: const Text('Roll Dice'),
        ),
      ],
    );
  }
}

void main() => runApp(const MaterialApp(
      home: Scaffold(
        backgroundColor: Colors.deepPurple,
        body: Center(child: DiceRoller()),
      ),
    ));
