import 'package:flutter/material.dart';
import 'package:mineswiper/models/puzzle_state.dart';
import 'package:mineswiper/models/tile.dart';

abstract class PuzzleLayoutDelegate {
  const PuzzleLayoutDelegate();

  Widget startSectionBuilder(PuzzleState state);

  Widget endSectionBuilder(PuzzleState state);

  Widget backgroundBuilder(PuzzleState state);

  Widget boardBuilder(int size, List<Widget> tiles);

  Widget tileBuilder(Tile tile, PuzzleState state);

  Widget whitespaceTileBuilder(Tile tile, PuzzleState state);
}
