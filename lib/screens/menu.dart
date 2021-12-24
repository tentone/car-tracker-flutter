import 'package:cartracker/locale/locales.dart';
import 'package:flutter/material.dart';

class MainMenu extends StatefulWidget {
  const MainMenu({Key? key}) : super(key: key);

  @override
  State<MainMenu> createState() {
    return MainMenuState();
  }
}

/// Class to represent menu options
class MenuOption {
  /// Widget to represent the menu option
  late Widget Function(BuildContext context) builder;

  /// Label of the option
  ///
  /// Labels are only translated in runtime.
  late String label;

  /// Icon to display in the options
  late Icon icon;

  MenuOption({Widget Function(BuildContext context) ?builder, String ?label, Icon ?icon}) {
    this.builder = builder ?? (BuildContext builder) => Container();
    this.label = label ?? '';
    this.icon = icon ?? Icon(Icons.home);
  };
}

class MainMenuState extends State<MainMenu> {
  /// Index of the selected widget
  int selectedIndex = 0;

  /// Options available in the meny
  static List<MenuOption> options = <MenuOption>[
    MenuOption (
      label: 'trackers',
      builder: (BuildContext context) => Text(Locales.get('trackers', context)),
      icon: Icon(Icons.gps_fixed)
    ),
    MenuOption (
        label: 'map',
        builder: (BuildContext context) => Text(Locales.get('map', context)),
        icon: Icon(Icons.map)
    ),
    MenuOption (
        label: 'trackers',
        builder: (BuildContext context) => Text(Locales.get('trackers', context)),
        icon: Icon(Icons.settings)
    )
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(Locales.get('carTracker', context)),
      ),
      body: Center(
        child: options.elementAt(selectedIndex).builder(context),
      ),
      bottomNavigationBar: BottomNavigationBar(
        items: <BottomNavigationBarItem>[
          BottomNavigationBarItem(
            icon: const Icon(Icons.gps_fixed),
            label: Locales.get('trackers', context),
          ),
          BottomNavigationBarItem(
            icon: const Icon(Icons.map),
            label: Locales.get('map', context),
          ),
          BottomNavigationBarItem(
            icon: const Icon(Icons.settings),
            label: Locales.get('settings', context),
          ),
        ],
        currentIndex: selectedIndex,
        onTap: (int index) => {
          setState(() {
            selectedIndex = index;
          });
        },
      ),
    );
  }
}