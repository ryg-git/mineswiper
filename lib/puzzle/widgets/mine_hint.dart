import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

import 'package:mineswiper/utils/theme.dart';

class MineHint extends HookConsumerWidget {
  const MineHint({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Image(
      image: AssetImage('assets/images/mine.png'),
      fit: BoxFit.fitHeight,
      color: context.theme.backgroundColor.withAlpha(100),
    );
  }
}
