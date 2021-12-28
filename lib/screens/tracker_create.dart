import 'package:cartracker/locale/locales.dart';
import 'package:flutter/material.dart';

class TrackerCreateScreen extends StatefulWidget {
  const TrackerCreateScreen({Key? key}) : super(key: key);

  @override
  State<TrackerCreateScreen> createState() {
    return TrackerCreateScreenState();
  }
}

class TrackerCreateScreenState extends State<TrackerCreateScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(Locales.get('createTracker', context)),
      ),
      body: FloatingActionButton(onPressed: () {
        Navigator.pop(context);
      }),
    );
  }
}