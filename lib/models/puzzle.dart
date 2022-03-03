// ignore: unused_import
import 'dart:math';

import 'package:flutter/foundation.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:mineswiper/models/position.dart';

import 'tile.dart';

part 'puzzle.freezed.dart';

@freezed
class Puzzle with _$Puzzle {
  const Puzzle._();
  const factory Puzzle({
    required List<Tile> tiles,
    @Default(0) int rowSize,
    @Default(0) int colSize,
    @Default(false) bool whiteSpaceCreated,
    @Default(false) bool solved,
    @Default(false) bool failed,
    @Default(0) int reset,
  }) = _Puzzle;

  int getDimension() {
    return sqrt(tiles.length).toInt();
  }

  Tile getWhitespaceTile() {
    return tiles.singleWhere(
      (tile) => tile.isWhiteSpace,
      orElse: () => Tile(
        position: Position(
          x: 20,
          y: 20,
        ),
      ),
    );
  }
}
