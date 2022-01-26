import 'package:cartracker/database/database.dart';
import 'package:cartracker/database/tracker_position_db.dart';
import 'package:flutter/material.dart';
import 'package:mapbox_gl/mapbox_gl.dart';
import 'package:sqflite/sqflite.dart';

import '../global.dart';

class MapScreen extends StatefulWidget {
  const MapScreen({Key? key}) : super(key: key);

  @override
  State<MapScreen> createState() {
    return MapScreenState();
  }
}

class MapScreenState extends State<MapScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: FutureBuilder(
          future: () async {
            Database? db = await DataBase.get();
            return TrackerPositionDB.getAllTrackerLastPosition(db!);
          }(),
          builder: (BuildContext context, AsyncSnapshot<List<TrackerLastPosition>> entries) {
            if (entries.data == null) {
              return const SizedBox();
            }

            return Stack(
              children: <Widget>[
                MapboxMap(
                  accessToken: Global.MAPBOX_TOKEN,
                  trackCameraPosition: true,
                  initialCameraPosition: const CameraPosition(target: LatLng(35.0, 135.0), zoom: 5),
                ),
                Container(
                  width: 100,
                  height: 100,
                  color: Colors.red,
                ),
              ],
            );
          }
      )
    );
    

  }
}