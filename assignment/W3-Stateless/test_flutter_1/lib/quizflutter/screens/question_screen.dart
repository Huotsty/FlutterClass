import 'package:flutter/material.dart';
import '../model/quiz.dart';
import '../model/submission.dart';

class QuestionScreen extends StatefulWidget {
  final Quiz quiz;
  final Submission submission;
  final VoidCallback onFinish;

  const QuestionScreen({
    required this.quiz,
    required this.submission,
    required this.onFinish,
    super.key,
  });

  @override
  State<QuestionScreen> createState() => _QuestionScreenState();
}

class _QuestionScreenState extends State<QuestionScreen> {
  int currentQuestionIndex = 0;

  void handleAnswer(String selectedAnswer) {
    
    final currentQuestion = widget.quiz.questions[currentQuestionIndex];
    
    widget.submission.addAnswer(currentQuestion, selectedAnswer);

    
    if (currentQuestionIndex == widget.quiz.questions.length - 1) {
      widget.onFinish(); 
    } else {
      
      setState(() {
        currentQuestionIndex++;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    final currentQuestion = widget.quiz.questions[currentQuestionIndex];

    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
         
          Text(
            currentQuestion.title,
            style: const TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
          ),
          const SizedBox(height: 16),

          
          ...currentQuestion.possibleAnswers.map((answer) {
            return Padding(
              padding: const EdgeInsets.symmetric(vertical: 8.0),
              child: ElevatedButton(
                onPressed: () => handleAnswer(answer),
                child: Text(answer),
              ),
            );
          }),
        ],
      ),
    );
  }
}
