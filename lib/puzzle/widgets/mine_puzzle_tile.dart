import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:mineswiper/colors/colors.dart';
import 'package:mineswiper/models/puzzle_state.dart';
import 'package:mineswiper/models/tile.dart';
import 'package:mineswiper/puzzle/providers/puzzle_pro.dart';
import 'package:mineswiper/styles/text_styles.dart';
import 'package:mineswiper/utils/theme.dart';

import "dart:math" show pi;

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

    final xController = useAnimationController(
      duration: Duration(
        milliseconds: 200,
      ),
    );

    final yController = useAnimationController(
      duration: Duration(
        milliseconds: 200,
      ),
    );

    final xtween = useAnimation(Tween<double>(
      begin: 0,
      end: 1,
    ).animate(xController));

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

    final offset = useState<Offset>(const Offset(0, 0));

    return GestureDetector(
      onPanUpdate: (details) {
        final RenderBox box = context.findRenderObject() as RenderBox;

        final puzzleSpacing = 25 / size;

        print(box.size);

        print("local y: ${details.localPosition.dy}");

        final oy = details.localPosition.dy - box.size.height;

        if (oy > 0 && oy <= (box.size.height + puzzleSpacing)) {
          double ox = 0;

          if (oy < (box.size.height + puzzleSpacing) / 2) {
            ox = oy / (box.size.height + puzzleSpacing);
            xController.animateTo(ox);
          } else {
            ox = 1 - oy / (box.size.height + puzzleSpacing);
            xController.animateTo(ox);
          }

          offset.value = Offset(0, oy);
        } else if (oy > (box.size.height + puzzleSpacing)) {
          ref.read(puzzleProvider.notifier).moveTiles(tile, []);
          xController.reverse();
        }

        // if (details.delta.dx > 0)
        //   print("Dragging in +X direction");
        // else
        //   print("Dragging in -X direction");

        // if (details.delta.dy > 0)
        //   print("Dragging in +Y direction");
        // else
        //   print("Dragging in -Y direction");
      },
      child: CustomPaint(
        painter: TilePainter(
          move: xtween,
          color: PuzzleColors.primary0,
          offset: offset.value,
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
              foregroundColor: MaterialStateProperty.all(PuzzleColors.tileText),
              // backgroundColor: MaterialStateProperty.resolveWith<Color?>(
              //   (states) {
              //     return PuzzleColors.primary0;
              //   },
              // ),
            ),
            onHover: (b) {
              if (b) {
                // borderRadius.value = borderRadius.value * 15;
                // xController.animateTo(0.2);
              } else {
                // borderRadius.value = borderRadius.value / 15;
                // xController.reverse();
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
                ref.read(puzzleProvider.notifier).createWhiteSpace(tile, size);
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
      ),
    );
  }
}

class TilePainter extends CustomPainter {
  final double move;
  final Color color;
  final Offset offset;

  TilePainter({
    this.move = 0,
    this.color = Colors.white,
    this.offset = const Offset(0, 0),
  });
  @override
  void paint(Canvas canvas, Size size) {
    Path path = Path();
    path.lineTo(0, size.height + offset.dy);
    // path.lineTo(0, 3 * size.height / 4);
    // path.lineTo(size.width / 2, size.height);
    path.lineTo(
      size.width / 2,
      size.height * (1 + move) + offset.dy,
    );
    path.lineTo(size.width, size.height + offset.dy);
    // path.lineTo(size.width, 3 * size.height / 4);
    path.lineTo(size.width, 0 + offset.dy);
    path.lineTo(
      size.width / 2,
      size.height * move + offset.dy,
    );

    path.lineTo(0, offset.dy);
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
