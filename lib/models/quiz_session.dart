import 'quiz_type.dart';
import 'package:flutter/foundation.dart';
import 'package:quiz/models/question.dart';
import 'package:quiz/models/question_repository.dart';

import 'Remote_question_repository.dart';
import 'question_repository.dart';

enum QuizSessionState {
  starting,
  showing,
  loading,
  error,
  finished,
}
enum QuizSessionType {
  rookie,
  journeyman,
  warrior,
  ninja,
}
class QuizSession with ChangeNotifier {
  var _questionRepository;
  var _totalQuestionCount;
  var _currentQuestionCount = 0;

  // There's no `protected` visibility on Dart, so set it back to public!
  //https://stackoverflow.com/questions/28350655/how-do-i-emulate-protected-methods-in-dart
  var theScore = 0; // should never be accessed from the outside except from subclasses

  var _state;
  var _hintRequested = false;

  Question _currentQuestion;

  QuizSessionState get state => _state;
  Question get currentQuestion => _currentQuestion;
  int get questionsCount => _totalQuestionCount;
  int get score => theScore;
  bool get hintRequested => _hintRequested;

  QuizSession(questionRepository, totalQuestionCount) {
    _questionRepository = questionRepository;
    _totalQuestionCount = totalQuestionCount;
    _state = QuizSessionState.starting;
  }

  factory QuizSession.fromEnum(QuizSessionType type,[bool local = true]){
    var questionRepository = local ? new StaticQuestionRepository() : new RemoteQuestionRepository("http://10.0.2.2:4567/questions/next");
    switch(type){
      case QuizSessionType.rookie:
        return RookieQuizSession(questionRepository);
      case QuizSessionType.journeyman:
        return JourneymanQuizSession(questionRepository);
      case QuizSessionType.ninja:
        return NinjaQuizSession(questionRepository);
      case QuizSessionType.warrior:
        return WarriorQuizSession(questionRepository);
      default:
        return QuizSession(questionRepository, 10);
    }
  }

  void setFinished(){
    _state = QuizSessionState.finished;
    notifyListeners();
  }

  void nextQuestion() async {
    _hintRequested = false;

    try {
      _currentQuestionCount++;
      if (_currentQuestionCount > _totalQuestionCount) {
        _currentQuestion = null;
        _state = QuizSessionState.finished;
      }
      else {
        _state = QuizSessionState.loading;
        notifyListeners();
        _currentQuestion = await _questionRepository.fetch();
        _state = QuizSessionState.showing;
      }
    }
    catch (error) {
      _state = QuizSessionState.error;
    }

    notifyListeners();
  }

  bool checkAnswer(String answer) {
    return currentQuestion.isCorrectAnswer(answer);
  }

  void requestHint() {
    _hintRequested = true;
    notifyListeners();
  }
}
