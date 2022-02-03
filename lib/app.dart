import 'package:cartracker/locale/locale_manager.dart';
import 'package:cartracker/themes.dart';
import 'package:flutter/material.dart';
import './locale/locales.dart';
import 'data/settings.dart';
import 'screens/menu.dart';
import 'package:flutter_localizations/flutter_localizations.dart';

class App extends StatelessWidget {
  App({Key? key}) : super(key: key) {}

  @override
  Widget build(BuildContext context) {
      return MaterialApp(
        showPerformanceOverlay: false,
        showSemanticsDebugger: false,
        debugShowCheckedModeBanner: false,
        debugShowMaterialGrid: false,
        checkerboardOffscreenLayers: false,
        checkerboardRasterCacheImages: false,
        themeMode: Settings.global.theme,
        theme: Themes.lightTheme,
        darkTheme: Themes.darkTheme,
        localizationsDelegates: const [
          LocaleManager(),
          GlobalMaterialLocalizations.delegate,
          GlobalWidgetsLocalizations.delegate
        ],
        supportedLocales: Locales.supported,
        home: MainMenu(),
      );
  }
}
