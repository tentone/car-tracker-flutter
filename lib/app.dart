import 'package:flutter/material.dart';
import './locale/locales.dart';
import 'screens/menu/main_menu.dart';


class App extends StatelessWidget {
  const App({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: Locales.get('carTracker', context),
      showPerformanceOverlay: false,
      showSemanticsDebugger: false,
      debugShowCheckedModeBanner: false,
      debugShowMaterialGrid: false,
      checkerboardOffscreenLayers: false,
      checkerboardRasterCacheImages: false,
      theme: ThemeData.dark(),
      home: MainMenu(),
    );
  }
}
