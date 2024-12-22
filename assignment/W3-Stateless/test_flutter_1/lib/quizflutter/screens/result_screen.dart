import 'package:flutter/material.dart';
import '../model/quiz.dart';
import '../model/submission.dart';

class ResultScreen extends StatelessWidget {
  final Quiz quiz;
  final Submission submission;
  final VoidCallback onRestart;

  const ResultScreen({
    required this.quiz,
    required this.submission,
    required this.onRestart,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    final int totalScore = submission.getScore();
    final int totalQuestions = quiz.questions.length;

    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          
          Text(
            "You answered $totalScore out of $totalQuestions!",
            textAlign: TextAlign.center,
            style: const TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
          ),
          const SizedBox(height: 24),

         
          Expanded(
            child: ListView.builder(
              itemCount: quiz.questions.length,
              itemBuilder: (context, index) {
                final question = quiz.questions[index];
                final userAnswer = submission.getAnswerFor(question)?.selectedAnswer ?? '';
                final isCorrect = submission.getAnswerFor(question)?.isCorrect ?? false;

                return ResultItem(
                  question: question,
                  userAnswer: userAnswer,
                  isCorrect: isCorrect,
                  questionNumber: index + 1,
                );
              },
            ),
          ),

          const SizedBox(height: 16),

          
          ElevatedButton(
            onPressed: onRestart,
            style: ElevatedButton.styleFrom(
              backgroundColor: Colors.blue,
              padding: const EdgeInsets.all(16),
            ),
            child: const Text(
              "Restart Quiz",
              style: TextStyle(fontSize: 18),
            ),
          ),
        ],
      ),
    );
  }
}

class ResultItem extends StatelessWidget {
  final Question question;
  final String userAnswer;
  final bool isCorrect;
  final int questionNumber;

  const ResultItem({
    required this.question,
    required this.userAnswer,
    required this.isCorrect,
    required this.questionNumber,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: const EdgeInsets.symmetric(vertical: 8.0),
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Question identifier
            Row(
              children: [
                CircleAvatar(
                  backgroundColor: isCorrect ? Colors.green : Colors.red,
                  child: Text(
                    questionNumber.toString(),
                    style: const TextStyle(color: Colors.white),
                  ),
                ),
                const SizedBox(width: 16),
                Expanded(
                  child: Text(
                    question.title,
                    style: const TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 8),

           
            Text(
              "Your answer: $userAnswer",
              style: TextStyle(
                fontSize: 14,
                color: isCorrect ? Colors.green : Colors.red,
              ),
            ),

            
            if (!isCorrect)
              Text(
                "Correct answer: ${question.goodAnswer}",
                style: const TextStyle(
                  fontSize: 14,
                  color: Colors.black,
                ),
              ),
          ],
        ),
      ),
    );
  }
}
