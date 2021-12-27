import 'package:cartracker/data/tracker.dart';
import 'package:cartracker/screens/tracker_edit.dart';
import 'package:flutter/material.dart';

class TrackerListScreen extends StatefulWidget {
  const TrackerListScreen({Key? key}) : super(key: key);

  @override
  State<TrackerListScreen> createState() {
    return TrackerListScreenState();
  }
}

class TrackerListScreenState extends State<TrackerListScreen> {
  @override
  Widget build(BuildContext context) {
    final List<Tracker> entries = [Tracker(), Tracker()];

    return ListView.builder(
        padding: const EdgeInsets.all(0),
        itemCount: entries.length,
        itemBuilder: (BuildContext context, int index) {
          return SizedBox(
            height: 80,
            child: ListTile(
              leading: Image.network('https://flutter.github.io/assets-for-api-docs/assets/widgets/owl-2.jpg'),
              title: Text(entries[index].uuid),
              subtitle: Text(entries[index].uuid),
              onTap: () => {
                Navigator.push(context, MaterialPageRoute(builder: (context) {
                  return const TrackerEditScreen();
                }));
              },
            )
          );
        }
    );
  }
}