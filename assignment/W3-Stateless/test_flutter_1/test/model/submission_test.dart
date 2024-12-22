import 'package:flutter_test/flutter_test.dart';
import 'package:test_flutter_1/quizflutter/model/quiz.dart';
import 'package:test_flutter_1/quizflutter/model/submission.dart';


void main() {
  group('Quiz Model Tests', () {
    // Create test data
    const question1 = Question(
      title: "What is the capital of France?",
      possibleAnswers: ["Paris", "London", "Berlin", "Madrid"],
      goodAnswer: "Paris",
    );

    const question2 = Question(
      title: "What is 2 + 2?",
      possibleAnswers: ["3", "4", "5", "6"],
      goodAnswer: "4",
    );

    const question3 = Question(
      title: "Which programming language is used for Flutter?",
      possibleAnswers: ["Java", "Swift", "Dart", "Kotlin"],
      goodAnswer: "Dart",
    );

    final quiz = Quiz(
      title: "General Knowledge Quiz",
      questions: [question1, question2, question3],
    );

    test('Answer.isCorrect() should correctly evaluate answers', () {
      final correctAnswer = Answer(question: question1, selectedAnswer: "Paris");
      final incorrectAnswer = Answer(question: question1, selectedAnswer: "London");

      expect(correctAnswer.isCorrect, isTrue);
      expect(incorrectAnswer.isCorrect, isFalse);
    });

    test('Submission.addAnswer() should add or update answers', () {
      final submission = Submission();

      submission.addAnswer(question1, "Paris");
      expect(submission.getAnswerFor(question1)?.selectedAnswer, "Paris");

      submission.addAnswer(question1, "London"); // Update the answer
      expect(submission.getAnswerFor(question1)?.selectedAnswer, "London");
    });

    test('Submission.getScore() should calculate the correct score', () {
      final submission = Submission();

      submission.addAnswer(question1, "Paris"); // Correct
      submission.addAnswer(question2, "4"); // Correct
      submission.addAnswer(question3, "Java"); // Incorrect

      expect(submission.getScore(), 2);
    });

    test('Submission.removeAnswers() should clear all answers', () {
      final submission = Submission();

      submission.addAnswer(question1, "Paris");
      submission.addAnswer(question2, "4");

      submission.removeAnswers();

      expect(submission.getAnswerFor(question1), isNull);
      expect(submission.getAnswerFor(question2), isNull);
      expect(submission.getScore(), 0);
    });

    test('Submission.getAnswerFor() should retrieve the correct answer', () {
      final submission = Submission();

      submission.addAnswer(question1, "Paris");
      submission.addAnswer(question2, "4");

      final answer1 = submission.getAnswerFor(question1);
      final answer2 = submission.getAnswerFor(question2);

      expect(answer1?.selectedAnswer, "Paris");
      expect(answer2?.selectedAnswer, "4");
    });
  });
}
