class Question {
  final String id;
  final String subject;
  final String topic;
  final int number1;
  final int number2;
  final String operation;
  final String answer;
  final String difficulty;

  Question({
    required this.id,
    required this.subject,
    required this.topic,
    required this.number1,
    required this.number2,
    required this.operation,
    required this.answer,
    required this.difficulty,
  });

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'subject': subject,
      'topic': topic,
      'number1': number1,
      'number2': number2,
      'operation': operation,
      'answer': answer,
      'difficulty': difficulty,
    };
  }

  factory Question.fromMap(Map<String, dynamic> map) {
    return Question(
      id: map['id'],
      subject: map['subject'],
      topic: map['topic'],
      number1: map['number1'],
      number2: map['number2'],
      operation: map['operation'],
      answer: map['answer'],
      difficulty: map['difficulty'],
    );
  }
}