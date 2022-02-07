import 'package:cartracker/data/tracker.dart';
import 'package:cartracker/data/tracker_message.dart';
import 'package:cartracker/database/database.dart';
import 'package:cartracker/database/tracker_message_db.dart';
import 'package:cartracker/locale/locales.dart';
import 'package:flutter/material.dart';
import 'package:sqflite/sqflite.dart';

class TrackerMessageListScreen extends StatefulWidget {
  final Tracker tracker;

  const TrackerMessageListScreen(this.tracker, {Key? key}) : super(key: key);

  @override
  State<TrackerMessageListScreen> createState() {
    return TrackerMessageListScreenState();
  }
}

class TrackerMessageListScreenState extends State<TrackerMessageListScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text(Locales.get('messages', context)),
        ),
        body: FutureBuilder(future: () async {
          Database? db = await DataBase.get();
          return TrackerMessageDB.list(db!, widget.tracker.uuid);
        }(), builder: (BuildContext context, AsyncSnapshot<List<TrackerMessage>> entries) {
          if (entries.data == null || entries.data!.isEmpty) {
            return Center(
                child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const Padding(child: Icon(Icons.sms, size: 60.0), padding: EdgeInsets.all(10.0)),
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
                      title: Text(entries.data![index].timestamp.toString()),
                      leading: Icon(entries.data![index].direction == MessageDirection.SENT ? Icons.call_made : Icons.call_received, size: 40.0),
                      subtitle: Text(entries.data![index].data),
                    ));
              });
        }));
  }
}
