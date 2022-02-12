import 'package:cartracker/data/settings.dart';
import 'package:cartracker/locale/locales.dart';
import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

import '../global.dart';

class SettingsScreen extends StatefulWidget {
  const SettingsScreen({Key? key}) : super(key: key);

  @override
  State<SettingsScreen> createState() {
    return SettingsScreenState();
  }
}

class SettingsScreenState extends State<SettingsScreen> {
  final formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Form(
      key: formKey,
      child: ListView(
        padding: const EdgeInsets.fromLTRB(10, 0, 10, 0),
        children: [
          PopupMenuButton<ThemeMode>(
            child: ListTile(
              contentPadding: EdgeInsets.zero,
              leading: const Icon(Icons.dark_mode),
              title: Text(Locales.get('theme', context)),
              trailing: Text(Locales.get(Settings.global.theme.name, context)),
            ),
            offset: const Offset(0, kToolbarHeight),
            onSelected: (ThemeMode result) {
              setState(() {
                Settings.global.theme = result;
              });
            },
            itemBuilder: (BuildContext context) => <PopupMenuEntry<ThemeMode>>[
              PopupMenuItem<ThemeMode>(
                value: ThemeMode.system,
                child: Text(Locales.get('system', context)),
              ),
              PopupMenuItem<ThemeMode>(
                value: ThemeMode.dark,
                child: Text(Locales.get('dark', context)),
              ),
              PopupMenuItem<ThemeMode>(
                value: ThemeMode.light,
                child: Text(Locales.get('light', context)),
              ),
            ],
          ),
          PopupMenuButton<String>(
            child: ListTile(
              contentPadding: EdgeInsets.zero,
              leading: const Icon(Icons.flag),
              trailing: Text(Locales.get(Locales.code, context)),
              title: Text(Locales.get('locale', context)),
            ),
            offset: const Offset(0, kToolbarHeight),
            onSelected: (String result) {
              setState(() {
                Settings.global.locale = result;
              });
            },
            itemBuilder: (BuildContext context) => <PopupMenuEntry<String>>[
              PopupMenuItem<String>(
                value: 'en',
                child: Text(Locales.get('en', context)),
              ),
              PopupMenuItem<String>(
                value: 'pt',
                child: Text(Locales.get('pt', context)),
              ),
            ],
          ),
          ListTile(
            contentPadding: EdgeInsets.zero,
            leading: const Icon(Icons.album_outlined),
            trailing: const Text(Global.VERSION),
            title: Text(Locales.get('version', context)),
          ),
          ListTile(
            contentPadding: EdgeInsets.zero,
            leading: const Icon(Icons.document_scanner),
            title: Text(Locales.get('license', context)),
            onTap: () {
              launch('https://github.com/tentone/car-tracker-flu');
            },
          )
        ],
      ),
    ));
  }
}
