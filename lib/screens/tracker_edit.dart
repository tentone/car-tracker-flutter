import 'package:flutter/material.dart';

class TrackerEditScreen extends StatefulWidget {
  const TrackerEditScreen({Key? key}) : super(key: key);

  @override
  State<TrackerEditScreen> createState() {
    return TrackerEditScreenState();
  }
}

class TrackerEditScreenState extends State<TrackerEditScreen> {
  @override
  Widget build(BuildContext context) {
    return FloatingActionButton(onPressed: () {
      Navigator.pop(context);
    });
  }
}