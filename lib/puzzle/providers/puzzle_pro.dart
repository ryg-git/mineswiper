import 'dart:math';

import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:mineswiper/models/position.dart';
import 'package:mineswiper/models/puzzle.dart';
import 'package:mineswiper/models/puzzle_state.dart';
import 'package:mineswiper/models/tile.dart';
import 'package:mineswiper/puzzle/layout/mine_puzzle_layout_delegate.dart';

final puzzleSizeProvider = StateProvider<int>((ref) => 5);

class PuzzleNotifier extends StateNotifier<Puzzle> {
  final Random random = Random();

  PuzzleNotifier() : super(Puzzle(tiles: []));

  Tile getWhitespaceTile() {
    return state.tiles.singleWhere((tile) => tile.isWhiteSpace);
  }

  bool isTileMovable(Tile tile) {
    final whitespaceTile = getWhitespaceTile();
    if (tile == whitespaceTile) {
      return false;
    }

    if (whitespaceTile.position.x != tile.position.x &&
        whitespaceTile.position.y != tile.position.y) {
      return false;
    }
    return true;
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
      final tileIndex = state.tiles.indexOf(tileToSwap);
      final tile = state.tiles[tileIndex];
      final whitespaceTile = getWhitespaceTile();
      final whitespaceTileIndex = state.tiles.indexOf(whitespaceTile);

      // Swap current board positions of the moving tile and the whitespace.
      state.tiles[tileIndex] = tile.copyWith(
        isWhiteSpace: true,
      );
      state.tiles[whitespaceTileIndex] = whitespaceTile.copyWith(
        isWhiteSpace: false,
        position: state.tiles[whitespaceTileIndex].position.copyWith(
          isVisited: true,
        ),
      );
    }

    state = Puzzle(tiles: state.tiles);
  }

  void createPuzzle(int size) {
    final mineNumber = (size * size * 3.5) ~/ 10;
    final oddOrEven = random.nextBool();

    final correctPositions = <Position>[];

    for (var y = 0; y < size; y++) {
      for (var x = 0; x < size; x++) {
        correctPositions.add(
          Position(
            x: x,
            y: y,
          ),
        );
      }
    }

    final _allPossibleMines = correctPositions
        .where(
          (element) => oddOrEven
              ? (element.x + element.y).isEven
              : (element.x + element.y).isOdd,
        )
        .toList()
      ..shuffle();

    final mines = _allPossibleMines.take(mineNumber).toList();

    final minesTiles = correctPositions.map(
      (e) {
        if (mines.contains(e)) {
          return e.copyWith(
            isMine: true,
            mines: 4,
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
    // ..sort(
    //   (a, b) => (a.x * size + a.y).compareTo(b.x * size + b.y),
    // );

    final tiles = _getMineAndTiles(
      minesTiles,
      minesTiles[0],
    );

    state = Puzzle(tiles: tiles);
  }

  List<Tile> _getMineAndTiles(
    List<Position> correctPositions,
    Position whiteSpace,
  ) {
    return correctPositions.map(
      (e) {
        return Tile(
          position: e,
          isWhiteSpace: e == whiteSpace,
        );
      },
    ).toList();
  }
}

final puzzleProvider = StateNotifierProvider<PuzzleNotifier, Puzzle>((ref) {
  final puzzleSize = ref.watch(puzzleSizeProvider);

  return PuzzleNotifier()..createPuzzle(puzzleSize);
});

final puzzleStateProvider = StateProvider<PuzzleState>((ref) {
  final puzzle = ref.watch(puzzleProvider);
  return PuzzleState(puzzle: puzzle);
});

final puzzleLayoutProvider = StateProvider<MinePuzzleLayoutDelegate>((ref) {
  return MinePuzzleLayoutDelegate();
});