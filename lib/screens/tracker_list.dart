import 'package:cartracker/data/tracker.dart';
import 'package:cartracker/database/database.dart';
import 'package:cartracker/database/tracker_db.dart';
import 'package:cartracker/screens/tracker_create.dart';
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
    return Scaffold(
      body: FutureBuilder(
        future: TrackerDB.list(DataBase.db!),
        builder: (BuildContext context, AsyncSnapshot<List<Tracker>> entries) {
          return ListView.builder(
              padding: const EdgeInsets.all(0),
              itemCount: entries.data!.length,
              itemBuilder: (BuildContext context, int index) {
                return SizedBox(
                    height: 80,
                    child: ListTile(
                      leading: Image.network('https://flutter.github.io/assets-for-api-docs/assets/widgets/owl-2.jpg'),
                      title: Text(entries.data![index].uuid),
                      subtitle: Text(entries.data![index].uuid),
                      onTap: () {
                        Navigator.push(context, MaterialPageRoute(builder: (BuildContext context) {
                          return const TrackerEditScreen();
                        }));
                      },
                    )
                );
              }
          )
        }
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.push(context, MaterialPageRoute(builder: (BuildContext context) {
            return const TrackerCreateScreen();
          }));
        },
        child: const Icon(Icons.add),
      ),
    );
  }
}