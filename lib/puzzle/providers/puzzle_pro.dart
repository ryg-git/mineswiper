import 'dart:math';

import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:mineswiper/models/position.dart';
import 'package:mineswiper/models/puzzle.dart';
import 'package:mineswiper/models/puzzle_state.dart';
import 'package:mineswiper/models/tile.dart';
import 'package:mineswiper/puzzle/layout/mine_puzzle_layout_delegate.dart';

final puzzleSizeProvider = StateProvider<int>((ref) => 40);

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

  bool isTileMovable(Tile tile) {
    if (state.whiteSpaceCreated) {
      final whitespaceTile = getWhitespaceTile();
      if (tile == whitespaceTile) {
        return false;
      }

      if (whitespaceTile.position.x != tile.position.x &&
          whitespaceTile.position.y != tile.position.y) {
        return false;
      }
      return true;
    } else {
      return false;
    }
  }

  void createWhiteSpace(Tile tile, int size) {
    final mineNumber = (size * size * 4) ~/ 10;
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
    );

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
        if (e == tile) {
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

  void moveTiles(Tile tile, List<Tile> tilesToSwap) {
    final whitespaceTile = getWhitespaceTile();

    final deltaX = whitespaceTile.position.x - tile.position.x;
    final deltaY = whitespaceTile.position.y - tile.position.y;

    if ((deltaX.abs() + deltaY.abs()) > 1) {
      final shiftPointX = tile.position.x + deltaX.sign;
      final shiftPointY = tile.position.y + deltaY.sign;
      final tileToSwapWith = state.tiles.singleWhere(
        (tile) =>
            tile.position.x == shiftPointX && tile.position.y == shiftPointY,
      );
      tilesToSwap.add(tile);
      return moveTiles(tileToSwapWith, tilesToSwap);
    } else {
      tilesToSwap.add(tile);
      _swapTiles(tilesToSwap);
    }
  }

  void _swapTiles(List<Tile> tilesToSwap) {
    for (final tileToSwap in tilesToSwap.reversed) {
      final tileIndex = state.tiles.indexWhere(
        (t) =>
            t.position.x == tileToSwap.position.x &&
            t.position.y == tileToSwap.position.y,
      );
      final tile = state.tiles[tileIndex];
      final whitespaceTile = getWhitespaceTile();
      final whitespaceTileIndex = state.tiles.indexWhere(
        (t) =>
            t.position.x == whitespaceTile.position.x &&
            t.position.y == whitespaceTile.position.y,
      );

      // Swap current board positions of the moving tile and the whitespace.
      state.tiles[tileIndex] = tile.copyWith(
        isWhiteSpace: true,
      );

      read(positionTileProvider(
        "${state.tiles[tileIndex].position.x}-${state.tiles[tileIndex].position.y}",
      ).notifier)
          .state = state.tiles[tileIndex].copyWith(isWhiteSpace: true);

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
      }
    }

    state = Puzzle(
      tiles: correctPositions,
      rowSize: size,
      colSize: size,
      solved: false,
      whiteSpaceCreated: false,
    );
  }

  List<Tile> _getMineAndTiles(
      List<Position> correctPositions, Tile whiteSpace) {
    return correctPositions.map(
      (e) {
        if (whiteSpace.position.x == e.x && whiteSpace.position.y == e.y) {
          return Tile(
            position: e,
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
