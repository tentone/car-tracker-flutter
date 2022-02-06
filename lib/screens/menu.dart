import 'package:cartracker/locale/locales.dart';
import 'package:cartracker/screens/settings.dart';
import 'package:cartracker/screens/tracker_list.dart';
import 'package:flutter/material.dart';

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
  late Icon icon;

  MenuOption({Widget Function(BuildContext context)? builder, String? label, Icon? icon}) {
    this.builder = builder ?? (BuildContext builder) => Container();
    this.label = label ?? '';
    this.icon = icon ?? Icon(Icons.home);
  }
}

class MainMenuState extends State<MainMenu> {
  /// Index of the selected widget
  int selectedIndex = 0;

  /// Options available in the meny
  static List<MenuOption> options = <MenuOption>[
    MenuOption(label: 'trackers', builder: (BuildContext context) => TrackerListScreen(), icon: Icon(Icons.gps_fixed)),
    MenuOption(label: 'map', builder: (BuildContext context) => MapScreen(), icon: Icon(Icons.map)),
    MenuOption(label: 'settings', builder: (BuildContext context) => SettingsScreen(), icon: Icon(Icons.settings))
  ];

  @override
  Widget build(BuildContext context) {
    List<BottomNavigationBarItem> buttons = [];
    for (int i = 0; i < options.length; i++) {
      buttons.add(BottomNavigationBarItem(
        icon: options[i].icon,
        label: Locales.get(options[i].label, context),
      ));
    }

    return Scaffold(
      appBar: AppBar(
        title: Text(Locales.get('carTracker', context)),
      ),
      body: Center(
        child: options.elementAt(selectedIndex).builder(context),
      ),
      bottomNavigationBar: BottomNavigationBar(
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
