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
    var session = Provider.of<QuizSession>(context, listen: false);
    if(session.isCompleted()){
      return Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Text("Score : "+session.score.toString(), textScaleFactor: 2.0),
            ElevatedButton(
              onPressed: () {
                session.reset();
              },
              child: SizedBox(
                width: double.infinity,
                child: Text("New Game", textScaleFactor: 2.0, textAlign: TextAlign.center)
              )
            )
          ],
        ),
      );
    }else{
      var answerButtons = question.answers.map((answer) {
        return ElevatedButton(
          onPressed: () {
            session.checkAnswer(answer);
            session.nextQuestion();
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
            Text(session.currentQuestionHint),
            FloatingActionButton(
              onPressed: () {
                session.toogleHint();
              },
              child: Icon(Icons.help),
              backgroundColor: Colors.blue,
            ),
          ],
        ),
      );
    }
  }
}
