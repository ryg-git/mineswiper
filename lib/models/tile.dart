// ignore: unused_import
import 'package:flutter/foundation.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

import 'position.dart';

part 'tile.freezed.dart';

@freezed
class Tile with _$Tile {
  const factory Tile({
    required Position position,
    @Default(false) bool isWhiteSpace,
  }) = _Tile;
}
