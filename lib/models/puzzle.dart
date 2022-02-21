// ignore: unused_import
import 'dart:math';

import 'package:flutter/foundation.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

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
  }) = _Puzzle;

  Tile getWhitespaceTile() {
    return tiles.singleWhere((tile) => tile.isWhiteSpace);
  }

  bool isTileMovable(Tile tile) {
    final whitespaceTile = getWhitespaceTile();
    if (tile == whitespaceTile) {
      return false;
    }

    if (whitespaceTile.position.x != tile.position.x &&
        whitespaceTile.position.y != tile.position.y) {
      return false;
    }
    return true;
  }

  int getDimension() {
    return sqrt(tiles.length).toInt();
  }
}
