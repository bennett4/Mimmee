import 'dart:async';
import 'package:audioplayers/audio_cache.dart';
import 'package:flutter/material.dart';

class Button extends StatefulWidget {
  Button({
    Key key,
    this.soundFileName,
    this.buttonColor,
    this.buttonPressedColor
  }) : super(key: key);

  final String soundFileName;
  final Color buttonColor;
  final Color buttonPressedColor;

  @override
  _MyButtonState createState() => _MyButtonState(
    this.soundFileName,
    this.buttonColor,
    this.buttonPressedColor,
  );
}

class _MyButtonState extends State<Button> {
  String fileName;
  Color buttonColor;
  Color buttonPressedColor;
  bool _looping = false;
  double _msInterval = 1000;

  @override
  _MyButtonState(String name, Color bc, Color bpc){
    fileName = name;
    buttonColor = bc;
    buttonPressedColor = bpc;
  }

  void playSound() {
    AudioCache cache = new AudioCache();
    cache.play(fileName);
  }

  void onPress() {
    if (_looping == true) {
      setState(() {
        _looping = false;
      });
    } else {
      playSound();
    }
  }

  void onLongPress() {
    if (_looping == false) {
      setState(() {
        _looping = true;
      });
      Timer.periodic(new Duration(milliseconds: _msInterval.toInt()), (timer) {
        if (_looping == false) {
          timer.cancel();
        } else {
          playSound();
        }
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: _looping ? buttonPressedColor : buttonColor,
      ),
      child: Material(
        color: Colors.transparent,
        child: InkWell(
          splashColor: buttonPressedColor,
          onTap: () => onPress(),
          onLongPress: () => onLongPress(),
        ),
      ),
    );
  }
}
