import 'dart:convert';
import 'package:http/http.dart' as http;

import 'question_repository.dart';
import 'question.dart';

class RemoteQuestionRepository implements QuestionRepository {
  var _url;

  RemoteQuestionRepository(dynamic url) {
    _url = url;
  }

  Future<Question> fetch() async {
    final response = await http.get(_url);

    if (response.statusCode >= 300) {
      throw Exception('Please handle me');
    }

    return Question.fromJson(jsonDecode(response.body));
  }
}