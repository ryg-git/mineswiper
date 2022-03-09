import 'dart:async';
import 'dart:math';

import 'package:flutter/services.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:mineswiper/models/position.dart';
import 'package:mineswiper/models/puzzle.dart';
import 'package:mineswiper/models/puzzle_state.dart';
import 'package:mineswiper/models/tile.dart';
import 'package:mineswiper/puzzle/layout/mine_puzzle_layout_delegate.dart';

final puzzleSizeProvider = StateProvider<int>((ref) => 10);

final mineCountProvider = StateProvider<int>((ref) => 0);

final timerProvider = StreamProvider.autoDispose<int>(
  (ref) => Stream.periodic(
    const Duration(seconds: 1),
    (i) => i,
  ),
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
    final mineNumber = (size * size) ~/ 5;
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
      } else if (event.data.logicalKey.keyLabel == "Arrow Left") {
        final t =
            state.tiles.firstWhere((element) => element.onLeft(whitespaceTile));

        moveTiles(t, []);
      } else if (event.data.logicalKey.keyLabel == "Arrow Right") {
        final t = state.tiles
            .firstWhere((element) => element.onRight(whitespaceTile));

        moveTiles(t, []);
      } else if (event.data.logicalKey.keyLabel == "Arrow Up") {
        final t =
            state.tiles.firstWhere((element) => element.onTop(whitespaceTile));

        moveTiles(t, []);
      } else if (event.data.logicalKey.keyLabel == "Arrow Down") {
        final t = state.tiles
            .firstWhere((element) => element.onBottom(whitespaceTile));

        moveTiles(t, []);
      }
    } catch (e) {
      print("Error: $e");
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
          );
        }
      } else if (tile.position.isFlagged) {
        if (!tile.position.isMine) {
          state = state.copyWith(
            failed: true,
          );
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
