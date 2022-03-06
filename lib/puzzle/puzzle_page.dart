import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:mineswiper/l10n/l10n.dart';
import 'package:mineswiper/puzzle/layout/responsible_layout_builder.dart';
import 'package:mineswiper/puzzle/providers/puzzle_pro.dart';
import 'package:mineswiper/puzzle/widgets/mine_count.dart';
import 'package:mineswiper/puzzle/widgets/mine_timer.dart';
import 'package:mineswiper/utils/screen_dimensions.dart';
import 'package:mineswiper/utils/theme.dart';
import 'package:fluent_ui/fluent_ui.dart' as fui;
import 'package:throttling/throttling.dart';

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
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        title: const MineCount(),
        centerTitle: true,
        elevation: 0,
      ),
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
    return _PuzzleSections(
      key: Key('puzzle_sections'),
    );
  }
}

class _PuzzleSections extends StatelessWidget {
  const _PuzzleSections({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final size = context.screensize;
    return ResponsiveLayoutBuilder(
      small: (context, child) => Column(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          const PuzzleBoard(),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const MineCount(),
              const MineTimer(),
            ],
          ),
        ],
      ),
      medium: (context, child) => Column(
        children: [
          const PuzzleBoard(),
        ],
      ),
      large: (context, child) => Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Expanded(child: const PuzzleBoard()),
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

    final _focusNode = useFocusNode();

    final thr = Throttling(
      duration: const Duration(milliseconds: 300),
    );

    void _handleKeyEvent(RawKeyEvent event) {
      print("key ${event.logicalKey}");
      if (ref.read(puzzleStateProvider).puzzle.whiteSpaceCreated &&
          !ref.read(puzzleStateProvider).puzzle.failed) {
        ref.read(puzzleProvider.notifier).handleKeyEvent(event);
      }
    }

    if (size == 0) return const CircularProgressIndicator();
    return InteractiveViewer(
      onInteractionEnd: (details) =>
          FocusScope.of(context).requestFocus(_focusNode),
      panEnabled: true,
      boundaryMargin: EdgeInsets.all(10),
      minScale: 1,
      maxScale: 8,
      child: RawKeyboardListener(
        focusNode: _focusNode,
        onKey: (event) => thr.throttle(() => _handleKeyEvent(event)),
        autofocus: true,
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
    final remainingTiles = ref.watch(remainingProvider);
    final l10n = context.l10n;
    final isMounted = useIsMounted();

    useEffect(
      () {
        Future.delayed(
          Duration.zero,
          () {
            if (isMounted() && puzzleState.puzzle.failed) {
              showDialog<String>(
                context: context,
                builder: (BuildContext context) => fui.ContentDialog(
                  title: fui.Text(l10n.lost),
                  actions: [
                    fui.Button(
                      child: fui.Text(l10n.ok),
                      onPressed: () {
                        ref.read(puzzleProvider.notifier).createPuzzle(
                              ref.read(puzzleSizeProvider),
                            );
                        Navigator.pop(context);
                      },
                    ),
                  ],
                ),
              );
            } else if (isMounted() && remainingTiles == 0) {
              showDialog<String>(
                context: context,
                builder: (BuildContext context) => fui.ContentDialog(
                  title: fui.Text(l10n.won),
                  actions: [
                    fui.Button(
                      child: fui.Text(l10n.ok),
                      onPressed: () {
                        ref.read(puzzleProvider.notifier).createPuzzle(
                              ref.read(puzzleSizeProvider),
                            );
                        Navigator.pop(context);
                      },
                    ),
                  ],
                ),
              );
            }
          },
        );
        return;
      },
    );

    return puzzleState.puzzle.whiteSpaceCreated
        ? SizedBox()
        : fui.Acrylic(
            child: fui.Text(
              l10n.tapTile,
              textAlign: fui.TextAlign.center,
            ),
          );
  }
}
