import 'package:flutter/foundation.dart';
import 'package:quiz/models/question.dart';

class QuizSession with ChangeNotifier {
  var score = 0;
  var _questions = [
    Question("2 + 2", ["1", "2", "4"], "4", "come on"),
    Question("Meaning of life?", ["God", "42", "Me"], "42", "H2G2"),
    Question("May the Force be with you", ["Star Wars", "Forest Gump", "American Pie"], "Star Wars", "Skywalker"),
  ];
  var _currentQuestionIndex = 0;

  Question get currentQuestion => _questions[_currentQuestionIndex];

  void nextQuestion() {
    _currentQuestionIndex = _currentQuestionIndex + 1 < _questions.length -1 ? _currentQuestionIndex++ : null;
    notifyListeners();
  }

  bool checkAnswer(String answer) {
    if(_questions[_currentQuestionIndex].isCorrectAnswer(answer)){
      score++;
      return true;
    } else return false;
  }
}
