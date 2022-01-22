import 'package:cartracker/data/tracker.dart';
import 'package:cartracker/data/tracker_position.dart';
import 'package:cartracker/database/database.dart';
import 'package:cartracker/database/tracker_position_db.dart';
import 'package:flutter/material.dart';
import 'package:sqflite/sqflite.dart';

class TrackerPositionListScreen extends StatefulWidget {
  final Tracker tracker;

  const TrackerPositionListScreen(this.tracker, {Key? key}) : super(key: key);

  @override
  State<TrackerPositionListScreen> createState() {
    return TrackerPositionListScreenState();
  }
}

class TrackerPositionListScreenState extends State<TrackerPositionListScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: FutureBuilder(
          future: () async {
            Database? db = await DataBase.get();
            return TrackerPositionDB.list(db!, widget.tracker.uuid);
          }(),
          builder: (BuildContext context, AsyncSnapshot<List<TrackerPosition>> entries) {
            if (entries.data == null) {
              return const SizedBox();
            }

            return ListView.builder(
                padding: const EdgeInsets.all(0),
                itemCount: entries.data!.length,
                itemBuilder: (BuildContext context, int index) {
                  return SizedBox(
                      height: 80,
                      child: ListTile(
                        leading: const Icon(Icons.gps_fixed, size:40.0),
                        subtitle: Text(entries.data![index].longitude.toString() + 'º ' + entries.data![index].latitude.toString() + 'º'),
                        onTap: () {
                          String url = entries.data![index].getGoogleMapsURL();

                        },
                      )
                  );
                }
            );
          }
      )
    );
  }
}