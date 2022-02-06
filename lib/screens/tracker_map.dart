import 'dart:typed_data';

import 'package:cartracker/data/tracker.dart';
import 'package:cartracker/data/tracker_position.dart';
import 'package:cartracker/database/database.dart';
import 'package:cartracker/database/tracker_position_db.dart';
import 'package:cartracker/locale/locales.dart';
import 'package:cartracker/screens/tracker_positions.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:mapbox_gl/mapbox_gl.dart';
import 'package:sqflite/sqflite.dart';
import 'package:url_launcher/url_launcher.dart';

import '../global.dart';

class TrackerPositionMapScreen extends StatefulWidget {
  final Tracker tracker;

  const TrackerPositionMapScreen(this.tracker, {Key? key}) : super(key: key);

  @override
  State<TrackerPositionMapScreen> createState() {
    return TrackerPositionMapScreenState();
  }
}

class TrackerPositionMapScreenState extends State<TrackerPositionMapScreen> {
  /// Object to manipulate the map view
  late MapboxMapController controller;

  /// Position of the tracker
  late List<TrackerPosition> positions;

  /// Called when the map is created to display the trajectory of the tracker.
  Future<void> onMapCreated(MapboxMapController controller) async {
    this.controller = controller;
    this.controller.onSymbolTapped.add(onSymbolTapped);
  }

  /// Method called after the map style is loaded
  Future<void> onStyleLoaded() async {
    this.addImage(this.controller, "geo-sdf", "assets/sdf/geo-sdf.png");
    await this.drawTrajetory(this.controller, this.positions);
    await this.drawMarkers(this.controller, this.positions);
  }

  /// Draw markers for each position of the tracker.
  Future<void> drawMarkers(MapboxMapController controller, List<TrackerPosition> positions) async {
    for (int i = 0; i < positions.length; i++) {
      await controller.addSymbol(
          SymbolOptions(
            geometry: LatLng(positions[i].latitude, positions[i].longitude),
            iconImage: 'geo-sdf',
            iconSize: 0.8,
            iconColor: Color(widget.tracker.color).toHexStringRGB(),
            textField: positions[i].timestamp.toString(),
            textSize: 12,
            textOffset: const Offset(0, 2.2),
          ),
          {'position': positions[i]});
    }
  }

  /// Draw trajectory based on GPS points
  Future<void> drawTrajetory(MapboxMapController controller, List<TrackerPosition> positions) async {
    List<LatLng> points = [];
    for (int i = 0; i < positions.length; i++) {
      points.add(LatLng(positions[i].latitude, positions[i].longitude));
    }

    await controller.addLine(LineOptions(geometry: points, lineWidth: 1.0, lineOpacity: 1.0, draggable: false));
  }

  /// Method called when a tracker is pressed
  ///
  /// Open the tracker location in external application.
  void onSymbolTapped(Symbol symbol) {
    TrackerPosition position = symbol.data!['position'];
    String url = position.getGoogleMapsURL();
    launch(url);
  }

  /// Adds an asset image to the controller style
  Future<void> addImage(MapboxMapController controller, String name, String path, {bool sdf = true}) async {
    final ByteData bytes = await rootBundle.load(path);
    final Uint8List list = bytes.buffer.asUint8List();
    return controller.addImage(name, list, sdf);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text(Locales.get('positions', context)),
        ),
        floatingActionButton: FloatingActionButton(
          onPressed: () async {
            Navigator.push(context, MaterialPageRoute(builder: (BuildContext context) {
              return TrackerPositionListScreen(widget.tracker);
            }));
          },
          child: const Icon(Icons.list),
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
                const Padding(child: Icon(Icons.map, size: 60.0), padding: EdgeInsets.all(10.0)),
                Text(Locales.get('noElements', context)),
              ],
            ));
          }

          this.positions = entries.data!;

          return MapboxMap(
            accessToken: Global.MAPBOX_TOKEN,
            trackCameraPosition: true,
            myLocationEnabled: true,
            myLocationTrackingMode: MyLocationTrackingMode.Tracking,
            initialCameraPosition: CameraPosition(target: LatLng(this.positions[0].latitude, this.positions[0].longitude), zoom: 10),
            onMapCreated: onMapCreated,
            onStyleLoadedCallback: onStyleLoaded,
          );
        }));
  }
}
