import 'package:flutter/services.dart' show rootBundle;
import 'package:flutter_test/flutter_test.dart';
import 'package:quizapp/parseQuestions.dart';

void main() {
  TestWidgetsFlutterBinding.ensureInitialized();

  group('parseQuestions', () {
    final qca = QuestionParser();
    final expectedOutput = [
      {
        'question':
            'p → q\np\n∴ q\nFrom the argument above, which theory makes sense?',
        'options': [
          'Modus Ponens',
          'Elimination',
          'Modus Tollens',
          'Generalization'
        ],
        'answer': 'Modus Ponens'
      },
      {
        'question':
            'p → q\n∼P\n∴ ∼q\nFrom the argument above, is it reasonable or not? how ?',
        'options': [
          'Valid by Modus Ponens',
          'Valid by Modus Tollens',
          'Invalid because Inverse error',
          'Invalid because Converse error'
        ],
        'answer': 'Invalid because Inverse error'
      },
      {
        'question': '(p ∧ ∼q) ∨ p ≡ p\nWhich of the following is correct?',
        'options': [
          '(p ∧ ∼q) ∨ p ≡ p isn\'t logically equivalent',
          '(p ∧ ∼q) ∨ p ≡ p is logically equivalent by Absorption laws',
          '(p ∧ ∼q) ∨ p ≡ p is logically equivalent by Distributive laws',
          'There isn\'t correct answer.'
        ],
        'answer': '(p ∧ ∼q) ∨ p ≡ p is logically equivalent by Absorption laws'
      },
      {
        'question':
            'p → q ≡ q → p\np → q ≡ ~p → q\np → q ≡ ~q → ~p\nFrom the statements above, how many statements are true?',
        'options': ['0', '1', '2', '3'],
        'answer': '1'
      },
      {
        'question':
            'Let P(x) be a predicate of x > 2. Which of the following makes P(x) true?',
        'options': ['0', '1', '2', '3'],
        'answer': '3'
      },
      {
        'question': 'p → q is logically equivalent to which of the following?',
        'options': ['p', 'q', '~q → ~p', '~p → ~q'],
        'answer': '~q → ~p'
      }
    ];
    test('should parse questions, options, and correct answer correctly',
        () async {
      final inputData = await rootBundle.loadString('assets/question.txt');
      final parsedQuestions = qca.parseQuestions(inputData);
      expect(parsedQuestions, expectedOutput);
    });

    test('should throw error when options are missing', () async {
      final inputData = await rootBundle.loadString('assets/a _ c_.txt');
      expect(() => qca.parseQuestions(inputData), throwsException);
    });

    test('should handle mixed case option labels', () async {
      final inputData = await rootBundle.loadString('assets/A a B c d.txt');
      expect(() => qca.parseQuestions(inputData), throwsException);
    });

    test('should throw error when all options some question are missing',
        () async {
      final inputData = await rootBundle.loadString('assets/a b c d.txt');
      expect(() => qca.parseQuestions(inputData), throwsException);
    });

    test('should throw error when file is empty', () async {
      final inputData = await rootBundle.loadString('assets/blank.txt');
      expect(() => qca.parseQuestions(inputData), throwsException);
    });

    test('should throw error when options are swap', () async {
      final inputData = await rootBundle.loadString('assets/swap.txt');
      expect(() => qca.parseQuestions(inputData), throwsException);
    });

    test('should throw error when ans is missing', () async {
      final inputData = await rootBundle.loadString('assets/ans.txt');
      expect(() => qca.parseQuestions(inputData), throwsException);
    });
  });
}
