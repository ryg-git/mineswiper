import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:mineswiper/l10n/l10n.dart';
import 'package:mineswiper/menu/menu.dart';
import 'package:mineswiper/theme/app_theme.dart';

final darkThemeState = StateProvider((ref) => false);

final appThemeState = StateProvider((ref) => AppTheme.lightTheme);

class App extends HookConsumerWidget {
  const App({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final darkMode = ref.watch(darkThemeState);
    final appTheme = ref.watch(appThemeState);
    return MaterialApp(
      theme: appTheme,
      darkTheme: AppTheme.darkTheme,
      themeMode: darkMode ? ThemeMode.dark : ThemeMode.light,
      debugShowCheckedModeBanner: false,
      localizationsDelegates: const [
        AppLocalizations.delegate,
        GlobalMaterialLocalizations.delegate,
      ],
      scrollBehavior: MaterialScrollBehavior().copyWith(
        dragDevices: {
          PointerDeviceKind.mouse,
          PointerDeviceKind.touch,
          PointerDeviceKind.stylus,
          PointerDeviceKind.unknown
        },
      ),
      supportedLocales: AppLocalizations.supportedLocales,
      home: Menu(),
    );
  }
}
