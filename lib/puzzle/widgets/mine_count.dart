import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:mineswiper/puzzle/layout/responsible_layout_builder.dart';
import 'package:mineswiper/puzzle/providers/puzzle_pro.dart';
import 'package:mineswiper/utils/screen_dimensions.dart';

class MineCount extends HookConsumerWidget {
  const MineCount({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final mines = ref.watch(mineCountProvider);
    final animationController = useAnimationController(
      duration: Duration(
        milliseconds: 300,
      ),
    )..repeat();
    final curve = CurvedAnimation(
      parent: animationController,
      curve: Curves.decelerate,
    );

    final _animOffsetDown =
        Tween<Offset>(begin: const Offset(0, 100), end: Offset.zero)
            .animate(curve);
    final _animOffsetUp =
        Tween<Offset>(begin: Offset.zero, end: const Offset(0, -100))
            .animate(curve);

    Future.delayed(Duration.zero, () {
      // animationController.reset();
      animationController.forward();
    });

    final pre = usePrevious(mines);

    Widget getWidget(double dim) {
      return Padding(
        padding: const EdgeInsets.all(8.0),
        child: mines == 0
            ? const SizedBox()
            : AnimatedBuilder(
                animation: animationController,
                builder: (context, child) {
                  return Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        'M: ',
                        textAlign: TextAlign.center,
                      ),
                      Stack(
                        children: [
                          if (pre != 0)
                            Transform.translate(
                              offset: _animOffsetUp.value,
                              child: Text(
                                '${mines + 1}',
                                textAlign: TextAlign.center,
                              ),
                            ),
                          if (mines >= 0)
                            Transform.translate(
                              offset: _animOffsetDown.value,
                              child: Text(
                                '$mines',
                                textAlign: TextAlign.center,
                              ),
                            ),
                        ],
                      ),
                    ],
                  );
                },
              ),
      );
    }

    final size = context.screensize;

    return ResponsiveLayoutBuilder(
      small: (_, __) => getWidget(size.height / 5),
      medium: (_, __) => getWidget(size.height / 5),
      large: (_, __) => getWidget(size.width / 5),
    );
  }
}
