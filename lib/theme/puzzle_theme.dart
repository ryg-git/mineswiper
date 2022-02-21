import 'package:flutter/material.dart';

abstract class PuzzleTheme {
  const PuzzleTheme();

  String get name;

  bool get hasTimer;

  bool get hasCountdown;

  Color get backgroundColor;

  Color get defaultColor;

  Color get hoverColor;

  Color get pressedColor;
}
