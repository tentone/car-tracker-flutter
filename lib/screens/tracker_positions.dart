import 'package:cartracker/data/tracker.dart';
import 'package:cartracker/data/tracker_position.dart';
import 'package:cartracker/database/database.dart';
import 'package:cartracker/database/tracker_position_db.dart';
import 'package:cartracker/locale/locales.dart';
import 'package:flutter/material.dart';
import 'package:sqflite/sqflite.dart';
import 'package:url_launcher/url_launcher.dart';

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
        appBar: AppBar(
          title: Text(Locales.get('positions', context)),
        ),
        body: FutureBuilder(future: () async {
          Database? db = await DataBase.get();
          return TrackerPositionDB.list(db!, widget.tracker.uuid);
        }(), builder: (BuildContext context, AsyncSnapshot<List<TrackerPosition>> entries) {
          if (entries.data == null || entries.data!.isEmpty) {
            return Center(
                child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const Padding(child: Icon(Icons.gps_off, size: 60.0), padding: EdgeInsets.all(10.0)),
                Text(Locales.get('noElements', context)),
              ],
            ));
          }

          return ListView.builder(
              padding: const EdgeInsets.all(0),
              itemCount: entries.data!.length,
              itemBuilder: (BuildContext context, int index) {
                return SizedBox(
                    height: 80,
                    child: ListTile(
                      leading: const Icon(Icons.gps_fixed, size: 40.0),
                      title: Text(entries.data![index].timestamp.toString()),
                      subtitle: Text(entries.data![index].longitude.toString() + 'º ' + entries.data![index].latitude.toString() + 'º'),
                      onTap: () {
                        String url = entries.data![index].getGoogleMapsURL();
                        launch(url);
                      },
                    ));
              });
        }));
  }
}
