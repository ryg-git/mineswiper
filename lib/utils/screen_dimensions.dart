import 'package:flutter/material.dart';

extension ScreenDimensions on BuildContext {
  Size get screensize => MediaQuery.of(this).size;
}
