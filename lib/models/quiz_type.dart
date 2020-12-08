import 'package:flutter/foundation.dart';
import './quiz_session.dart';
import './question_repository.dart';

class RookieQuizSession extends QuizSession{
  RookieQuizSession({QuestionRepository questionRepository}):super(questionRepository, 10);
  bool checkAnswer(String answer) {
    var correct = super.checkAnswer(answer);
    if (correct) theScore++;
    return correct;
  }
}

class JourneymanQuizSession extends QuizSession{
  JourneymanQuizSession({QuestionRepository questionRepository}):super(questionRepository, 10);
  bool checkAnswer(String answer) {
    var correct = super.checkAnswer(answer);
    if (correct) theScore++;
    else theScore--;
    return correct;
  }
}