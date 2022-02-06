import 'dart:typed_data';

import 'package:cartracker/data/tracker.dart';
import 'package:cartracker/data/tracker_position.dart';
import 'package:cartracker/database/database.dart';
import 'package:cartracker/database/tracker_db.dart';
import 'package:cartracker/database/tracker_position_db.dart';
import 'package:cartracker/locale/locales.dart';
import 'package:cartracker/utils/data-validator.dart';
import 'package:cartracker/utils/geolocation.dart';
import 'package:cartracker/widget/modal.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:geolocator/geolocator.dart';
import 'package:mapbox_gl/mapbox_gl.dart';
import 'package:provider/provider.dart';
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
  /// Object to manipulate the map view
  late MapboxMapController controller;

  /// Method called when map is created to draw the tracker locations.
  ///
  /// Trackers are coded by their color
  Future<void> onMapCreated(MapboxMapController controller) async {
    this.controller = controller;
    this.controller.onSymbolTapped.add(onSymbolTapped);
  }

  /// Method called after the map style is loaded
  Future<void> onStyleLoaded() async {
    this.addImage(this.controller, "car-sdf", "assets/sdf/car-sdf.png");
    await this.drawMarkers(this.controller);
  }

  /// Draw markers for each tracker that has position data.
  Future<void> drawMarkers(MapboxMapController controller) async {
    Database? db = await DataBase.get();
    List<TrackerLastPosition> entries = await TrackerPositionDB.getAllTrackerLastPosition(db!);

    for (int i = 0; i < entries.length; i++) {
      await controller.addSymbol(
          SymbolOptions(
              geometry: LatLng(entries[i].position.latitude, entries[i].position.longitude),
              iconImage: 'car-sdf',
              iconSize: 1.1,
              iconColor: Color(entries[i].tracker.color).toHexStringRGB(),
              textField: entries[i].tracker.name,
              textSize: 16,
              textOffset: const Offset(0, 2.0)),
          {'position': entries[i].position, 'tracker': entries[i].tracker});
    }
  }

  /// Adds an asset image to the controller style
  Future<void> addImage(MapboxMapController controller, String name, String path, {bool sdf = true}) async {
    final ByteData bytes = await rootBundle.load(path);
    final Uint8List list = bytes.buffer.asUint8List();
    return controller.addImage(name, list, sdf);
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
    return Scaffold(
      body: Stack(
        children: <Widget>[
          FutureBuilder(
              future: Geolocation.getPosition(),
              builder: (BuildContext context, AsyncSnapshot<Position> data) {
                LatLng position = data.hasData ? LatLng(data.data!.latitude, data.data!.longitude) : const LatLng(0, 0);

                return ChangeNotifierProvider(
                  create: (context) {
                    TrackerDB.changeNotifier = ChangeNotifier();
                    return TrackerDB.changeNotifier;
                  },
                  child: Consumer<ChangeNotifier>(builder: (BuildContext context, ChangeNotifier notifier, Widget? child) {
                    return MapboxMap(
                      accessToken: Global.MAPBOX_TOKEN,
                      trackCameraPosition: true,
                      myLocationEnabled: true,
                      myLocationTrackingMode: MyLocationTrackingMode.Tracking,
                      initialCameraPosition: CameraPosition(target: position, zoom: 10),
                      onMapCreated: onMapCreated,
                      onStyleLoadedCallback: onStyleLoaded,
                    );
                  }),
                );
              })
        ],
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () async {
          Database? db = await DataBase.get();
          List<Tracker> trackers = await TrackerDB.list(db!);
          for (int i = 0; i < trackers.length; i++) {
            if (DataValidator.phoneNumber(trackers[i].phoneNumber)) {
              trackers[i].requestLocation();
            }
          }
          Modal.toast(context, Locales.get('requestedPosition', context));
        },
        child: const Icon(Icons.gps_fixed),
      ),
    );
  }
}
