import 'package:flutter/material.dart';
import 'package:mapbox_gl/mapbox_gl.dart';

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
        Container(
          width: 90,
          height: 90,
          color: Colors.green,
        ),
        Container(
          width: 80,
          height: 80,
          color: Colors.blue,
        )

      ],
    );
  }
}