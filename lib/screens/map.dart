import 'dart:typed_data';

import 'package:cartracker/data/tracker.dart';
import 'package:cartracker/data/tracker_position.dart';
import 'package:cartracker/database/database.dart';
import 'package:cartracker/database/tracker_db.dart';
import 'package:cartracker/database/tracker_position_db.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:geolocator/geolocator.dart';
import 'package:mapbox_gl/mapbox_gl.dart';
import 'package:sqflite/sqflite.dart';
import 'package:url_launcher/url_launcher.dart';
import '../global.dart';

class MapScreen extends StatefulWidget {
  const MapScreen({Key? key}) : super(key: key);

  @override
  State<MapScreen> createState() {
    return MapScreenState();
  }
}

class MapScreenState extends State<MapScreen> {
  late MapboxMapController controller;

  /// Method called when map is created to draw the tracker locations.
  ///
  /// Trackers are coded by their color
  Future<void> onMapCreated(MapboxMapController controller) async {
    this.controller = controller;
    this.controller.onSymbolTapped.add(onSymbolTapped);

    Database? db = await DataBase.get();
    List<TrackerLastPosition> entries =
        await TrackerPositionDB.getAllTrackerLastPosition(db!);

    for (int i = 0; i < entries.length; i++) {
      Symbol symbol = await this.controller.addSymbol(
          SymbolOptions(
              geometry: LatLng(
                  entries[i].position.latitude, entries[i].position.longitude),
              iconImage: 'car-15',
              iconSize: 2,
              iconColor: Color(entries[i].tracker.color).toHexStringRGB(),
              textField: entries[i].tracker.name,
              textSize: 16,
              textOffset: const Offset(0, 1.3)),
          {'position': entries[i].position, 'tracker': entries[i].tracker});
    }
  }

  /// Adds an asset image to the currently displayed style
  Future<void> addImageFromAsset(String name, String assetName) async {
    final ByteData bytes = await rootBundle.load(assetName);
    final Uint8List list = bytes.buffer.asUint8List();
    return controller.addImage(name, list);
  }

  /// Method called when a tracker is pressed
  ///
  /// Open the tracker location in external application.
  void onSymbolTapped(Symbol symbol) {
    TrackerPosition position = symbol.data!['position'];
    String url = position.getGoogleMapsURL();
    launch(url);
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
        future: Geolocator.getCurrentPosition(
            desiredAccuracy: LocationAccuracy.high),
        builder: (BuildContext context, AsyncSnapshot<Position> data) {
          if (!data.hasData) {
            return Container();
          }

          return Scaffold(
            body: Stack(
              children: <Widget>[
                MapboxMap(
                  accessToken: Global.MAPBOX_TOKEN,
                  trackCameraPosition: true,
                  myLocationEnabled: true,
                  myLocationTrackingMode: MyLocationTrackingMode.TrackingGPS,
                  initialCameraPosition: CameraPosition(
                      target: LatLng(data.data!.latitude, data.data!.longitude),
                      zoom: 10),
                  onMapCreated: onMapCreated,
                ),
              ],
            ),
            floatingActionButton: FloatingActionButton(
              onPressed: () async {
                Database? db = await DataBase.get();
                List<Tracker> trackers = await TrackerDB.list(db!);
                for (int i = 0; i < trackers.length; i++) {
                  trackers[i].requestLocation();
                }
              },
              child: const Icon(Icons.gps_not_fixed),
            ),
          );
        });
  }
}
