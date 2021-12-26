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
    final List<String> entries = <String>['A', 'B', 'C', 'A', 'B', 'C', 'A', 'B', 'C', 'A', 'B', 'C', 'A', 'B', 'C', 'A', 'B', 'C'];
    final List<int> colorCodes = <int>[600, 500, 100, 600, 500, 100, 600, 500, 100, 600, 500, 100, 600, 500, 100, 600, 500, 100,];

    return ListView.builder(
        padding: const EdgeInsets.all(0),
        itemCount: entries.length,
        itemBuilder: (BuildContext context, int index) {
          return Container(
            height: 80,

            // color: Colors.amber[colorCodes[index]],
            child: ListTile(
              leading: Image.network('https://flutter.github.io/assets-for-api-docs/assets/widgets/owl-2.jpg'),
              title: Text(entries[index]),
              subtitle: Text('Music by Julie Gable. Lyrics by Sidney Stein.'),
              onTap: () => {

              },
            )
          );
        }
    );
  }
}