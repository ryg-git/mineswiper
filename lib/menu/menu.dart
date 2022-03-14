import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:mineswiper/howtoplay/how_to_play.dart';
import 'package:mineswiper/puzzle/providers/puzzle_pro.dart';
import 'package:mineswiper/puzzle/puzzle_page.dart';
import 'package:mineswiper/settings/settings.dart';
import 'package:mineswiper/utils/theme.dart';

class Menu extends HookConsumerWidget {
  const Menu({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final _controller = useAnimationController(
      duration: Duration(milliseconds: 500),
    );

    return Scaffold(
      body: SingleChildScrollView(
        padding: EdgeInsets.all(120),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Image(
                  image: AssetImage('assets/images/mine.png'),
                  fit: BoxFit.fitHeight,
                  height: 40,
                  color: context.theme.textTheme.headline3!.color,
                ),
                Text(
                  "MINESWIPER",
                  style: context.theme.textTheme.headline3!.copyWith(
                    fontFamily: "FredokaOne",
                  ),
                ),
              ],
            ),
            ListTile(
              title: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    "New Game",
                    style: context.theme.textTheme.bodyText2!.copyWith(
                      fontFamily: "FredokaOne",
                    ),
                  ),
                ],
              ),
              onTap: () => _controller.isCompleted
                  ? _controller.reverse()
                  : _controller.forward(),
            ),
            SizeTransition(
              sizeFactor: _controller,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      TextButton(
                        onPressed: () {
                          ref.read(puzzleSizeProvider.notifier).state = 5;
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => const PuzzlePage(),
                            ),
                          );
                        },
                        child: Text("5 X 5"),
                      ),
                      TextButton(
                        onPressed: () {
                          ref.read(puzzleSizeProvider.notifier).state = 8;
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => const PuzzlePage(),
                            ),
                          );
                        },
                        child: Text("8 X 8"),
                      ),
                      TextButton(
                        onPressed: () {
                          ref.read(puzzleSizeProvider.notifier).state = 12;
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => const PuzzlePage(),
                            ),
                          );
                        },
                        child: Text("12 X 12"),
                      ),
                      TextButton(
                        onPressed: () {
                          ref.read(puzzleSizeProvider.notifier).state = 16;
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => const PuzzlePage(),
                            ),
                          );
                        },
                        child: Text("16 X 16"),
                      ),
                    ],
                  ),
                ],
              ),
            ),
            ListTile(
              title: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    "How to play",
                    style: context.theme.textTheme.bodyText2!.copyWith(
                      fontFamily: "FredokaOne",
                    ),
                  ),
                ],
              ),
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => const HowToPlay(),
                  ),
                );
              },
            ),
            ListTile(
              title: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    "Settings",
                    style: context.theme.textTheme.bodyText2!.copyWith(
                      fontFamily: "FredokaOne",
                    ),
                  ),
                ],
              ),
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => const Settings(),
                  ),
                );
              },
            ),
          ],
        ),
      ),
    );
  }
}
