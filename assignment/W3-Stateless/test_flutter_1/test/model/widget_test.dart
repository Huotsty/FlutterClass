import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:test_flutter_1/quizflutter/model/quiz.dart';
import 'package:test_flutter_1/quizflutter/quiz_app.dart';




void main() {
  group('QuizApp Tests', () {
    // Mock quiz data
    final mockQuiz = Quiz(
      title: 'Sample Quiz',
      questions: [
        const Question(
          title: 'What is the capital of France?',
          possibleAnswers: ['Paris', 'Madrid', 'Berlin', 'Rome'],
          goodAnswer: 'Paris',
        ),
        const Question(
          title: 'What is 2 + 2?',
          possibleAnswers: ['3', '4', '5', '6'],
          goodAnswer: '4',
        ),
      ],
    );

    testWidgets('displays WelcomeScreen initially', (WidgetTester tester) async {
      await tester.pumpWidget(MaterialApp(home: QuizApp(quiz: mockQuiz)));

      // Verify that the WelcomeScreen is displayed
      expect(find.text('Welcome to the Quiz!'), findsOneWidget);
      expect(find.text('Start Quiz'), findsOneWidget);
    });

    testWidgets('navigates to QuestionScreen on Start Quiz', (WidgetTester tester) async {
      await tester.pumpWidget(MaterialApp(home: QuizApp(quiz: mockQuiz)));

      // Tap the Start Quiz button
      await tester.tap(find.text('Start Quiz'));
      await tester.pumpAndSettle();

      // Verify that the QuestionScreen is displayed
      expect(find.text('What is the capital of France?'), findsOneWidget);
      expect(find.text('Paris'), findsOneWidget);
      expect(find.text('Madrid'), findsOneWidget);
    });

    testWidgets('selects answers and navigates to ResultScreen', (WidgetTester tester) async {
      await tester.pumpWidget(MaterialApp(home: QuizApp(quiz: mockQuiz)));

      // Start the quiz
      await tester.tap(find.text('Start Quiz'));
      await tester.pumpAndSettle();

      // Question 1: Select the correct answer
      await tester.tap(find.text('Paris'));
      await tester.pumpAndSettle();

      // Question 2: Select the correct answer
      await tester.tap(find.text('4'));
      await tester.pumpAndSettle();

      // Verify that the ResultScreen is displayed
      expect(find.text('You answered 2 on 2 !'), findsOneWidget);
      expect(find.text('Restart Quiz'), findsOneWidget);
    });

    testWidgets('restarts the quiz when Restart Quiz is clicked', (WidgetTester tester) async {
      await tester.pumpWidget(MaterialApp(home: QuizApp(quiz: mockQuiz)));

      // Start the quiz
      await tester.tap(find.text('Start Quiz'));
      await tester.pumpAndSettle();

      // Question 1: Select the correct answer
      await tester.tap(find.text('Paris'));
      await tester.pumpAndSettle();

      // Question 2: Select the correct answer
      await tester.tap(find.text('4'));
      await tester.pumpAndSettle();

      // Verify ResultScreen
      expect(find.text('You answered 2 on 2 !'), findsOneWidget);

      // Restart the quiz
      await tester.tap(find.text('Restart Quiz'));
      await tester.pumpAndSettle();

      // Verify WelcomeScreen is displayed again
      expect(find.text('Welcome to the Quiz!'), findsOneWidget);
    });
  });
}
