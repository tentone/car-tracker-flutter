import 'package:cartracker/locale/locales.dart';
import 'package:cartracker/screens/settings.dart';
import 'package:cartracker/screens/tracker_list.dart';
import 'package:flutter/material.dart';
import 'package:salomon_bottom_bar/salomon_bottom_bar.dart';

import 'map.dart';

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
  late IconData icon;

  MenuOption({Widget Function(BuildContext context)? builder, String? label, IconData? icon}) {
    this.builder = builder ?? (BuildContext builder) => Container();
    this.label = label ?? '';
    this.icon = icon ?? Icons.home;
  }
}

class MainMenuState extends State<MainMenu> {
  /// Index of the selected widget
  int selectedIndex = 0;

  /// Options available in the menu
  static List<MenuOption> options = <MenuOption>[
    MenuOption(label: 'trackers', builder: (BuildContext context) => const TrackerListScreen(), icon: Icons.gps_fixed),
    MenuOption(label: 'map', builder: (BuildContext context) => const MapScreen(), icon: Icons.map),
    MenuOption(label: 'settings', builder: (BuildContext context) => const SettingsScreen(), icon: Icons.settings)
  ];

  @override
  Widget build(BuildContext context) {
    List<SalomonBottomBarItem> buttons = [];
    for (int i = 0; i < options.length; i++) {
      buttons.add(SalomonBottomBarItem(
        icon: Icon(options[i].icon, size: 30.0,),
        title: Text(Locales.get(options[i].label, context)),
        selectedColor: Colors.blueAccent
      ));
    }

    return Scaffold(
      appBar: AppBar(
        title: Text(Locales.get('carTracker', context)),
      ),
      body: Center(
        child: options.elementAt(selectedIndex).builder(context),
      ),
      bottomNavigationBar: SalomonBottomBar(
        margin: EdgeInsets.zero,
        items: buttons,
        currentIndex: selectedIndex,
        onTap: (int index) => {
          setState(() {
            selectedIndex = index;
          })
        },
      ),
    );
  }
}
