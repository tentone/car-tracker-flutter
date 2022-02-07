import 'package:cartracker/data/tracker.dart';
import 'package:cartracker/database/database.dart';
import 'package:cartracker/database/tracker_db.dart';
import 'package:cartracker/locale/locales.dart';
import 'package:cartracker/screens/tracker_edit.dart';
import 'package:cartracker/widget/modal.dart';
import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:provider/provider.dart';
import 'package:sqflite/sqflite.dart';

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
      body: ChangeNotifierProvider(create: (context) {
        TrackerDB.changeNotifier = ChangeNotifier();
        return TrackerDB.changeNotifier;
      }, child: Consumer<ChangeNotifier>(builder: (context, ChangeNotifier _, child) {
        return FutureBuilder(future: () async {
          Database? db = await DataBase.get();
          return TrackerDB.list(db!);
        }(), builder: (BuildContext context, AsyncSnapshot<List<Tracker>> entries) {
          if (entries.data == null || entries.data!.isEmpty) {
            return Center(
                child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const Padding(child: Icon(Icons.list_outlined, size: 60.0), padding: EdgeInsets.all(10.0)),
                Text(Locales.get('noTrackers', context)),
              ],
            ));
          }

          return ListView.builder(
              padding: const EdgeInsets.all(0),
              itemCount: entries.data!.length,
              itemBuilder: (BuildContext context, int index) {
                return SizedBox(
                    height: 80,
                    child: Slidable(
                        startActionPane: ActionPane(
                          motion: const ScrollMotion(),
                          children: [
                            SlidableAction(
                              onPressed: (BuildContext context) async {
                                Database? db = await DataBase.get();
                                await TrackerDB.delete(db!, entries.data![index].uuid);
                                Modal.toast(context, Locales.get('deletedSuccessfully', context));
                                setState(() {});
                              },
                              backgroundColor: Colors.redAccent,
                              foregroundColor: Colors.white,
                              icon: Icons.delete,
                              label: Locales.get('delete', context),
                            ),
                          ],
                        ),
                        child: ListTile(
                          leading: const Icon(Icons.gps_fixed, size: 40.0),
                          title: Text(entries.data![index].name),
                          subtitle: Text(entries.data![index].licensePlate),
                          onTap: () {
                            Navigator.push(context, MaterialPageRoute(builder: (BuildContext context) {
                              return TrackerEditScreen(entries.data![index]);
                            }));
                          },
                        )));
              });
        });
      })),
      floatingActionButton: FloatingActionButton(
        onPressed: () async {
          Tracker tracker = Tracker();
          Database? db = await DataBase.get();
          await TrackerDB.add(db!, tracker);

          Navigator.push(context, MaterialPageRoute(builder: (BuildContext context) {
            return TrackerEditScreen(tracker);
          }));
        },
        child: const Icon(Icons.add),
      ),
    );
  }
}
