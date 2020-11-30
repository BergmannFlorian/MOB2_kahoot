import 'package:flutter/foundation.dart';
import 'package:quiz/models/question.dart';

class QuizSession with ChangeNotifier {
  var _score = 0;
  var _questions = [
    Question("2 + 2", ["1", "2", "4"], "4", "come on"),
    Question("Meaning of life?", ["God", "42", "Me"], "42", "H2G2"),
    Question("May the Force be with you", ["Star Wars", "Forest Gump", "American Pie"], "Star Wars", "Skywalker"),
  ];
  var _currentQuestionIndex = 0;

  Question get currentQuestion => _currentQuestionIndex < _questions.length ? _questions[_currentQuestionIndex] : null;
  int get score => _score;

  void nextQuestion() {
    _currentQuestionIndex++;
    notifyListeners();
  }

  bool checkAnswer(String answer) {
    if(_questions[_currentQuestionIndex].isCorrectAnswer(answer)){
      _score++;
      return true;
    } else return false;
  }

  bool isCompleted(){
    return _currentQuestionIndex >= _questions.length;
  }
}
