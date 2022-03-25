import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:dio/dio.dart';

class GamePageProvider extends ChangeNotifier {
  final Dio _dio = Dio();
  final int _maxQuestions = 10; // 10回までカウント

  List? questions;
  int _currentQuestionCount = 0; // 質問数
  int _correctCount = 0;

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
    _correctCount += isCorrect ? 1 : 0; // 正しく答えるとカウントされる
    _currentQuestionCount++;
    showDialog(
        context: context,
        builder: (BuildContext _context) {
          return AlertDialog(
            backgroundColor: isCorrect ? Colors.green : Colors.red,
            title: Icon(
              isCorrect ? Icons.check_circle : Icons.cancel_sharp,
              color: Colors.white,
            ),
          );
        });
    await Future.delayed(const Duration(seconds: 1)); // 1秒ごに処理を開始する
    Navigator.pop(context); // 元の画面に戻る
    if (_currentQuestionCount == _maxQuestions) {
      endGame(); // ゲームを終了
    } else {
      notifyListeners(); // 変更をクラスに通知
    }
  }

  // ゲームを終了させる関数
  Future<void> endGame() async {
    showDialog(
        context: context,
        builder: (BuildContext _context) {
          return AlertDialog(
            backgroundColor: Colors.blue,
            title: const Text(
              "End Game!",
              style: TextStyle(fontSize: 25, color: Colors.white),
            ),
            content: Text("Score: $_correctCount/$_maxQuestions"),
          );
        });
    await Future.delayed(const Duration(seconds: 3));
    Navigator.pop(context);
    Navigator.pop(context);
  }
}
