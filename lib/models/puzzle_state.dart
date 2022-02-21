// ignore: unused_import
import 'package:flutter/foundation.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:mineswiper/models/puzzle.dart';
import 'package:mineswiper/models/tile.dart';

part 'puzzle_state.freezed.dart';

enum PuzzleStatus { incomplete, complete }

enum TileMovementStatus { nothingTapped, cannotBeMoved, moved, flagged }

@freezed
class PuzzleState with _$PuzzleState {
  const factory PuzzleState({
    required Puzzle puzzle,
    @Default(0) int remainingMines,
    @Default(0) int numberOfMoves,
    Tile? lastTappedTile,
    @Default(PuzzleStatus.incomplete) PuzzleStatus puzzleStatus,
    @Default(TileMovementStatus.nothingTapped)
        TileMovementStatus tileMovementStatus,
  }) = _PuzzleState;
}
