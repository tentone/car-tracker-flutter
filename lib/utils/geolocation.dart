import 'package:geolocator/geolocator.dart';

class Geolocation {
  /// Get current position of the tracker, otherwise a default location is returned
  static Future<Position> getPosition() async {
    bool serviceEnabled = await Geolocator.isLocationServiceEnabled();
    if (!serviceEnabled) {
      return Future.error('Location services are disabled.');
    }

    LocationPermission permission = await Geolocator.checkPermission();
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
}
