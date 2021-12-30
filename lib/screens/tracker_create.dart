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
  final _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(Locales.get('createTracker', context)),
      ),
      body: Form(
        key: _formKey,
        child: Column(
          children: const <Widget>[
            // TODO <ADD CODE HERE>
          ],
        ),
      ),
    );
  }
}