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

class _DiceRollerState extends State<DiceRoller> {
    void _rollDice() {
     //  Display the dice 4 !
     setState(() {
       
     });
  }
  @override
  Widget build(BuildContext context) {
    return const Placeholder();
  }
}

void main() => runApp(const MaterialApp(
      home: Scaffold(
        backgroundColor: Colors.deepPurple,
        body: Center(child: DiceRoller()),
      ),
    ));