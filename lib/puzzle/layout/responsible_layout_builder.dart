import 'package:flutter/widgets.dart';
import 'package:mineswiper/puzzle/layout/breakpoint.dart';

enum ResponsiveLayoutSize {
  small,
  medium,
  large,
}

typedef ResponsiveLayoutWidgetBuilder = Widget Function(BuildContext, Widget?);

class ResponsiveLayoutBuilder extends StatelessWidget {
  const ResponsiveLayoutBuilder({
    Key? key,
    required this.small,
    required this.medium,
    required this.large,
    this.child,
  }) : super(key: key);

  final ResponsiveLayoutWidgetBuilder small;

  final ResponsiveLayoutWidgetBuilder medium;

  final ResponsiveLayoutWidgetBuilder large;

  final Widget Function(ResponsiveLayoutSize currentSize)? child;

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        final screenWidth = MediaQuery.of(context).size.width;

        if (screenWidth <= PuzzleBreakpoints.small) {
          return small(context, child?.call(ResponsiveLayoutSize.small));
        }
        if (screenWidth <= PuzzleBreakpoints.medium) {
          return medium(context, child?.call(ResponsiveLayoutSize.medium));
        }
        if (screenWidth <= PuzzleBreakpoints.large) {
          return large(context, child?.call(ResponsiveLayoutSize.large));
        }

        return large(context, child?.call(ResponsiveLayoutSize.large));
      },
    );
  }
}
