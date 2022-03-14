import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:mineswiper/puzzle/widgets/mine_puzzle_tile.dart';
import 'dart:math' show pi, sin;

import 'package:mineswiper/utils/theme.dart';

class FlagLost extends HookWidget {
  const FlagLost({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final xController = useAnimationController(
      duration: Duration(
        milliseconds: 300,
      ),
    );

    final xtween = useAnimation(Tween<double>(
      begin: 0,
      end: pi,
    ).animate(xController));

    final ytween = useAnimation(Tween<double>(
      begin: 0,
      end: 50,
    ).animate(xController));

    final showIcon = useState<bool>(false);

    Future.delayed(Duration(milliseconds: 200), () {
      xController.forward().then((value) => showIcon.value = true);
    });

    return Transform.translate(
      offset: const Offset(-25, 0),
      child: Container(
        color: context.theme.backgroundColor,
        child: Stack(
          alignment: Alignment.center,
          children: [
            SizedBox(),
            SizedBox(
              width: 50,
              height: 50,
              child: CustomPaint(
                painter: TilePainter(
                  x: sin(xtween) / 3,
                  y: ytween,
                  tileGap: 0,
                  yValue: 1,
                  xValue: 0,
                  multiplier: 0.5,
                  color: context.theme.primaryColor,
                ),
                child: Transform.translate(
                  offset: Offset(ytween, 0),
                  child: AnimatedSwitcher(
                    duration: const Duration(milliseconds: 300),
                    transitionBuilder: (child, animation) {
                      return ScaleTransition(
                        scale: animation,
                        child: child,
                      );
                    },
                    child: showIcon.value
                        ? Icon(
                            Icons.close_rounded,
                            color: Colors.red,
                            size: 40,
                          )
                        : Icon(
                            Icons.flag,
                          ),
                  ),
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
