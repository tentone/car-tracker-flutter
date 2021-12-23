import 'package:flutter/material.dart';

import 'screens/menu/main_menu.dart';

class TrackerApp extends StatelessWidget {
  const TrackerApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'CarTracker',
      showPerformanceOverlay: false,
      showSemanticsDebugger: false,
      debugShowCheckedModeBanner: false,
      debugShowMaterialGrid: false,
      checkerboardOffscreenLayers: false,
      checkerboardRasterCacheImages: false,
      theme: ThemeData.dark(),
      home: const MainMenu(title: 'Home'),
    );
  }
}
