import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:mineswiper/l10n/l10n.dart';
import 'package:mineswiper/puzzle/puzzle_page.dart';
import 'package:mineswiper/theme/app_theme.dart';
import 'package:fluent_ui/fluent_ui.dart' as fui;

final darkThemeState = StateProvider((ref) => false);

class App extends HookConsumerWidget {
  const App({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final darkMode = ref.watch(darkThemeState);
    return fui.FluentApp(
      title: 'MineSwiper',
      debugShowCheckedModeBanner: false,
      builder: (context, widget) {
        return MaterialApp(
          theme: AppTheme.lightTheme,
          darkTheme: AppTheme.darkTheme,
          themeMode: darkMode ? ThemeMode.dark : ThemeMode.light,
          localizationsDelegates: const [
            AppLocalizations.delegate,
            GlobalMaterialLocalizations.delegate,
          ],
          supportedLocales: AppLocalizations.supportedLocales,
          home: const PuzzlePage(),
        );
      },
    );
  }
}
