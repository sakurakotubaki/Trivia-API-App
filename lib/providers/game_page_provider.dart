import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:dio/dio.dart';

class GamePageProvider extends ChangeNotifier {
  final Dio _dio = Dio();
  final int _maxQuestions = 10;

  List? questions;
  int _currentQuestionCount = 0; // 質問数

  BuildContext context;
  GamePageProvider({required this.context}) {
    _dio.options.baseUrl = 'https://opentdb.com/api.php';
    _getQuestionsFromAPI();
  }
  Future<void> _getQuestionsFromAPI() async {
    var _response = await _dio.get(
      '',
      queryParameters: {'amount': 10, 'type': 'boolean', 'difficulty': 'easy'},
    );
    // データーを保存
    var _data = jsonDecode(
      _response.toString(),
    );
    questions = _data['results'];
    notifyListeners(); // 変わったら通知する
  }

  String getCurrentQuestionText() {
    return questions![_currentQuestionCount]["question"];
  }

  void answerQuestion(String _answer) async {
    bool isCorrect =
        questions![_currentQuestionCount]["correct_answer"] == _answer;
    _currentQuestionCount++;
    print(isCorrect ? "Correct" : "InCorrect");
    notifyListeners(); // 変更をクラスに通知
  }
}
