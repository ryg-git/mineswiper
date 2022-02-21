import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:mineswiper/colors/colors.dart';
import 'package:mineswiper/models/puzzle_state.dart';
import 'package:mineswiper/models/tile.dart';
import 'package:mineswiper/styles/text_styles.dart';

class MineOpenTile extends HookConsumerWidget {
  /// {@macro simple_puzzle_tile}
  const MineOpenTile({
    Key? key,
    required this.tile,
    required this.tileFontSize,
    required this.state,
  }) : super(key: key);

  /// The tile to be displayed.
  final Tile tile;

  /// The font size of the tile to be displayed.
  final double tileFontSize;

  /// The state of the puzzle.
  final PuzzleState state;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Center(
      child: tile.position.isMine
          ? Text(
              'M',
              style: PuzzleTextStyle.headline2.copyWith(
                fontSize: tileFontSize,
                color: PuzzleColors.black,
              ),
            )
          : Text(
              '${tile.position.mines}',
              style: PuzzleTextStyle.headline2.copyWith(
                fontSize: tileFontSize,
                color: PuzzleColors.white,
              ),
            ),
    );
  }
}