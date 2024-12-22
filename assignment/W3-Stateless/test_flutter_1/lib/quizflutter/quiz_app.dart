import 'package:flutter/material.dart';

import 'model/quiz.dart';
import 'model/submission.dart';
import 'screens/question_screen.dart';
import 'screens/result_screen.dart';
import 'screens/welcome_screen.dart';

enum QuizState { notStarted, started, finished }

class QuizApp extends StatefulWidget {
  final Quiz quiz;

  const QuizApp({required this.quiz, super.key});

  @override
  State<QuizApp> createState() => _QuizAppState();
}

class _QuizAppState extends State<QuizApp> {
  QuizState quizState = QuizState.notStarted;
  late Submission submission;

  @override
  void initState() {
    super.initState();
    submission = Submission();
  }

  void startQuiz() {
    setState(() {
      quizState = QuizState.started;
    });
  }

  void finishQuiz() {
    setState(() {
      quizState = QuizState.finished;
    });
  }

  void restartQuiz() {
    setState(() {
      quizState = QuizState.notStarted;
      submission.removeAnswers();
    });
  }

  @override
  Widget build(BuildContext context) {
    if (widget.quiz.questions.isEmpty) {
      return const Scaffold(
        body: Center(
          child: Text(
            "No questions available for this quiz.",
            style: TextStyle(fontSize: 18),
          ),
        ),
      );
    }

    String appBarTitle;
    switch (quizState) {
      case QuizState.notStarted:
        appBarTitle = "Welcome to the Quiz!";
        break;
      case QuizState.started:
        appBarTitle = "Quiz in Progress";
        break;
      case QuizState.finished:
        appBarTitle = "Quiz Results";
        break;
    }

    
    Widget screen;
    switch (quizState) {
      case QuizState.notStarted:
        screen = WelcomeScreen(
          onStart: startQuiz,
          quizTitle: widget.quiz.title,
        );
        break;
      case QuizState.started:
        screen = QuestionScreen(
          quiz: widget.quiz,
          submission: submission,
          onFinish: finishQuiz,
        );
        break;
      case QuizState.finished:
        screen = ResultScreen(
          quiz: widget.quiz,
          submission: submission,
          onRestart: restartQuiz,
        );
        break;
    }

    return Scaffold(
      appBar: AppBar(
        title: Text(appBarTitle),
      ),
      body: screen,
    );
  }
}
