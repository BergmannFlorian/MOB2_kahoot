import 'dart:async';
import './quiz_session.dart';
import './question_repository.dart';

class RookieQuizSession extends QuizSession{
  RookieQuizSession(questionRepository, {totalQuestionCount = 10}):super(questionRepository, totalQuestionCount);
  bool checkAnswer(String answer) {
    var correct = super.checkAnswer(answer);
    if (correct) theScore++;
    return true;
  }
}

class JourneymanQuizSession extends QuizSession{
  JourneymanQuizSession(questionRepository, {totalQuestionCount = 10}):super(questionRepository, totalQuestionCount);
  bool checkAnswer(String answer) {
    var correct = super.checkAnswer(answer);
    if (correct) theScore++;
    else theScore--;
    return correct;
  }
}

class WarriorQuizSession extends JourneymanQuizSession{
  WarriorQuizSession(questionRepository, {totalQuestionCount = 15}):super(questionRepository, totalQuestionCount: totalQuestionCount){
    startTimeoutQuiz(30);
  }
  void startTimeoutQuiz(int duration){
    Timer(Duration(seconds: duration), super.setFinished);
  }
}

class NinjaQuizSession extends WarriorQuizSession{
  Timer timerQuestion;
  NinjaQuizSession(questionRepository, {totalQuestionCount = 15}):super(questionRepository, totalQuestionCount: totalQuestionCount);
  void nextQuestion() async {
    super.nextQuestion();
    startTimeoutQuestion(3);
  }
  void startTimeoutQuestion(int duration){
    if (timerQuestion != null) timerQuestion.cancel();
    timerQuestion = Timer(Duration(seconds: duration), nextQuestion);
  }
}