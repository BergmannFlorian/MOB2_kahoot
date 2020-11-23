class Question {
  String caption;
  List<String> answers;
  String hint;

  String _correctAnswer;

  Question(this.caption, this.answers, this._correctAnswer, [this.hint = ""]);

  bool isCorrectAnswer(String answer) {
    return _correctAnswer == answer;
  }
}
