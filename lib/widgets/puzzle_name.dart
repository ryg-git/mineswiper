import 'package:flutter/material.dart';
import 'package:mineswiper/colors/colors.dart';
import 'package:mineswiper/puzzle/layout/responsible_layout_builder.dart';
import 'package:mineswiper/styles/text_styles.dart';
import 'package:mineswiper/l10n/l10n.dart';

class PuzzleName extends StatelessWidget {
  /// {@macro puzzle_name}
  const PuzzleName({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final name = context.l10n.counterAppBarTitle;

    return ResponsiveLayoutBuilder(
      small: (context, child) => const SizedBox(),
      medium: (context, child) => const SizedBox(),
      large: (context, child) => Text(
        name,
        style: PuzzleTextStyle.headline5.copyWith(
          color: PuzzleColors.grey1,
        ),
      ),
    );
  }
}
