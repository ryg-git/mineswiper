import 'dart:ui';

import 'package:mineswiper/colors/colors.dart';
import 'package:mineswiper/theme/puzzle_theme.dart';

class SimpleTheme extends PuzzleTheme {
  /// {@macro simple_theme}
  const SimpleTheme() : super();

  @override
  String get name => 'MineSwiper';

  @override
  bool get hasTimer => false;

  @override
  bool get hasCountdown => false;

  @override
  Color get backgroundColor => PuzzleColors.white;

  @override
  Color get defaultColor => PuzzleColors.primary5;

  @override
  Color get hoverColor => PuzzleColors.primary3;

  @override
  Color get pressedColor => PuzzleColors.primary7;
}
