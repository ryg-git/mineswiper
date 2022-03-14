import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:mineswiper/puzzle/providers/puzzle_pro.dart';

class Settings extends HookConsumerWidget {
  const Settings({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final memory = ref.watch(memoryMode);
    return Scaffold(
      appBar: AppBar(
        title: Text("Settings"),
      ),
      body: Column(
        children: [
          SwitchListTile(
            title: Text("Memory mode"),
            onChanged: (bool value) {
              ref.read(memoryMode.notifier).state = value;
            },
            value: memory,
          )
        ],
      ),
    );
  }
}
