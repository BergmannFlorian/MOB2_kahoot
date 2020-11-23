import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'package:quiz/models/quiz_session.dart';
import 'package:quiz/models/question.dart';

class GameScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Quiz"),
      ),
      body: ChangeNotifierProvider(
        create: (_) => QuizSession(),
        child: Consumer<QuizSession>(
          builder: (consumerContext, session, __) => buildQuestion(consumerContext, session.currentQuestion),
        ),
      ),
    );
  }

  Widget buildQuestion(BuildContext context, Question question) {
    var answerButtons = question.answers.map((answer) {
      return ElevatedButton(
        onPressed: () {
          var session = Provider.of<QuizSession>(context, listen: false);
          if (session.checkAnswer(answer)) {
            session.nextQuestion();
          }
        },
        child: SizedBox(
          width: double.infinity,
          child: Text(answer, textScaleFactor: 2.0, textAlign: TextAlign.center)
        )
      );
    });

    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          Text(question.caption, textScaleFactor: 2.0),
          ...answerButtons,
        ],
      ),
    );
  }
}
