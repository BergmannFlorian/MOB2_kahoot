import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:quiz/models/remote_question_repository.dart';

import 'package:quiz/models/quiz_session.dart';
import 'package:quiz/models/simple_quiz_session.dart';

class GameScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final  Map<String, QuizSessionType>routeParams = ModalRoute.of(context).settings.arguments;
    QuizSession session = QuizSession.fromEnum(routeParams["type"]);
    session.nextQuestion();

    return Scaffold(
      appBar: AppBar(
        title: Text("Quiz"),
      ),
      body: ChangeNotifierProvider.value(
        value: session,
        child: Consumer<QuizSession>(
          builder: (consumerContext, session, __) {
            switch (session.state) {
              case QuizSessionState.starting:
              case QuizSessionState.loading:
                return buildLoading(consumerContext);
              case QuizSessionState.error:
                return buildError(consumerContext, session);
              case QuizSessionState.showing:
                return buildQuestion(consumerContext, session);
              case QuizSessionState.finished:
                return buildGameEnded(consumerContext, session);
            }
          },
        ),
      ),
    );
  }

  Widget buildLoading(BuildContext context) {
    return Center(
      child: CircularProgressIndicator()
    );
  }

  Widget buildError(BuildContext context, QuizSession session) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          Text("Sorry, something went wrong while grabbing the next question", textScaleFactor: 2.0),
          ElevatedButton(
            onPressed: () => session.nextQuestion(),
            child: Text("Retry", textScaleFactor: 2.0, textAlign: TextAlign.center),
          ),
        ],
      ),
    );
  }

  Widget buildQuestion(BuildContext context, QuizSession session) {
    var question = session.currentQuestion;
    var answerButtons = question.answers.map((answer) {
      return ElevatedButton(
        onPressed: () {
          if (session.checkAnswer(answer))
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
          buildHint(context, session),
          Text(question.caption, textScaleFactor: 2.0),
          ...answerButtons,
        ],
      ),
    );
  }

  Widget buildHint(BuildContext context, QuizSession session) {
    if (session.hintRequested) {
      return Text(session.currentQuestion.hint, textScaleFactor: 2.0);
    }
    else {
      return ElevatedButton(
        onPressed: () {
          session.requestHint();
        },
        child: Text("?", textScaleFactor: 2.0, textAlign: TextAlign.center),
      );
    }
  }

  Widget buildGameEnded(BuildContext context, QuizSession session) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          Text("GAME OVER", textScaleFactor: 2.0),
          Text("${session.score} / ${session.questionsCount}", textScaleFactor: 2.0),
          ElevatedButton(
            onPressed: () {
              Navigator.pop(context, "/");
            },
            child: Text("Restart", textScaleFactor: 2.0, textAlign: TextAlign.center),
          ),
        ],
      ),
    );
  }
}
