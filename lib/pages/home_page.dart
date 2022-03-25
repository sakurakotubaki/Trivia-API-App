import 'package:flutter/material.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  double? _deviceHeight, _deviceWidth;

  double _currentDifficultyLevel = 0; // 難易度を設定

  @override
  Widget build(BuildContext context) {
    _deviceHeight = MediaQuery.of(context).size.height;
    _deviceWidth = MediaQuery.of(context).size.width;
    return Scaffold(
      body: SafeArea(
          child: Container(
        padding: EdgeInsets.symmetric(horizontal: _deviceWidth! * 0.10),
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisSize: MainAxisSize.max,
            children: [
              _appTitle(),
              _difficultySlider(),
            ],
          ),
        ),
      )),
    );
  }

  Widget _appTitle() {
    return Column(
      children: [
        const Text(
          "Frivia",
          style: TextStyle(
              color: Colors.white, fontSize: 50, fontWeight: FontWeight.w500),
        )
      ],
    );
  }

  Widget _difficultySlider() {
    return Slider(
        value: _currentDifficultyLevel,
        onChanged: (_value) {
          // setStateで更新する。しないとスライダー動かない!
          setState(() {
            _currentDifficultyLevel = _value;
          });
        });
  }
}
