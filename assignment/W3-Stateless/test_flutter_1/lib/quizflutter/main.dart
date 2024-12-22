import 'package:flutter/material.dart';
import 'model/quiz.dart';

import 'quiz_app.dart';

void main() {
  final quiz = Quiz(
    title: "Test quiz",
    questions: [
      const Question(
        title: "What is Flutter?",
        possibleAnswers: ["Framework", "Library", "Language", "IDE"],
        goodAnswer: "Framework",
      ),
      const Question(
        title: "Who developed Dart?",
        possibleAnswers: ["Google", "Facebook", "Apple", "Microsoft"],
        goodAnswer: "Google",
      ),
      const Question(
        title: "What is the main purpose of Flutter?",
        possibleAnswers: ["To build cross-platform apps", "To build web apps", "To build mobile apps", "To build desktop apps"],
        goodAnswer: "To build cross-platform apps",
      ),
    ],
  );

  runApp(MaterialApp(
    home: QuizApp(quiz: quiz),
  ));
}
