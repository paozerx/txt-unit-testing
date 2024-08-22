class QuestionParser {
  List<Map<String, Object>> parseQuestions(String data) {
    final questions = <Map<String, Object>>[];
    final lines = data.split('\n').map((line) => line.trim()).toList();
    int i = 0;

    while (i < lines.length) {
      if (lines[i].isEmpty) {
        i++;
        continue;
      }

      String questionText = '';
      while (i < lines.length &&
          !lines[i].startsWith('a.') &&
          !lines[i].startsWith('b.') &&
          !lines[i].startsWith('c.') &&
          !lines[i].startsWith('d.') &&
          !lines[i].startsWith('answer:')) {
        questionText += lines[i] + '\n';
        i++;
      }
      questionText = questionText.trim();

      final options = <String>[];
      while (i < lines.length &&
          (lines[i].startsWith('a.') ||
              lines[i].startsWith('b.') ||
              lines[i].startsWith('c.') ||
              lines[i].startsWith('d.'))) {
        options.add(lines[i].substring(3).trim());
        i++;
      }
      var keyAnswer = {'a.': 0, 'b.': 1, 'c.': 2, 'd.': 3};
      String checkAnswer = '';
      String correctAnswer = '';
      if (i < lines.length && lines[i].startsWith('ans')) {
        checkAnswer = lines[i].substring(4).trim();
        for (int j = 0; j < 4; j++) {
          if (keyAnswer[checkAnswer] == j) {
            correctAnswer = options[j];
          }
        }
        i++;
      }

      questions.add({
        'question': questionText,
        'options': options,
        'answer': correctAnswer,
      });

      while (i < lines.length && lines[i].isEmpty) {
        i++;
      }
    }

    return questions;
  }
}
