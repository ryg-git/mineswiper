import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
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
    // final borderRadius = useState<double>(10.0);
    // final margin = useState<double>(10.0);

    final xController = useAnimationController(
      duration: Duration(
        milliseconds: 200,
      ),
    );

    // final xtween = useAnimation(Tween<double>(
    //   begin: 0,
    //   end: 1,
    // ).animate(xController));

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

    final offset = useState<double>(0);
    final panStart = useState<Offset?>(null);
    final xValue = useState<int>(0);
    final yValue = useState<int>(0);

    return LayoutBuilder(
      builder: (context, constaints) {
        final fTween = Tween<double>(
          begin: 0,
          end: 1,
        );
        // final hTween = Tween<double>(
        //   begin: 0.5,
        //   end: -0.5,
        // );

        final puzzleSpacing = 25 / size;

        return GestureDetector(
          onPanUpdate: (details) {
            // final RenderBox box = context.findRenderObject() as RenderBox;

            // final dist = ref.read(puzzleProvider.notifier).WhiteSpaceDiff(tile);

            // final xvalue = dist[0];
            // final y = dist[1];

            // if (x) {}

            print("local y: ${details.localPosition.dy}");

            if (xValue.value == 1) {
              var oy = details.localPosition.dy - constaints.maxHeight;
              if (panStart.value != null) {
                oy = details.localPosition.dy - panStart.value!.dy;
              }

              if (oy > 0 && oy <= (constaints.maxHeight + puzzleSpacing)) {
                double ox = 0;

                if (oy < (constaints.maxHeight + puzzleSpacing) / 2) {
                  ox = oy / (constaints.maxHeight + puzzleSpacing);
                  if (ox > 0.1) xController.value = ox;
                } else {
                  ox = 1 - oy / (constaints.maxHeight + puzzleSpacing);
                  xController.value = ox;
                }

                offset.value = oy;
              } else if (oy > (constaints.maxHeight + puzzleSpacing)) {
                ref.read(puzzleProvider.notifier).moveTiles(tile, []);
                xController.reverse();
              }
            } else if (xValue.value == -1) {
              var oy = details.localPosition.dy - constaints.maxHeight;
              if (panStart.value != null) {
                oy = details.localPosition.dy - panStart.value!.dy;
              }
              print(oy);
              if (oy <= 0 && oy > -(constaints.maxHeight + puzzleSpacing)) {
                double ox = 0;

                if (oy.abs() < (constaints.maxHeight + puzzleSpacing) / 2) {
                  ox = oy.abs() / (constaints.maxHeight + puzzleSpacing);
                  if (ox > 0.1) xController.value = ox;
                } else {
                  ox = 1 - oy.abs() / (constaints.maxHeight + puzzleSpacing);
                  xController.value = ox;
                }

                offset.value = oy.abs();
              } else if (oy <= -(constaints.maxHeight + puzzleSpacing)) {
                ref.read(puzzleProvider.notifier).moveTiles(tile, []);
                xController.reverse();
              }
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
          onPanStart: (details) {
            panStart.value = details.localPosition;
          },
          onPanEnd: (details) {
            xController.reverse();
          },
          child: CustomPaint(
            painter: TilePainter(
              move: fTween.evaluate(xController),
              color: PuzzleColors.primary0,
              y: offset.value,
              xValue: xValue.value,
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
                  final dist =
                      ref.read(puzzleProvider.notifier).WhiteSpaceDiff(tile);

                  final x = dist[0];
                  final y = dist[1];

                  print("x: $x");
                  print("y: $y");

                  if (x.abs() + y.abs() == 1) {
                    xValue.value = x;
                    yValue.value = y;
                    if (b) {
                      xController.animateTo(0.1);
                    } else {
                      xController.reverse();
                    }
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
          ),
        );
      },
    );
  }
}

class TilePainter extends CustomPainter {
  final double move;
  final Color color;
  final double y;
  final int xValue;
  final int yValue;

  TilePainter({
    this.move = 0,
    this.color = Colors.white,
    this.y = 0,
    this.xValue = 1,
    this.yValue = 0,
  });
  @override
  void paint(Canvas canvas, Size size) {
    Path path = Path();

    if (xValue == 1) {
      path.lineTo(0, size.height + y);
      path.lineTo(
        size.width / 2,
        size.height * (1 + move) + y,
      );
      path.lineTo(size.width, size.height + y);
      // path.lineTo(size.width, 3 * size.height / 4);
      path.lineTo(size.width, 0 + y);
      path.lineTo(
        size.width / 2,
        size.height * move + y,
      );

      path.lineTo(0, y);
    } else if (xValue == -1) {
      path.lineTo(0, -y);
      path.lineTo(0, size.height - y);

      path.lineTo(
        size.width / 2,
        size.height - size.height * move - y,
      );
      path.lineTo(size.width, size.height - y);
      path.lineTo(size.width, -y);
      path.lineTo(size.width / 2, -move * size.height - y);
      path.lineTo(0, -y);
    } else {
      path.lineTo(0, size.height);
      path.lineTo(size.width, size.height);
      path.lineTo(size.width, 0);
    }

    final Paint paint = new Paint()..color = color;

    canvas.drawPath(path, paint);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) {
    return true;
  }
}

/*
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
*/