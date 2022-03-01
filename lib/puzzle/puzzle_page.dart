import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:mineswiper/l10n/l10n.dart';
import 'package:mineswiper/puzzle/layout/responsible_layout_builder.dart';
import 'package:mineswiper/puzzle/providers/puzzle_pro.dart';
import 'package:mineswiper/utils/theme.dart';
import 'package:fluent_ui/fluent_ui.dart' as fui;

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
    final puzzleLayout = ref.read(puzzleLayoutProvider);
    final size = ref.read(puzzleSizeProvider);
    final puzzleState = ref.read(puzzleStateProvider);

    if (size == 0) return const CircularProgressIndicator();
    return InteractiveViewer(
      panEnabled: false, // Set it to false to prevent panning.
      boundaryMargin: EdgeInsets.all(80),
      minScale: 0.5,
      maxScale: 8,
      child: Stack(
        alignment: Alignment.center,
        children: [
          puzzleLayout.boardBuilder(
            size,
            puzzleState.puzzle.tiles
                .map(
                  (tile) => _PuzzleTile(
                    key: Key('puzzle_tile_${tile.position.toString()}'),
                    x: tile.position.x,
                    y: tile.position.y,
                  ),
                )
                .toList(),
          ),
          _ShowMessage(),
        ],
      ),
    );
  }
}

class _PuzzleTile extends HookConsumerWidget {
  const _PuzzleTile({
    Key? key,
    required this.x,
    required this.y,
  }) : super(key: key);

  final int x;
  final int y;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final puzzleLayout = ref.read(puzzleLayoutProvider);
    final puzzleState = ref.read(puzzleStateProvider);
    final size = ref.read(puzzleSizeProvider);
    final currentTile = puzzleState.puzzle.tiles[x * size + y];
    final tile = ref.watch(positionTileProvider(
        "${currentTile.position.x}-${currentTile.position.y}"));

    return tile.isWhiteSpace
        ? puzzleLayout.whitespaceTileBuilder(currentTile, puzzleState)
        : puzzleLayout.tileBuilder(currentTile, puzzleState);
  }
}

class _ShowMessage extends HookConsumerWidget {
  const _ShowMessage({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final puzzleState = ref.watch(puzzleStateProvider);
    final l10n = context.l10n;

    return puzzleState.puzzle.whiteSpaceCreated
        ? SizedBox()
        : fui.FluentTheme(
            data: fui.ThemeData(
              visualDensity: VisualDensity.standard,
            ),
            child: fui.Acrylic(
              child: Center(
                child: Text(
                  l10n.tapTile,
                  textAlign: TextAlign.center,
                ),
              ),
            ),
          );
  }
}
