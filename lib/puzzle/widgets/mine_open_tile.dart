import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:mineswiper/colors/colors.dart';
import 'package:mineswiper/models/puzzle_state.dart';
import 'package:mineswiper/models/tile.dart';
import 'package:mineswiper/puzzle/providers/puzzle_pro.dart';
import 'package:mineswiper/styles/text_styles.dart';
import 'dart:math' show pi, sin;

import 'package:mineswiper/utils/theme.dart';

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

    final changeIcon = useState(false);

    Widget getLetter() {
      if (tile.position.isFlagged) {
        if (tile.position.isMine) {
          Future.delayed(
            Duration(milliseconds: 500),
            () => changeIcon.value = true,
          );
          return AnimatedSwitcher(
            transitionBuilder: (child, animation) {
              return ScaleTransition(
                scale: animation,
                child: child,
              );
            },
            duration: Duration(milliseconds: 500),
            child: changeIcon.value
                ? Text(
                    "0",
                    style: TextStyle(
                      color: PuzzleColors.white,
                      fontFamily: "FredokaOne",
                      fontSize: tileFontSize * 5 / size,
                    ),
                  )
                : Icon(
                    Icons.check_circle,
                    color: PuzzleColors.green,
                  ),
          );
        } else {
          Future.delayed(
            Duration(milliseconds: 500),
            () => changeIcon.value = true,
          );
          return AnimatedSwitcher(
            transitionBuilder: (child, animation) {
              return ScaleTransition(
                scale: animation,
                child: child,
              );
            },
            duration: Duration(milliseconds: 500),
            child: changeIcon.value
                ? Text(
                    '${tile.position.mines}',
                    style: PuzzleTextStyle.headline2.copyWith(
                      fontSize: tileFontSize * 5 / size,
                      fontFamily: "FredokaOne",
                      color: Colors.red,
                    ),
                    textAlign: TextAlign.center,
                  )
                : Icon(
                    Icons.close,
                    color: Colors.red,
                  ),
          );
        }
      } else if (tile.position.isMine) {
        Future.delayed(
          Duration(milliseconds: 500),
          () => changeIcon.value = true,
        );
        return AnimatedSwitcher(
          transitionBuilder: (child, animation) {
            return ScaleTransition(
              scale: animation,
              child: child,
            );
          },
          duration: Duration(milliseconds: 500),
          child: changeIcon.value
              ? Image(
                  image: AssetImage('assets/images/mine.png'),
                  fit: BoxFit.fitHeight,
                  height: 30,
                  color: Colors.red,
                )
              : Icon(
                  Icons.close,
                  color: Colors.red,
                ),
        );
      } else {
        return Align(
          alignment: Alignment.center,
          child: Text(
            '${tile.position.mines}',
            style: PuzzleTextStyle.headline2.copyWith(
              fontSize: tileFontSize * 5 / size,
              color: context.theme.primaryColor,
              fontFamily: "FredokaOne",
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
