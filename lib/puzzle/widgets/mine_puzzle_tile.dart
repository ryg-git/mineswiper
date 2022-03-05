import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:mineswiper/colors/colors.dart';
import 'package:mineswiper/models/puzzle_state.dart';
import 'package:mineswiper/models/tile.dart';
import 'package:mineswiper/puzzle/providers/puzzle_pro.dart';
import 'package:mineswiper/styles/text_styles.dart';
import 'package:mineswiper/utils/theme.dart';

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
    final size = ref.read(puzzleSizeProvider);
    Widget getLetter() {
      if (tile.position.isFlagged) {
        return Text(
          'F',
          style: TextStyle(
            color: context.theme.primaryColor,
          ),
        );
      } else if (tile.position.isVisited) {
        if (tile.position.isMine) {
          return Text(
            'M',
            style: TextStyle(
              color: context.theme.primaryColor,
            ),
          );
        } else {
          return Text(
            '${tile.position.mines}',
            style: TextStyle(
              color: context.theme.primaryColor,
            ),
          );
        }
      } else {
        return const Text("");
      }
    }

    return TextButton(
      style: TextButton.styleFrom(
        primary: PuzzleColors.white,
        textStyle: PuzzleTextStyle.headline2.copyWith(
          fontSize: tileFontSize * 3 / size,
        ),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.all(
            Radius.circular(36 / size),
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
        if (ref.read(puzzleProvider).whiteSpaceCreated) {
          if (ref.read(puzzleProvider.notifier).isTileMovable(tile)) {
            ref.read(puzzleProvider.notifier).moveTiles(tile, []);
          } else if (tile.position.isVisited) {
            ref.read(puzzleProvider.notifier).moveWhiteSpace(tile);
          }
        } else {
          ref.read(puzzleProvider.notifier).createWhiteSpace(tile, size);
        }
      },
      onLongPress: () {
        if (ref.read(puzzleProvider).whiteSpaceCreated) {
          ref.read(puzzleProvider.notifier).flagTile(tile);
        }
      },
      child: getLetter(),
    );
  }
}
