import 'package:flutter/foundation.dart';
import 'package:quiz/models/question.dart';

class QuizSession with ChangeNotifier {
  var _questions = [
    Question("2 + 2", ["1", "2", "4"], "4", "come on"),
    Question("Meaning of life?", ["God", "42", "Me"], "42", "H2G2"),
    Question("May the Force be with you", ["Star Wars", "Forest Gump", "American Pie"], "Star Wars", "Skywalker"),
  ];
  var _score = 0;
  var _currentQuestionIndex = 0;
  var _showHint = false;

  Question get currentQuestion => _currentQuestionIndex < _questions.length ? _questions[_currentQuestionIndex] : null;
  int get score => _score;
  String get currentQuestionHint => _showHint ? currentQuestion.hint : "";

  void nextQuestion() {
    _currentQuestionIndex++;
    _showHint = false;
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

  void toogleHint(){
    _showHint = !_showHint;
    notifyListeners();
  }
  // TODO CHANGE
  reset(){
     _score = 0;
    _currentQuestionIndex = 0;
    _showHint = false;
    notifyListeners();
  }

}
