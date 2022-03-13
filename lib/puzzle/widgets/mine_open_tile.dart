import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:mineswiper/colors/colors.dart';
import 'package:mineswiper/models/puzzle_state.dart';
import 'package:mineswiper/models/tile.dart';
import 'package:mineswiper/puzzle/providers/puzzle_pro.dart';
import 'package:mineswiper/styles/text_styles.dart';
import 'dart:math' show pi, sin;

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
    final size = ref.read(puzzleSizeProvider);

    final xController = useAnimationController(
      duration: Duration(
        milliseconds: 400,
      ),
    );
    final xtween = useAnimation(
      SinTween(
        begin: 0,
        end: 4 * pi,
      ).animate(
        CurvedAnimation(
          parent: xController,
          curve: Curves.bounceInOut,
        ),
      ),
    );

    final instruction =
        ref.watch(instructionStream("${tile.position.x}-${tile.position.y}"));

    instruction.whenData(
      (d) {
        if (d == "NoHint") {
          xController.forward().then((value) {
            xController.reset();
            ref
                .read(instructionState("${tile.position.x}-${tile.position.y}")
                    .notifier)
                .state = "";
          });
        }
      },
    );

    Widget getLetter() {
      if (tile.position.isMine) {
        return Text(
          'M',
          style: PuzzleTextStyle.headline2.copyWith(
            fontSize: tileFontSize * 2 / size,
            color: PuzzleColors.white,
          ),
        );
      } else if (tile.position.isFlagged) {
        return Text(
          '${tile.position.mines}',
          style: PuzzleTextStyle.headline2.copyWith(
            fontSize: tileFontSize * 2 / size,
            color: PuzzleColors.white,
          ),
        );
      } else {
        return Align(
          alignment: Alignment.center,
          child: Text(
            '${tile.position.mines}',
            style: PuzzleTextStyle.headline2.copyWith(
              fontSize: tileFontSize * 2 / size,
              color: PuzzleColors.white,
            ),
            textAlign: TextAlign.center,
          ),
        );
      }
    }

    return TextButton(
      onPressed: () {
        ref.read(puzzleProvider.notifier).autoFlagTile(tile);
      },
      style: TextButton.styleFrom(
        splashFactory: NoSplash.splashFactory,
      ),
      child: Transform.rotate(
        angle: xtween,
        child: getLetter(),
      ),
    );
  }
}

class SinTween extends Tween<double> {
  SinTween({
    required double begin,
    required double end,
  }) : super(begin: begin, end: end);

  @override
  double lerp(double t) {
    return pi * sin(super.lerp(t)) / 4;
  }
}
