import 'package:fluent_ui/fluent_ui.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:mineswiper/puzzle/layout/responsible_layout_builder.dart';
import 'package:mineswiper/puzzle/providers/puzzle_pro.dart';
import 'package:mineswiper/utils/screen_dimensions.dart';

class MineTimer extends HookConsumerWidget {
  const MineTimer({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final run = ref.watch(
      puzzleStateProvider.select(
        (value) =>
            value.puzzle.whiteSpaceCreated &&
            !value.puzzle.failed &&
            !value.puzzle.solved,
      ),
    );

    Widget getWidget(double dim) {
      return Padding(
        padding: const EdgeInsets.all(8.0),
        child: run ? const _Timer() : const SizedBox(),
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

class _Timer extends HookConsumerWidget {
  const _Timer({Key? key}) : super(key: key);

  String _formatTime(int seconds) {
    return '${(Duration(seconds: seconds))}'.split('.')[0].padLeft(8, '0');
  }

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final seconds = ref.watch(timerProvider);
    return seconds.when(
      error: (error, stackTrace) => const SizedBox(),
      loading: () => const SizedBox(),
      data: (data) {
        return Stack(
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
                            _formatTime(data),
                            style: FluentTheme.of(context).typography.display,
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
        );
      },
    );
  }
}
