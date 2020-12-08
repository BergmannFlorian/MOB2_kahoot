import 'package:quiz/models/question_repository.dart';
import 'package:quiz/models/quiz_session.dart';

class SimpleQuizSession extends QuizSession {

  SimpleQuizSession({QuestionRepository questionRepository}) : super(questionRepository: questionRepository, totalQuestionCount: 10);

  bool checkAnswer(String answer) {
    var correct = super.checkAnswer(answer);
    if (correct) theScore++;
    return correct;
  }
}