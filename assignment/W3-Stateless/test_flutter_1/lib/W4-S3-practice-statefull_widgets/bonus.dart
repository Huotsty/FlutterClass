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
        backgroundColor: Colors.green[100],
        appBar: AppBar(
          title: const Center(child: Text('Score Cards')),
          backgroundColor: Colors.green,
        ),
        body: const Padding(
          padding: EdgeInsets.all(16.0),
          child: Column(
            children: [
              ScoreCard(subject: 'Flutter'),
              SizedBox(height: 16),
              ScoreCard(subject: 'Dart'),
              SizedBox(height: 16),
              ScoreCard(subject: 'React'),
            ],
          ),
        ),
      ),
    );
  }
}

class ScoreCard extends StatefulWidget {
  final String subject;

  const ScoreCard({super.key, required this.subject});

  @override
  State<ScoreCard> createState() => _ScoreCardState();
}

class _ScoreCardState extends State<ScoreCard> {
  int score = 1; 

  void incrementScore() {
    if (score < 10) {
      setState(() {
        score++;
      });
    }
  }

  void decrementScore() {
    if (score > 1) {
      setState(() {
        score--;
      });
    }
  }

  // Function to get color based on score
  Color getScoreColor() {
    // Map score to colors from light to dark green
    if (score <= 3) {
      return Colors.lightGreenAccent;
    } else if (score <= 6) {
      return Colors.greenAccent;
    } else if (score <= 8) {
      return Colors.green;
    } else {
      return const Color.fromARGB(255, 28, 120, 31);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.3),
            spreadRadius: 2,
            blurRadius: 5,
            offset: const Offset(0, 3),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Center(
            child: Text(
              'My score in ${widget.subject}',
              style: const TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
          const SizedBox(height: 10),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              IconButton(
                onPressed: decrementScore,
                icon: const Icon(Icons.remove),
                color: Colors.black,
              ),
              Text(
                '$score',
                style: const TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                ),
              ),
              IconButton(
                onPressed: incrementScore,
                icon: const Icon(Icons.add),
                color: Colors.black,
              ),
            ],
          ),
          const SizedBox(height: 10),
          LinearProgressIndicator(
            borderRadius: BorderRadius.circular(10),
            minHeight: 50,
            value: score / 10,
            backgroundColor: Colors.grey[300],
            color: getScoreColor(),
          ),
        ],
      ),
    );
  }
}
