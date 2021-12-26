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
    return MapboxMap(
      accessToken: Global.MAPBOX_TOKEN,
      trackCameraPosition: true,
      initialCameraPosition:
      const CameraPosition(target: LatLng(35.0, 135.0), zoom: 5),
    );
  }
}