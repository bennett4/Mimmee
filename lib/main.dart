import 'package:audioplayers/audio_cache.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'button.dart';

const sounds = [
  'hat.wav',
  'snare.wav',
  'perc.wav',
  'openhat.wav',
  'clap.wav',
  'kick.wav',
  '808.wav',
  '808alt.wav',
  '808alt2.wav',
];

const _backgroundColor = Colors.white;
const _buttonColor = Colors.black;
const _buttonPressedColor = Colors.purple;

void main() {
  WidgetsFlutterBinding.ensureInitialized(); 

  SystemChrome.setPreferredOrientations([ DeviceOrientation.portraitUp ])
    .then((_) {
      runApp(new MyApp());
    });
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: MyHomePage(),
    );
  }
}

class MyHomePage extends StatelessWidget {
  void playSound(String soundFileName) {
    AudioCache cache = new AudioCache();
    cache.play(soundFileName);
  }

  @override
  Widget build(BuildContext context) {
    var screenWidth = MediaQuery.of(context).size.width;
    var screenHeight = MediaQuery.of(context).size.height;
    var buttonSpacing = screenWidth / 19; // each spacing is 1/5 the width of a button
    var topBottomSpacing = (screenHeight - screenWidth) / 2;

    return Scaffold(
      backgroundColor: _backgroundColor,
      body: Center(
        child: GridView.count(
          padding: EdgeInsets.fromLTRB(buttonSpacing, topBottomSpacing, buttonSpacing, topBottomSpacing),
          crossAxisCount: 3,
          mainAxisSpacing: buttonSpacing,
          crossAxisSpacing: buttonSpacing,
          physics: new NeverScrollableScrollPhysics(),
          children: sounds.map<Widget>((String fileName) {
            return Button(
              buttonColor: _buttonColor,
              buttonPressedColor: _buttonPressedColor,
              soundFileName: fileName
            );
          }).toList(),
        ),
      ),
    );
  }
}
