import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:mineswiper/models/tile.dart';
import 'package:mineswiper/puzzle/layout/responsible_layout_builder.dart';
import 'package:mineswiper/puzzle/providers/puzzle_pro.dart';
import 'package:mineswiper/utils/theme.dart';

class PuzzlePage extends StatelessWidget {
  /// {@macro puzzle_page}
  const PuzzlePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return const PuzzleView();
  }
}

class PuzzleView extends StatelessWidget {
  /// {@macro puzzle_view}
  const PuzzleView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: context.theme.backgroundColor,
      body: const _Puzzle(
        key: Key('puzzle_view_puzzle'),
      ),
    );
  }
}

class _Puzzle extends StatelessWidget {
  const _Puzzle({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        return Stack(
          children: [
            SingleChildScrollView(
              child: ConstrainedBox(
                constraints: BoxConstraints(
                  minHeight: constraints.maxHeight,
                ),
                child: const _PuzzleSections(
                  key: Key('puzzle_sections'),
                ),
              ),
            ),
          ],
        );
      },
    );
  }
}

class _PuzzleSections extends StatelessWidget {
  const _PuzzleSections({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ResponsiveLayoutBuilder(
      small: (context, child) => Column(
        children: [
          const PuzzleBoard(),
        ],
      ),
      medium: (context, child) => Column(
        children: [
          const PuzzleBoard(),
        ],
      ),
      large: (context, child) => Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          const PuzzleBoard(),
        ],
      ),
    );
  }
}

class PuzzleBoard extends HookConsumerWidget {
  /// {@macro puzzle_board}
  const PuzzleBoard({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final puzzleState = ref.watch(puzzleStateProvider);
    final puzzleLayout = ref.watch(puzzleLayoutProvider);
    final size = puzzleState.puzzle.getDimension();
    if (size == 0) return const CircularProgressIndicator();

    return puzzleLayout.boardBuilder(
      size,
      puzzleState.puzzle.tiles
          .map(
            (tile) => _PuzzleTile(
              key: Key('puzzle_tile_${tile.position.toString()}'),
              tile: tile,
            ),
          )
          .toList(),
    );
  }
}

class _PuzzleTile extends HookConsumerWidget {
  const _PuzzleTile({
    Key? key,
    required this.tile,
  }) : super(key: key);

  /// The tile to be displayed.
  final Tile tile;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final puzzleState = ref.watch(puzzleStateProvider);
    final puzzleLayout = ref.watch(puzzleLayoutProvider);

    return tile.isWhiteSpace
        ? puzzleLayout.whitespaceTileBuilder(tile, puzzleState)
        : puzzleLayout.tileBuilder(tile, puzzleState);
  }
}
