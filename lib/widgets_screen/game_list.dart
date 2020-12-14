import 'package:flutter/material.dart';
import '../models/quiz_session.dart';

class GameList extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text("Quiz List"),
        ),
        body: ListQuiz(context),
    );
  }

  Widget ListQuiz(BuildContext context) {
    var quizzButtons = QuizSessionType.values.map((type) {
      return ElevatedButton(
          onPressed: () {
            Navigator.pushNamed(context,"/quiz", arguments: {"type": type});
          },
          child: Text(
              type?.toString()?.split('.')?.elementAt(1), textScaleFactor: 2.0,
              textAlign: TextAlign.center)
      );
    });
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          ...quizzButtons,
        ],
      ),
    );
  }
}