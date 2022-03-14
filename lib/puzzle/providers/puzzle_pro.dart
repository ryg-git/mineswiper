import 'dart:async';
import 'dart:math';

import 'package:flutter/services.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:mineswiper/models/position.dart';
import 'package:mineswiper/models/puzzle.dart';
import 'package:mineswiper/models/puzzle_state.dart';
import 'package:mineswiper/models/tile.dart';
import 'package:mineswiper/puzzle/layout/mine_puzzle_layout_delegate.dart';

final puzzleSizeProvider = StateProvider<int>((ref) => 5);

final mineCountProvider = StateProvider<int>((ref) => 0);

final hintCountProvider = StateProvider<int>((ref) => 0);
final puzzleStartTimeProvider = StateProvider<int>((ref) => 0);
final puzzleEndTimeProvider = StateProvider<int>((ref) => 0);
final puzzleSecondsProvider = StateProvider<int>((ref) => 0);

final timerProvider = StreamProvider.autoDispose<int>(
  (ref) {
    final stop = ref.watch(
      puzzleProvider.select(
        (value) => value.whiteSpaceCreated && !value.failed && !value.solved,
      ),
    );

    var seconds = ref.read(puzzleSecondsProvider);

    return stop
        ? Stream.periodic(
            const Duration(seconds: 1),
            (i) {
              if (ref.read(mineCountProvider) == 0) {
                return seconds;
              }
              ref.read(puzzleSecondsProvider.notifier).state = ++seconds;
              return seconds;
            },
          )
        : Stream.empty();
  },
);

final remainingProvider = StateProvider<int>((ref) => -1);

final oddEvenProvider = StateProvider<bool>((ref) => random.nextBool());

final random = Random();

final positionTileProvider =
    StateProvider.autoDispose.family<Tile, String>((ref, pos) {
  return Tile(
    position: Position(
      x: -1,
      y: -1,
    ),
  );
});

final puzzleStateProvider = StateProvider<PuzzleState>((ref) {
  final puzzle = ref.watch(puzzleProvider);
  return PuzzleState(
    puzzle: puzzle,
  );
});

final puzzleLayoutProvider = StateProvider<MinePuzzleLayoutDelegate>((ref) {
  return MinePuzzleLayoutDelegate();
});

final puzzleStreamProvider = StateProvider<MinePuzzleLayoutDelegate>((ref) {
  return MinePuzzleLayoutDelegate();
});

final puzzleProvider = StateNotifierProvider<PuzzleNotifier, Puzzle>((ref) {
  final puzzleSize = ref.watch(puzzleSizeProvider);

  return PuzzleNotifier(read: ref.read)..createPuzzle(puzzleSize);
});

final keyXState = StateProvider.family<int, String>((ref, id) => 0);

final keyYState = StateProvider.family<int, String>((ref, id) => 0);

final keyStrokeState = StateProvider.family<int, String>((ref, id) => 0);

final keyStrokeStream =
    StreamProvider.autoDispose.family<String, String>((ref, id) async* {
  final a = ref.watch(keyStrokeState(id));
  if (a == 3) {
    yield "X1";
  } else if (a == 4) {
    yield "Y-1";
  } else if (a == 2) {
    yield "Y1";
  } else if (a == 1) {
    yield "X-1";
  }
});

final beginCoolDown = StateProvider((ref) {
  return false;
});

final coolDownTime = StreamProvider((ref) {
  final coolDown = ref.watch(beginCoolDown);

  var milli = 0;

  return milli < 51 && coolDown
      ? Stream.periodic(Duration(milliseconds: 100), (_) {
          if (milli > 49) ref.read(beginCoolDown.notifier).state = false;
          return milli++;
        }).take(51)
      : Stream.empty();
});

final instructionState = StateProvider.family<String, String>((ref, id) => "");

final instructionStream =
    StreamProvider.autoDispose.family<String, String>((ref, id) async* {
  final a = ref.watch(instructionState(id));
  yield a;
});

class PuzzleNotifier extends StateNotifier<Puzzle> {
  final Random random = Random();

  final Reader read;

  PuzzleNotifier({required this.read}) : super(Puzzle(tiles: []));

  Tile getWhitespaceTile() {
    return state.tiles.singleWhere(
      (tile) => tile.isWhiteSpace,
      orElse: () => Tile(
        position: Position(
          x: 20,
          y: 20,
        ),
      ),
    );
  }

  List<int> WhiteSpaceDiff(Tile tile) {
    final whiteSpaceTile = getWhitespaceTile();

    return [
      whiteSpaceTile.position.x - tile.position.x,
      whiteSpaceTile.position.y - tile.position.y,
    ];
  }

  bool isTileMovable(Tile tile) {
    if (state.whiteSpaceCreated) {
      final whitespaceTile = getWhitespaceTile();
      return whitespaceTile.position.isNearTile(tile.position);
    } else {
      return false;
    }
  }

  void createWhiteSpace(Tile tile, int size) {
    final mineNumber = (size * size) * 4 ~/ 10;
    final oddOrEven = random.nextBool();

    final correctPositions = <Position>[];

    for (var x = 0; x < size; x++) {
      for (var y = 0; y < size; y++) {
        correctPositions.add(
          Position(
            x: x,
            y: y,
          ),
        );
      }
    }

    final _allMines = correctPositions
        .where(
          (element) => oddOrEven
              ? (element.x + element.y).isEven
              : (element.x + element.y).isOdd,
        )
        .toList()
      ..shuffle();

    final _allPossibleMines = _allMines.where(
      (el) =>
          (el.x != tile.position.x && el.y != tile.position.y) &&
          !tile.position.isNearTile(el),
    );
    final mines = _allPossibleMines.take(mineNumber).toList();

    final minesTiles = correctPositions.map(
      (e) {
        if (mines.contains(e)) {
          final nearMines = mines.fold<int>(
            0,
            (previousValue, element) =>
                e.isNearTile(element) ? previousValue + 1 : previousValue,
          );
          return e.copyWith(
            isMine: true,
            mines: nearMines,
          );
        } else {
          final nearMines = mines.fold<int>(
            0,
            (previousValue, element) =>
                e.isNearTile(element) ? previousValue + 1 : previousValue,
          );
          return e.copyWith(mines: nearMines);
        }
      },
    ).toList();

    final tiles = _getMineAndTiles(minesTiles, tile);

    read(positionTileProvider(
      "${tile.position.x}-${tile.position.y}",
    ).notifier)
        .state = tile.copyWith(
      isWhiteSpace: true,
      position: tile.position.copyWith(
        isVisited: true,
      ),
    );

    read(remainingProvider.notifier).state--;

    read(mineCountProvider.notifier).state = mines.length;

    read(puzzleStartTimeProvider.notifier).state =
        DateTime.now().millisecondsSinceEpoch;

    state = Puzzle(
      tiles: tiles,
      rowSize: size,
      colSize: size,
      solved: false,
      whiteSpaceCreated: true,
    );
  }

  void flagTile(Tile tile) {
    state = state.copyWith(
      tiles: state.tiles.map((e) {
        if (e.compareOnlyPosition(tile)) {
          read(positionTileProvider(
            "${tile.position.x}-${tile.position.y}",
          ).notifier)
              .state = tile.copyWith(
            position: e.position.copyWith(
              isFlagged: !e.position.isFlagged,
            ),
          );
          return e.copyWith(
            position: e.position.copyWith(
              isFlagged: !e.position.isFlagged,
            ),
          );
        } else {
          return e;
        }
      }).toList(),
    );
  }

  void autoFlagTile(Tile tile) {
    final unFlaggedTiles = state.tiles.fold<List<int>>(
      [0, 0],
      (previousValue, element) {
        if (tile.position.isNearTile(element.position)) {
          return !element.position.isFlagged && element.position.isVisited
              ? [++previousValue[0], ++previousValue[1]]
              : [++previousValue[0], previousValue[1]];
        } else {
          return previousValue;
        }
      },
    );

    final totalNear = unFlaggedTiles[0];
    final unflaggedNear = totalNear - unFlaggedTiles[1];

    if (unflaggedNear == tile.position.mines && tile.isWhiteSpace) {
      state = state.copyWith(
        tiles: state.tiles.map((e) {
          if (tile.position.isNearTile(e.position) && !e.position.isVisited) {
            read(positionTileProvider(
              "${e.position.x}-${e.position.y}",
            ).notifier)
                .state = e.copyWith(
              position: e.position.copyWith(
                isFlagged: true,
              ),
            );
            return e.copyWith(
              position: e.position.copyWith(
                isFlagged: true,
              ),
            );
          } else {
            return e;
          }
        }).toList(),
      );
    }
  }

  void handleKeyEvent(RawKeyEvent event) async {
    try {
      final whitespaceTile = getWhitespaceTile();
      if (event.logicalKey == LogicalKeyboardKey.keyF) {
        autoFlagTile(whitespaceTile);
      } else if (event.logicalKey == LogicalKeyboardKey.keyH) {
        showHint();
      } else if (event.logicalKey == LogicalKeyboardKey.keyW) {
        final t =
            state.tiles.firstWhere((element) => whitespaceTile.onTop(element));
        flagTile(t);
      } else if (event.logicalKey == LogicalKeyboardKey.keyA) {
        final t =
            state.tiles.firstWhere((element) => whitespaceTile.onLeft(element));
        flagTile(t);
      } else if (event.logicalKey == LogicalKeyboardKey.keyS) {
        final t = state.tiles
            .firstWhere((element) => whitespaceTile.onBottom(element));
        flagTile(t);
      } else if (event.logicalKey == LogicalKeyboardKey.keyD) {
        final t = state.tiles
            .firstWhere((element) => whitespaceTile.onRight(element));
        flagTile(t);
      } else if (event.data.logicalKey.keyLabel == "Arrow Left") {
        final t =
            state.tiles.firstWhere((element) => element.onLeft(whitespaceTile));
        read(keyStrokeState("${t.position.x}-${t.position.y}").notifier).state =
            4;
      } else if (event.data.logicalKey.keyLabel == "Arrow Right") {
        final t = state.tiles
            .firstWhere((element) => element.onRight(whitespaceTile));

        read(keyStrokeState("${t.position.x}-${t.position.y}").notifier).state =
            2;
      } else if (event.data.logicalKey.keyLabel == "Arrow Up") {
        final t =
            state.tiles.firstWhere((element) => element.onTop(whitespaceTile));

        read(keyStrokeState("${t.position.x}-${t.position.y}").notifier).state =
            1;
      } else if (event.data.logicalKey.keyLabel == "Arrow Down") {
        final t = state.tiles
            .firstWhere((element) => element.onBottom(whitespaceTile));

        read(keyStrokeState("${t.position.x}-${t.position.y}").notifier).state =
            3;
      }
    } catch (e) {
      print("Error: $e");
    }
  }

  void showHint() {
    if (!read(beginCoolDown)) {
      final whitespaceTile = getWhitespaceTile();
      final List<Tile> mines = state.tiles
          .where(
            (element) =>
                whitespaceTile.position.isNearTile(element.position) &&
                !element.position.showHint &&
                element.position.isMine,
          )
          .toList();

      final len = mines.length;

      if (len > 0) {
        final mineInd = random.nextInt(len);

        final t = mines[mineInd];

        state = state.copyWith(
          tiles: state.tiles.map(
            (e) {
              if (e.compareOnlyPosition(t)) {
                return e.copyWith(
                  position: e.position.copyWith(
                    showHint: true,
                  ),
                );
              }
              return e;
            },
          ).toList(),
        );
        read(positionTileProvider(
          "${t.position.x}-${t.position.y}",
        ).notifier)
            .state = t.copyWith(
          position: t.position.copyWith(
            showHint: true,
          ),
        );
        read(hintCountProvider.notifier).state++;
      } else {
        read(instructionState(
                    "${whitespaceTile.position.x}-${whitespaceTile.position.y}")
                .notifier)
            .state = "NoHint";
      }
      read(beginCoolDown.notifier).state = true;
    }
  }

  void moveWhiteSpace(Tile tile) {
    final whitespaceTile = getWhitespaceTile();

    state = state.copyWith(
      tiles: state.tiles.map(
        (e) {
          if (whitespaceTile.compareOnlyPosition(e)) {
            return e.copyWith(isWhiteSpace: false);
          } else if (tile.compareOnlyPosition(e)) {
            return e.copyWith(isWhiteSpace: true);
          }

          return e;
        },
      ).toList(),
    );
    read(positionTileProvider(
      "${tile.position.x}-${tile.position.y}",
    ).notifier)
        .state = tile.copyWith(
      isWhiteSpace: true,
    );
    read(positionTileProvider(
      "${whitespaceTile.position.x}-${whitespaceTile.position.y}",
    ).notifier)
        .state = whitespaceTile.copyWith(
      isWhiteSpace: false,
    );
  }

  void moveTiles(Tile tile, List<Tile> tilesToSwap) {
    final whitespaceTile = getWhitespaceTile();

    final deltaX = whitespaceTile.position.x - tile.position.x;
    final deltaY = whitespaceTile.position.y - tile.position.y;

    if ((deltaX.abs() + deltaY.abs()) == 1) {
      tilesToSwap.add(tile);
      _swapTiles(tilesToSwap);
    }
    read(keyStrokeState("${tile.position.x}-${tile.position.y}").notifier)
        .state = 0;
  }

  void _swapTiles(List<Tile> tilesToSwap) {
    for (final tileToSwap in tilesToSwap.reversed) {
      final tileIndex = state.tiles.indexWhere(
        (t) => t.compareOnlyPosition(tileToSwap),
      );
      final tile = state.tiles[tileIndex];
      final whitespaceTile = getWhitespaceTile();
      final whitespaceTileIndex = state.tiles.indexWhere(
        (t) => t.compareOnlyPosition(whitespaceTile),
      );

      // Swap current board positions of the moving tile and the whitespace.

      if (tile.position.isMine) {
        if (tile.position.isFlagged) {
          if (!state.tiles[tileIndex].position.isVisited) {
            read(mineCountProvider.notifier).state--;
            read(remainingProvider.notifier).state--;
          }
          state.tiles[tileIndex] = tile.copyWith(
            isWhiteSpace: true,
            position: tile.position.copyWith(
              isDefused: true,
              isVisited: true,
            ),
          );
        } else {
          state = state.copyWith(
            failed: true,
            lossReason: "mine",
          );
          read(puzzleEndTimeProvider.notifier).state =
              DateTime.now().millisecondsSinceEpoch;
        }
      } else if (tile.position.isFlagged) {
        if (!tile.position.isMine) {
          state = state.copyWith(
            failed: true,
            lossReason: "flag",
          );
          read(puzzleEndTimeProvider.notifier).state =
              DateTime.now().millisecondsSinceEpoch;
        }
      } else {
        if (!state.tiles[tileIndex].position.isVisited) {
          read(remainingProvider.notifier).state--;
        }
        state.tiles[tileIndex] = tile.copyWith(
          isWhiteSpace: true,
          position: tile.position.copyWith(
            isVisited: true,
          ),
        );
      }

      read(positionTileProvider(
        "${state.tiles[tileIndex].position.x}-${state.tiles[tileIndex].position.y}",
      ).notifier)
          .state = state.tiles[tileIndex].copyWith(
        isWhiteSpace: true,
        position: tile.position.copyWith(
          isVisited: true,
        ),
      );

      state.tiles[whitespaceTileIndex] = whitespaceTile.copyWith(
        isWhiteSpace: false,
        position: state.tiles[whitespaceTileIndex].position.copyWith(
          isVisited: true,
        ),
      );
      read(positionTileProvider(
        "${state.tiles[whitespaceTileIndex].position.x}-${state.tiles[whitespaceTileIndex].position.y}",
      ).notifier)
              .state =
          state.tiles[whitespaceTileIndex].copyWith(isWhiteSpace: false);
    }

    state = state.copyWith(tiles: state.tiles);
  }

  void createPuzzle(int size) {
    final correctPositions = <Tile>[];

    for (var x = 0; x < size; x++) {
      for (var y = 0; y < size; y++) {
        correctPositions.add(
          Tile(
            position: Position(
              x: x,
              y: y,
            ),
          ),
        );
        read(positionTileProvider(
          "$x-$y",
        ).notifier)
            .state = correctPositions.last;
      }
      read(mineCountProvider.notifier).state = 0;
      read(remainingProvider.notifier).state = correctPositions.length;
    }

    state = Puzzle(
      tiles: correctPositions,
      rowSize: size,
      colSize: size,
      solved: false,
      whiteSpaceCreated: false,
      reset: DateTime.now().millisecondsSinceEpoch,
    );
  }

  List<Tile> _getMineAndTiles(
      List<Position> correctPositions, Tile whiteSpace) {
    return correctPositions.map(
      (e) {
        if (whiteSpace.position.x == e.x && whiteSpace.position.y == e.y) {
          return Tile(
            position: e.copyWith(
              isVisited: true,
            ),
            isWhiteSpace: true,
          );
        } else {
          return Tile(
            position: e,
          );
        }
      },
    ).toList();
  }
}
