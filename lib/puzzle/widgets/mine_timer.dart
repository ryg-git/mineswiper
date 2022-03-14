import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:mineswiper/puzzle/providers/puzzle_pro.dart';
import 'package:mineswiper/utils/screen_dimensions.dart';

class MineTimer extends HookConsumerWidget {
  const MineTimer({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final run = ref.watch(
      puzzleStateProvider.select(
        (value) => value.puzzle.whiteSpaceCreated,
      ),
    );

    Widget getWidget(double dim) {
      return run ? const _Timer() : const SizedBox();
    }

    final size = context.screensize;

    return getWidget(size.height / 5);
  }
}

class _Timer extends HookConsumerWidget {
  const _Timer({Key? key}) : super(key: key);

  String _formatTime(int seconds) {
    final minSec = '${(Duration(seconds: seconds))}'.split('.')[0].split(":");
    minSec.removeAt(0);
    return minSec.join(":").padLeft(4, '0');
  }

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final seconds = ref.watch(timerProvider);
    final hints = ref.watch(hintCountProvider);
    final prevHint = usePrevious(hints);
    return seconds.when(
      error: (error, stackTrace) => const SizedBox(),
      loading: () => Row(
        children: [
          Icon(Icons.timer_outlined),
          Text(
            "00:00",
            textAlign: TextAlign.center,
          ),
        ],
      ),
      data: (data) {
        return Row(
          children: [
            Icon(Icons.timer_outlined),
            Text(
              _formatTime(data + hints * 5),
              textAlign: TextAlign.center,
            ),
            SizedBox(
              width: 10,
            ),
            if (prevHint! < hints)
              _PlusFive(
                hints: hints,
              ),
          ],
        );
      },
    );
  }
}

class _PlusFive extends HookConsumerWidget {
  final int hints;
  const _PlusFive({
    Key? key,
    required this.hints,
  }) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final controller = useAnimationController(
      duration: Duration(milliseconds: 400),
    );

    final tween = useAnimation(
      Tween<double>(begin: -40, end: 40).animate(controller),
    );

    if (hints > 0) {
      controller.forward();
    }

    return Transform.translate(
      offset: Offset(0, tween),
      child: Text("+5"),
    );
  }
}
