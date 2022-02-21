import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:mineswiper/colors/colors.dart';
import 'package:mineswiper/models/puzzle_state.dart';
import 'package:mineswiper/models/tile.dart';
import 'package:mineswiper/puzzle/providers/puzzle_pro.dart';
import 'package:mineswiper/styles/text_styles.dart';

class MinePuzzleTile extends HookConsumerWidget {
  /// {@macro simple_puzzle_tile}
  const MinePuzzleTile({
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
    return TextButton(
      style: TextButton.styleFrom(
        primary: PuzzleColors.white,
        textStyle: PuzzleTextStyle.headline2.copyWith(
          fontSize: tileFontSize,
        ),
        shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.all(
            Radius.circular(12),
          ),
        ),
      ).copyWith(
        foregroundColor: MaterialStateProperty.all(PuzzleColors.white),
        backgroundColor: MaterialStateProperty.resolveWith<Color?>(
          (states) {
            return PuzzleColors.primary0;
          },
        ),
      ),
      onPressed: () {
        if (ref.read(puzzleProvider).isTileMovable(tile)) {
          ref.read(puzzleProvider.notifier).moveTiles(tile, []);
        }
      },
      child: tile.position.isVisited
          ? tile.position.isMine
              ? Text(
                  'M',
                  style: TextStyle(
                    color: Colors.black,
                  ),
                )
              : Text(
                  '${tile.position.mines}',
                  style: TextStyle(
                    color: Colors.black,
                  ),
                )
          : const Text(''),
    );
  }
}
