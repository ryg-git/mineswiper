import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'dart:math' show pi;

import 'package:mineswiper/utils/theme.dart';

class MineHint extends HookConsumerWidget {
  const MineHint({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final isMounted = useIsMounted();
    final xController = useAnimationController(
      duration: Duration(
        milliseconds: 200,
      ),
    );
    final xtween = useAnimation(
      Tween<double>(
        begin: 0,
        end: 2 * pi,
      ).animate(xController),
    );

    useEffect(() {
      if (isMounted()) {
        Future.delayed(
          Duration.zero,
          () {
            xController.forward();
          },
        );
      }
      return;
    });

    return Transform.rotate(
      angle: xtween,
      child: Image(
        image: AssetImage('assets/images/mine.png'),
        fit: BoxFit.fitHeight,
        color: context.theme.backgroundColor.withAlpha(100),
      ),
    );
  }
}
