import 'package:flutter/material.dart';
import 'package:mineswiper/models/puzzle_state.dart';
import 'package:mineswiper/models/tile.dart';
import 'package:mineswiper/puzzle/layout/puzzle_layout_delegate.dart';
import 'package:mineswiper/puzzle/layout/responsible_layout_builder.dart';
import 'package:mineswiper/puzzle/layout/responsive_gap.dart';
import 'package:mineswiper/puzzle/widgets/mine_open_tile.dart';
import 'package:mineswiper/puzzle/widgets/mine_puzzle_tile.dart';
import 'package:mineswiper/puzzle/widgets/mine_start_section.dart';
import 'package:mineswiper/puzzle/widgets/puzzle_board.dart';

abstract class _BoardSize {
  static double small = 312;
  static double medium = 424;
  static double large = 472;
}

abstract class _TileFontSize {
  static double small = 36;
  static double medium = 50;
  static double large = 54;
}

class MinePuzzleLayoutDelegate extends PuzzleLayoutDelegate {
  const MinePuzzleLayoutDelegate();

  @override
  Widget startSectionBuilder(PuzzleState state) {
    return ResponsiveLayoutBuilder(
      small: (_, child) => child!,
      medium: (_, child) => child!,
      large: (_, child) => Padding(
        padding: const EdgeInsets.only(left: 50, right: 32),
        child: child,
      ),
      child: (_) => MineStartSection(state: state),
    );
  }

  @override
  Widget endSectionBuilder(PuzzleState state) {
    return Column(
      children: [
        const ResponsiveGap(
          small: 32,
          medium: 48,
        ),
        ResponsiveLayoutBuilder(
          small: (_, child) => const Text("Shuffle"),
          medium: (_, child) => const Text("Shuffle"),
          large: (_, __) => const SizedBox(),
        ),
        const ResponsiveGap(
          small: 32,
          medium: 48,
        ),
      ],
    );
  }

  @override
  Widget backgroundBuilder(PuzzleState state) {
    return Positioned(
      right: 0,
      bottom: 0,
      child: ResponsiveLayoutBuilder(
        small: (_, __) => SizedBox(
          width: 184,
          height: 118,
        ),
        medium: (_, __) => SizedBox(
          width: 380.44,
          height: 214,
        ),
        large: (_, __) => Padding(
          padding: const EdgeInsets.only(bottom: 53),
          child: SizedBox(
            width: 570,
            height: 320,
          ),
        ),
      ),
    );
  }

  @override
  Widget boardBuilder(int size, List<Widget> tiles) {
    // final double multi = 5 / size;
    return Column(
      children: [
        const ResponsiveGap(
          small: 32,
          medium: 48,
          large: 96,
        ),
        Stack(
          alignment: Alignment.center,
          children: [
            ResponsiveLayoutBuilder(
            small: (_, __) => SizedBox.square(
              dimension: _BoardSize.small,
              child: PuzzleBoard(
                key: const Key('simple_puzzle_board_small'),
                size: size,
                tiles: tiles,
                spacing: 5,
              ),
            ),
            medium: (_, __) => SizedBox.square(
              dimension: _BoardSize.medium,
              child: PuzzleBoard(
                key: const Key('simple_puzzle_board_medium'),
                size: size,
                tiles: tiles,
              ),
            ),
            large: (_, __) => SizedBox.square(
              dimension: _BoardSize.large,
              child: PuzzleBoard(
                key: const Key('simple_puzzle_board_large'),
                size: size,
                tiles: tiles,
                  spacing: 30 / size,
              ),
            ),
          ),
          ],
        ),
        const ResponsiveGap(
          large: 96,
        ),
      ],
    );
  }

  @override
  Widget tileBuilder(Tile tile, PuzzleState state) {
    return ResponsiveLayoutBuilder(
      small: (_, __) => MinePuzzleTile(
        key: Key(
            'simple_puzzle_tile_${tile.position.x}_${tile.position.y}_small'),
        tile: tile,
        tileFontSize: _TileFontSize.small,
        state: state,
      ),
      medium: (_, __) => MinePuzzleTile(
        key: Key(
            'simple_puzzle_tile_${tile.position.x}_${tile.position.y}_medium'),
        tile: tile,
        tileFontSize: _TileFontSize.medium,
        state: state,
      ),
      large: (_, __) => MinePuzzleTile(
        key: Key(
            'simple_puzzle_tile_${tile.position.x}_${tile.position.y}_large'),
        tile: tile,
        tileFontSize: _TileFontSize.large,
        state: state,
      ),
    );
  }

  @override
  Widget whitespaceTileBuilder(Tile tile, PuzzleState state) {
    return ResponsiveLayoutBuilder(
      small: (_, __) => MineOpenTile(
        key: Key(
            'simple_puzzle_open_tile_${tile.position.x}_${tile.position.y}_small'),
        tile: tile,
        tileFontSize: _TileFontSize.small,
        state: state,
      ),
      medium: (_, __) => MineOpenTile(
        key: Key(
            'simple_puzzle_open_tile_${tile.position.x}_${tile.position.y}_medium'),
        tile: tile,
        tileFontSize: _TileFontSize.medium,
        state: state,
      ),
      large: (_, __) => MineOpenTile(
        key: Key(
            'simple_puzzle_open_tile_${tile.position.x}_${tile.position.y}_large'),
        tile: tile,
        tileFontSize: _TileFontSize.large,
        state: state,
      ),
    );
  }
}
