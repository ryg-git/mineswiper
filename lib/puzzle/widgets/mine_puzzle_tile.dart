import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:mineswiper/colors/colors.dart';
import 'package:mineswiper/models/puzzle_state.dart';
import 'package:mineswiper/models/tile.dart';
import 'package:mineswiper/puzzle/providers/puzzle_pro.dart';
import 'package:mineswiper/styles/text_styles.dart';
import 'package:mineswiper/utils/theme.dart';

import "dart:math" show pi, cos, tan;

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
    final borderRadius = useState<double>(10.0);
    // final margin = useState<double>(10.0);

    final aController = useAnimationController(
      duration: Duration(
        milliseconds: 200,
      ),
      upperBound: 0.03,
      lowerBound: 0,
    );

    Color color = Colors.white;

    const _duration = Duration(
      milliseconds: 200,
    );

    final dTween = Tween<double>(
      begin: 0,
      end: pi / 12,
    ).animate(aController);

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
            // style: TextStyle(
            //   color: context.theme.primaryColor,
            // ),
          );
        }
      } else {
        return const Text("");
      }
    }

    return AnimatedBuilder(
        animation: dTween,
        builder: (context, child) {
          return CustomPaint(
            painter: TilePainter(
              move: dTween.value,
              color: PuzzleColors.primary0,
            ),
            child: Container(
              // color: PuzzleColors.primary0,
              child: TextButton(
                style: TextButton.styleFrom(
                  // primary: PuzzleColors.white,
                  textStyle: PuzzleTextStyle.headline2.copyWith(
                    fontSize: tileFontSize * 3 / size,
                  ),
                ).copyWith(
                  foregroundColor:
                      MaterialStateProperty.all(PuzzleColors.tileText),
                  // backgroundColor: MaterialStateProperty.resolveWith<Color?>(
                  //   (states) {
                  //     return PuzzleColors.primary0;
                  //   },
                  // ),
                ),
                onHover: (b) {
                  if (b) {
                    // borderRadius.value = borderRadius.value * 15;
                    aController.forward();
                  } else {
                    // borderRadius.value = borderRadius.value / 15;
                    aController.reverse();
                  }
                },
                onPressed: () {
                  if (ref.read(puzzleProvider).whiteSpaceCreated) {
                    if (ref.read(puzzleProvider.notifier).isTileMovable(tile)) {
                      ref.read(puzzleProvider.notifier).moveTiles(tile, []);
                    } else if (tile.position.isVisited) {
                      ref.read(puzzleProvider.notifier).moveWhiteSpace(tile);
                    }
                  } else {
                    ref
                        .read(puzzleProvider.notifier)
                        .createWhiteSpace(tile, size);
                  }
                },
                onLongPress: () {
                  if (ref.read(puzzleProvider).whiteSpaceCreated) {
                    ref.read(puzzleProvider.notifier).flagTile(tile);
                  }
                },
                child: getLetter(),
              ),
            ),
          );
        });
  }
}

class TilePainter extends CustomPainter {
  double move = 0;
  Color color;
  TilePainter({
    this.move = 0,
    this.color = Colors.white,
  });
  @override
  void paint(Canvas canvas, Size size) {
    Path path = Path();
    path.lineTo(0, size.height);
    // path.lineTo(0, 3 * size.height / 4);
    // path.lineTo(size.width / 2, size.height);
    path.lineTo(
      size.width / 2,
      size.height * (1 + ((size.width / 2) * tan(move))),
    );
    path.lineTo(size.width, size.height);
    // path.lineTo(size.width, 3 * size.height / 4);
    path.lineTo(size.width, 0);
    path.lineTo(
      size.width / 2,
      size.height * ((size.width / 2) * tan(move)),
    );
    // path.lineTo(size.width / 2, size.height / 4);
    // path.quadraticBezierTo(0, size.height * 0.8, 0.1 * size.width, size.height);
    // path.lineTo(size.width * 0.4, size.height * 1.4);
    // path.quadraticBezierTo(size.width * 0.4, size.height * 1.4,
    //     size.width * 0.6, size.height * 1.4);
    // path.arcTo(
    //   Rect.fromCenter(
    //     center: Offset(size.width * 0.5, size.height * 1.4),
    //     width: size.height * 0.2,
    //     height: size.height * 0.2,
    //   ),
    //   0.0,
    //   pi / 2,
    //   true,
    // );

    // path.lineTo(0.9, size.height);
    // path.quadraticBezierTo(
    //   0.9 * size.width,
    //   size.height,
    //   size.width,
    //   size.height * 0.8,
    // );

    // path.lineTo(0.9, size.height);
    // path.quadraticBezierTo(size.width * 0.4, size.height * 1.4,
    //     size.width * 0.6, size.height * 1.4);

    // path.lineTo(size.width, 0);
    // final Rect colorBounds = Rect.fromLTRB(0, 0, size.width, size.height);

    final Paint paint = new Paint()..color = color;

    canvas.drawPath(path, paint);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) {
    return true;
  }
}
