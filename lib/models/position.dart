// ignore: unused_import
import 'package:flutter/foundation.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'position.freezed.dart';

@freezed
class Position with _$Position {
  // ignore: unused_element
  const Position._();

  const factory Position({
    required int x,
    required int y,
    @Default(4) int mines,
    @Default(false) bool isMine,
    @Default(false) bool isFlagged,
    @Default(false) bool isVisited,
  }) = _Position;

  bool isNearTile(Position other) {
    if (x + 1 == other.x && y == other.y) {
      return true;
    } else if (x - 1 == other.x && y == other.y) {
      return true;
    } else if (y + 1 == other.y && x == other.x) {
      return true;
    } else if (y - 1 == other.y && x == other.x) {
      return true;
    }
    return false;
  }
}
