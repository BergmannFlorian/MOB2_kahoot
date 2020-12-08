import 'dart:async';
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
  bool _lastAnswer = true;
  JourneymanQuizSession({QuestionRepository questionRepository}):super(questionRepository, 10);
  bool checkAnswer(String answer) {
    var correct = super.checkAnswer(answer);
    if (correct) theScore++;
    else theScore--;
    _lastAnswer = correct;
    return correct;
  }
  void nextQuestion() async {
    if(_lastAnswer) super.nextQuestion();
  }
}

class WarriorQuizSession extends QuizSession{
  bool _lastAnswer = true;
  WarriorQuizSession({QuestionRepository questionRepository}):super(questionRepository, 15){
    startTimeout(30);
  }
  bool checkAnswer(String answer) {
    var correct = super.checkAnswer(answer);
    if (correct) theScore++;
    else theScore--;
    _lastAnswer = correct;
    return correct;
  }
  void nextQuestion() async {
    if(_lastAnswer) super.nextQuestion();
  }
  void startTimeout(int duration){
    Timer(Duration(seconds: duration), super.setFinished);
  }
}

class NinjaQuizSession extends QuizSession{
  bool _lastAnswer = true;
  Timer timerQuestion;
  NinjaQuizSession({QuestionRepository questionRepository}):super(questionRepository, 15){
    startTimeoutQuiz(30);
  }
  bool checkAnswer(String answer) {
    var correct = super.checkAnswer(answer);
    if (correct) theScore++;
    else theScore--;
    _lastAnswer = correct;
    return correct;
  }
  void nextQuestion() async {
    if(_lastAnswer){
      super.nextQuestion();
      startTimeoutQuestion(3);
    } 
  }
  void startTimeoutQuiz(int duration){
    Timer(Duration(seconds: duration), super.setFinished);
  }
  void startTimeoutQuestion(int duration){
    if (timerQuestion != null) timerQuestion.cancel();
    timerQuestion = Timer(Duration(seconds: duration), super.nextQuestion);
  }
}