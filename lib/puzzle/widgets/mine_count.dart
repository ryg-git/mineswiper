import 'package:fluent_ui/fluent_ui.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:mineswiper/puzzle/layout/responsible_layout_builder.dart';
import 'package:mineswiper/puzzle/providers/puzzle_pro.dart';
import 'package:mineswiper/utils/screen_dimensions.dart';

class MineCount extends HookConsumerWidget {
  const MineCount({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final mines = ref.watch(mineCountProvider);

    Widget getWidget(double dim) {
      return Padding(
        padding: const EdgeInsets.all(8.0),
        child: mines == 0
            ? const SizedBox()
            : Stack(
                children: [
                  const Positioned.fill(child: FlutterLogo()),
                  Align(
                    alignment: Alignment.center,
                    child: SizedBox(
                      child: Acrylic(
                        child: Center(
                          child: Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Column(
                              children: [
                                Text(
                                  'M',
                                  style: FluentTheme.of(context)
                                      .typography
                                      .display,
                                  textAlign: TextAlign.center,
                                ),
                                Text(
                                  '$mines',
                                  style: FluentTheme.of(context)
                                      .typography
                                      .titleLarge,
                                  textAlign: TextAlign.center,
                                ),
                              ],
                            ),
                          ),
                        ),
                      ),
                    ),
                  ),
                ],
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
