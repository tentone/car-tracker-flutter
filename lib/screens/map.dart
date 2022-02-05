import 'dart:typed_data';

import 'package:cartracker/data/tracker.dart';
import 'package:cartracker/data/tracker_position.dart';
import 'package:cartracker/database/database.dart';
import 'package:cartracker/database/tracker_db.dart';
import 'package:cartracker/database/tracker_position_db.dart';
import 'package:cartracker/utils/data-validator.dart';
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

  void onStyleLoaded() {
    this.addImageFromAsset("car-sdf", "assets/symbols/custom-icon.png");
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

  /// Get current position of the tracker, otherwise a default location is returned
  Future<Position> getPosition() async {
    bool serviceEnabled = await Geolocator.isLocationServiceEnabled();
    if (!serviceEnabled) {
      return Future.error('Location services are disabled.');
    }

    LocationPermission  permission = await Geolocator.checkPermission();
    if (permission == LocationPermission.denied) {
      permission = await Geolocator.requestPermission();
      if (permission == LocationPermission.denied) {
        return Future.error('Location permissions are denied');
      }
    }

    if (permission == LocationPermission.deniedForever) {
      return Future.error('Location permissions are permanently denied, we cannot request permissions.');
    }

    return Geolocator.getCurrentPosition(desiredAccuracy: LocationAccuracy.best);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: <Widget>[
          ChangeNotifierProvider(
            create: (context) {
              TrackerDB.changeNotifier = ChangeNotifier();
              return TrackerDB.changeNotifier;
            },
            child: Consumer<ChangeNotifier>(builder: (context, ChangeNotifier _, child) {
              return FutureBuilder(
                  future: this.getPosition(),
                  builder: (BuildContext context, AsyncSnapshot<Position> data) {
                    LatLng position = data.hasData ? LatLng(data.data!.latitude, data.data!.longitude) : const LatLng(0, 0);

                    return MapboxMap(
                      accessToken: Global.MAPBOX_TOKEN,
                      trackCameraPosition: true,
                      myLocationEnabled: true,
                      myLocationTrackingMode: MyLocationTrackingMode.Tracking,
                      initialCameraPosition: CameraPosition(
                          target: position,
                          zoom: 10),
                      onMapCreated: onMapCreated,
                      onStyleLoadedCallback: onStyleLoaded,
                    );
                  });
            }),
          ),

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
        },
        child: const Icon(Icons.gps_not_fixed),
      ),
    );
  }
}
