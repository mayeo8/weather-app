import 'package:geolocator/geolocator.dart';

class Location {
  double? latitude;
  double? longitude;

  Future<void> getLocation() async {
    await locationServiceStatus();
    await checkLocationPermission();
    try {
      Position position = await Geolocator.getCurrentPosition(
          desiredAccuracy: LocationAccuracy.high);
      latitude = position.latitude;
      longitude = position.longitude;
    } catch (e) {
      print(e);
    }
  }

  Future<void> checkLocationPermission() async {
    LocationPermission permission = await Geolocator.requestPermission();
    print('Current Location Permission Status $permission');
  }

  Future<void> locationServiceStatus() async {
    bool isLocationServiceEnabled = await Geolocator.isLocationServiceEnabled();
    print('Current Location Status $isLocationServiceEnabled');
  }
}
