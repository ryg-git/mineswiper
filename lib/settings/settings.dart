import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:mineswiper/app/app.dart';
import 'package:mineswiper/puzzle/providers/puzzle_pro.dart';
import 'package:mineswiper/theme/app_theme.dart';

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
          ),
          SizedBox(
            height: 40,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text("Select theme"),
            ],
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: InkWell(
                  child: Card(
                    child: Row(
                      children: [
                        Container(
                          height: 50,
                          width: 50,
                          color: Color(0xFF78909c),
                        ),
                        Container(
                          height: 50,
                          width: 50,
                          color: Color(0xFFc1d5e0),
                        ),
                      ],
                    ),
                  ),
                  onTap: () {
                    ref.read(appThemeState.notifier).state =
                        AppTheme.lightTheme;
                  },
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: InkWell(
                  child: Card(
                    child: Row(
                      children: [
                        Container(
                          height: 50,
                          width: 50,
                          color: Color(0xFFffeb3b),
                        ),
                        Container(
                          height: 50,
                          width: 50,
                          color: Color(0xFFffff8b),
                        ),
                      ],
                    ),
                  ),
                  onTap: () {
                    ref.read(appThemeState.notifier).state =
                        AppTheme.light2Theme;
                  },
                ),
              ),
            ],
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: InkWell(
                  child: Card(
                    child: Row(
                      children: [
                        Container(
                          height: 50,
                          width: 50,
                          color: Color(0xFF0336FF),
                        ),
                        Container(
                          height: 50,
                          width: 50,
                          color: Color(0xFFFF0266),
                        ),
                      ],
                    ),
                  ),
                  onTap: () {
                    ref.read(appThemeState.notifier).state =
                        AppTheme.light4Theme;
                  },
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: InkWell(
                  child: Card(
                    child: Row(
                      children: [
                        Container(
                          height: 50,
                          width: 50,
                          color: Color(0xFF7b5e57),
                        ),
                        Container(
                          height: 50,
                          width: 50,
                          color: Color(0xFF3e2723),
                        ),
                      ],
                    ),
                  ),
                  onTap: () {
                    ref.read(appThemeState.notifier).state =
                        AppTheme.light3Theme;
                  },
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
