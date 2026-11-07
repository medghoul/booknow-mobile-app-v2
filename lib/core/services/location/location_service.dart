import 'package:geolocator/geolocator.dart';

/// Where the phone is, asked only when the customer taps "Use my location".
class LocationService {
  const LocationService();

  /// Null when the permission is refused, location is off, or no fix comes in
  /// time. The caller has one thing to say about all of those.
  Future<({double lat, double lng})?> current() async {
    try {
      if (!await Geolocator.isLocationServiceEnabled()) return null;

      var permission = await Geolocator.checkPermission();
      if (permission == LocationPermission.denied) {
        permission = await Geolocator.requestPermission();
      }
      if (permission == LocationPermission.denied ||
          permission == LocationPermission.deniedForever) {
        return null;
      }

      // Coarse on purpose: "nearest shops" needs the neighbourhood, not the door.
      final position = await Geolocator.getCurrentPosition(
        locationSettings: const LocationSettings(
          accuracy: LocationAccuracy.low,
          timeLimit: Duration(seconds: 8),
        ),
      );
      return (lat: position.latitude, lng: position.longitude);
    } on Exception {
      return null;
    }
  }
}
