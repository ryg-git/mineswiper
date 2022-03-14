import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:mineswiper/models/tile.dart';
import 'package:mineswiper/puzzle/providers/puzzle_pro.dart';
import 'dart:math' show pi;

import 'package:mineswiper/puzzle/widgets/mine_hint.dart';

class MineFlag extends HookConsumerWidget {
  final Tile currentTile;

  const MineFlag({Key? key, required this.currentTile}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final size = ref.watch(puzzleSizeProvider);

    return AnimatedSwitcher(
      duration: const Duration(milliseconds: 500),
      transitionBuilder: (Widget child, Animation<double> animation) {
        final tAnimation = Tween<double>(
          begin: 0,
          end: 2 * pi,
        ).animate(animation);
        return currentTile.position.isFlagged
            ? AnimatedBuilder(
                animation: tAnimation,
                builder: (context, _) {
                  return ScaleTransition(
                    scale: animation,
                    child: Transform.rotate(
                      angle: tAnimation.value,
                      child: child,
                    ),
                  );
                })
            : AnimatedBuilder(
                animation: tAnimation,
                builder: (context, _) {
                  return ScaleTransition(
                    scale: animation,
                    child: Transform.rotate(
                      angle: tAnimation.value,
                      child: child,
                    ),
                  );
                },
              );
      },
      child: currentTile.position.isFlagged
          ? Center(
              child: Icon(
                Icons.flag,
                size: 230 / size,
              ),
            )
          : currentTile.position.showHint
              ? MineHint()
              : SizedBox(),
    );
  }
}
