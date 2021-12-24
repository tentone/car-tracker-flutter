import 'package:cartracker/locale/locale_manager.dart';
import 'package:flutter/material.dart';
import './locale/locales.dart';
import 'screens/menu/main_menu.dart';
import 'package:flutter_localizations/flutter_localizations.dart';

class App extends StatelessWidget {
  const App({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      showPerformanceOverlay: false,
      showSemanticsDebugger: false,
      debugShowCheckedModeBanner: false,
      debugShowMaterialGrid: false,
      checkerboardOffscreenLayers: false,
      checkerboardRasterCacheImages: false,
      theme: ThemeData.dark(),
      localizationsDelegates:
      const [
        LocaleManager(),
        GlobalMaterialLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate
      ],
      supportedLocales: Locales.supported,
      home: MainMenu(),
    );
  }
}
