import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:mineswiper/colors/colors.dart';
import 'package:mineswiper/models/puzzle_state.dart';
import 'package:mineswiper/models/tile.dart';
import 'package:mineswiper/puzzle/providers/puzzle_pro.dart';
import 'package:mineswiper/styles/text_styles.dart';
import 'package:mineswiper/utils/theme.dart';

import 'dart:math' show pi, sin;

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

    final xController = useAnimationController(
      duration: Duration(
        milliseconds: 200,
      ),
    );

    final xtween = useAnimation(Tween<double>(
      begin: 0,
      end: pi,
    ).animate(xController));

    final ytween = useAnimation(
      Tween<double>(
        begin: 0,
        end: 1,
      ).animate(
        CurvedAnimation(parent: xController, curve: Curves.bounceOut),
      ),
    );

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
          );
        }
      } else {
        return const Text("");
      }
    }

    final panStart = useState<Offset?>(null);

    final xValue =
        ref.watch(keyXState("${tile.position.x}-${tile.position.y}"));
    final yValue =
        ref.watch(keyYState("${tile.position.x}-${tile.position.y}"));

    final bounceCurve = useState<bool>(false);

    final useKeyStrokeValue = useState(false);
    final keyStrokeX = useState(0);
    final keyStrokeY = useState(0);

    final keyStroke =
        ref.watch(keyStrokeStream("${tile.position.x}-${tile.position.y}"));

    keyStroke.whenData(
      (d) {
        if (d == "X1") {
          useKeyStrokeValue.value = true;
          keyStrokeX.value = 1;
          keyStrokeY.value = 0;
          xController.forward().then((value) {
            ref.read(puzzleProvider.notifier).moveTiles(tile, []);
          });
        } else if (d == "Y-1") {
          useKeyStrokeValue.value = true;
          keyStrokeX.value = 0;
          keyStrokeY.value = -1;
          xController.forward().then((value) {
            ref.read(puzzleProvider.notifier).moveTiles(tile, []);
          });
        } else if (d == "X-1") {
          useKeyStrokeValue.value = true;
          keyStrokeX.value = -1;
          keyStrokeY.value = 0;
          xController.forward().then((value) {
            ref.read(puzzleProvider.notifier).moveTiles(tile, []);
          });
        } else if (d == "Y1") {
          useKeyStrokeValue.value = true;
          keyStrokeX.value = 0;
          keyStrokeY.value = 1;
          xController.forward().then((value) {
            ref.read(puzzleProvider.notifier).moveTiles(tile, []);
          });
        } else {
          useKeyStrokeValue.value = false;
          bounceCurve.value = false;
        }
      },
    );

    return LayoutBuilder(
      builder: (context, constaints) {
        final puzzleSpacing = 25 / size;
        final totalDistH = (constaints.maxHeight + puzzleSpacing);
        final totalDistW = (constaints.maxWidth + puzzleSpacing);

        return GestureDetector(
          onPanUpdate: (details) {
            // final RenderBox box = context.findRenderObject() as RenderBox;

            bounceCurve.value = false;

            final dist = ref.read(puzzleProvider.notifier).WhiteSpaceDiff(tile);

            ref
                .read(
                    keyXState("${tile.position.x}-${tile.position.y}").notifier)
                .state = dist[0];
            ref
                .read(
                    keyYState("${tile.position.x}-${tile.position.y}").notifier)
                .state = dist[1];

            if (xValue == 1) {
              var oy = details.localPosition.dy - constaints.maxHeight;
              if (panStart.value != null) {
                oy = details.localPosition.dy - panStart.value!.dy;
              }

              if (oy > 0 && oy <= totalDistH) {
                final ratio = oy.abs() / totalDistH;
                if (ratio > 0.05) {
                  xController.value = oy / totalDistH;
                }
              } else if (oy > totalDistH) {
                ref.read(puzzleProvider.notifier).moveTiles(tile, []);
                xController.reverse();
              }
            } else if (xValue == -1) {
              var oy = details.localPosition.dy - constaints.maxHeight;
              if (panStart.value != null) {
                oy = details.localPosition.dy - panStart.value!.dy;
              }
              // print(oy);
              if (oy <= 0 && oy > -totalDistH) {
                final ratio = oy.abs() / totalDistH;
                if (ratio > 0.05) {
                  xController.value = ratio;
                }
              } else if (oy <= -totalDistH) {
                ref.read(puzzleProvider.notifier).moveTiles(tile, []);
                xController.reverse();
              }
            } else if (yValue == 1) {
              var oy = details.localPosition.dx - constaints.maxWidth;
              if (panStart.value != null) {
                oy = details.localPosition.dx - panStart.value!.dx;
              }

              if (oy > 0 && oy <= totalDistW) {
                final ratio = oy.abs() / totalDistW;
                if (ratio > 0.05) {
                  xController.value = ratio;
                }
              } else if (oy > totalDistW) {
                ref.read(puzzleProvider.notifier).moveTiles(tile, []);
                xController.reverse();
              }
            } else if (yValue == -1) {
              var oy = details.localPosition.dx - constaints.maxWidth;
              if (panStart.value != null) {
                oy = details.localPosition.dx - panStart.value!.dx;
              }

              if (oy <= 0 && oy > -totalDistW) {
                final ratio = oy.abs() / totalDistW;
                if (ratio > 0.05) {
                  xController.value = ratio;
                }
              } else if (oy <= -totalDistH) {
                ref.read(puzzleProvider.notifier).moveTiles(tile, []);
                // xController.reverse();
              }
            }
          },
          onPanStart: (details) {
            panStart.value = details.localPosition;
            bounceCurve.value = false;
          },
          onPanEnd: (details) {
            bounceCurve.value = true;
            if (xController.value > 0.4) {
              ref.read(puzzleProvider.notifier).moveTiles(tile, []);
            } else {
              xController.reverse();
            }
          },
          child: CustomPaint(
            painter: TilePainter(
              // x: xController.value,
              x: sin(xtween) / 3,
              color: PuzzleColors.primary0,
              y: bounceCurve.value
                  ? ytween * totalDistW
                  : xController.value * totalDistH,
              xValue: useKeyStrokeValue.value ? keyStrokeX.value : xValue,
              yValue: useKeyStrokeValue.value ? keyStrokeY.value : yValue,
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
                    ref
                        .read(keyXState("${tile.position.x}-${tile.position.y}")
                            .notifier)
                        .state = x;
                    ref
                        .read(keyYState("${tile.position.x}-${tile.position.y}")
                            .notifier)
                        .state = y;
                    bounceCurve.value = true;
                    if (b) {
                      xController.animateTo(0.05);
                    } else {
                      xController.reverse();
                    }
                  }
                },
                onPressed: () {
                  if (ref.read(puzzleProvider).whiteSpaceCreated) {
                    if (ref.read(puzzleProvider.notifier).isTileMovable(tile)) {
                      final dist = ref
                          .read(puzzleProvider.notifier)
                          .WhiteSpaceDiff(tile);

                      ref
                          .read(
                              keyXState("${tile.position.x}-${tile.position.y}")
                                  .notifier)
                          .state = dist[0];
                      ref
                          .read(
                              keyYState("${tile.position.x}-${tile.position.y}")
                                  .notifier)
                          .state = dist[1];
                      xController.forward().then((value) => ref
                          .read(puzzleProvider.notifier)
                          .moveTiles(tile, []));
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
  final double x;
  final Color color;
  final double y;
  final int xValue;
  final int yValue;

  TilePainter({
    this.x = 0,
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
        size.height * (1 + x) + y,
      );
      path.lineTo(size.width, size.height + y);
      // path.lineTo(size.width, 3 * size.height / 4);
      path.lineTo(size.width, 0 + y);
      path.lineTo(
        size.width / 2,
        size.height * x + y,
      );

      path.lineTo(0, y);
    } else if (xValue == -1) {
      path.lineTo(0, -y);
      path.lineTo(0, size.height - y);

      path.lineTo(
        size.width / 2,
        size.height - size.height * x - y,
      );
      path.lineTo(size.width, size.height - y);
      path.lineTo(size.width, -y);
      path.lineTo(size.width / 2, -x * size.height - y);
      path.lineTo(0, -y);
    } else if (yValue == 1) {
      path.lineTo(y, 0);
      path.lineTo(size.width * x + y, size.height / 2);
      path.lineTo(y, size.height);
      path.lineTo(size.width + y, size.height);
      path.lineTo(size.width + size.width * x + y, size.height / 2);
      path.lineTo(size.width + y, 0);
      path.lineTo(y, 0);
    } else if (yValue == -1) {
      path.lineTo(-y, 0);
      path.lineTo(-size.width * x - y, size.height / 2);
      path.lineTo(-y, size.height);
      path.lineTo(size.width - y, size.height);
      path.lineTo(size.width - size.width * x - y, size.height / 2);
      path.lineTo(size.width - y, 0);
      path.lineTo(-y, 0);
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
