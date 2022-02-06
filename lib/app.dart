import 'package:cartracker/locale/locale_manager.dart';
import 'package:cartracker/themes.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import './locale/locales.dart';
import 'data/settings.dart';
import 'screens/menu.dart';
import 'package:flutter_localizations/flutter_localizations.dart';

/// Main application widget entry point
class App extends StatelessWidget {
  App({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (_) => Settings.global,
      child: Consumer<Settings>(builder: (context, Settings settings, child) {
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
          localizationsDelegates: const [LocaleManager(), GlobalMaterialLocalizations.delegate, GlobalWidgetsLocalizations.delegate],
          supportedLocales: Locales.supported,
          home: const MainMenu(),
        );
      }),
    );
  }
}
