import 'dart:math';
import '../model/question.dart';

class QuestionGenerator {
  static Question generateMathQuestion(String topic, String difficulty) {
    Random random = Random();
    int a, b;
    String operation;
    
    switch (difficulty) {
      case 'Easy':
        a = random.nextInt(10) + 1;
        b = random.nextInt(10) + 1;
        break;
      case 'Medium':
        a = random.nextInt(50) + 1;
        b = random.nextInt(50) + 1;
        break;
      case 'Hard':
        a = random.nextInt(100) + 1;
        b = random.nextInt(100) + 1;
        break;
      default:
        throw ArgumentError('Invalid difficulty level');
    }

    switch (topic) {
      case 'Addition':
        operation = '+';
        break;
      case 'Subtraction':
        operation = '-';
        if (b > a) {  // Ensure the result is not negative
          int temp = a;
          a = b;
          b = temp;
        }
        break;
      case 'Multiplication':
        operation = '×';
        break;
      case 'Division':
        operation = '÷';
        b = b == 0 ? 1 : b; // Avoid division by zero
        a = a * b;  // Ensure whole number division
        break;
      default:
        throw ArgumentError('Invalid topic');
    }

    int answer;
    switch (operation) {
      case '+':
        answer = a + b;
        break;
      case '-':
        answer = a - b;
        break;
      case '×':
        answer = a * b;
        break;
      case '÷':
        answer = a ~/ b;  // Integer division
        break;
      default:
        throw StateError('Invalid operation');
    }

    return Question(
      id: DateTime.now().millisecondsSinceEpoch.toString(),
      subject: 'Math',
      topic: topic,
      number1: a,
      number2: b,
      operation: operation,
      answer: answer.toString(),
      difficulty: difficulty,
    );
  }
}