import 'package:cartracker/data/settings.dart';
import 'package:cartracker/locale/locales.dart';
import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

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
        padding: const EdgeInsets.fromLTRB(10, 0, 5, 0),
        children: [
          CheckboxListTile(
              contentPadding: EdgeInsets.zero,
              title: Text(Locales.get('darkMode', context)),
              value: Settings.global.darkMode,
              controlAffinity: ListTileControlAffinity.trailing,
              onChanged: (bool? value) {
                if (value != null) {
                  setState(() {
                    Settings.global.darkMode = value;
                  });
                }
              },
              secondary: const Icon(Icons.dark_mode)
          ),
          ListTile(
            contentPadding: EdgeInsets.zero,
            leading: Icon(Icons.document_scanner),
            title: Text(Locales.get('license', context)),
            onTap: () {
              launch('https://github.com/tentone/car-tracker-flu');
            },
          ),
          PopupMenuButton<String>(
            child: ListTile(
              contentPadding: EdgeInsets.zero,
              leading: Icon(Icons.flag),
              title: Text(Locales.get(Locales.code, context)),
            ),
            onSelected: (String result) { setState(() { Locales.setLocale(result); }); },
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
          )
        ],
      ),
    ));
  }
}
