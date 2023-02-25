import 'package:flutter/cupertino.dart';
import 'package:geolocator/geolocator.dart';

class LocationProvider with ChangeNotifier {
  LocationProvider() {
    handleLocation();
  }
  double desinationLat = 0.0;
  double destinationLong = 0.0;
  String address = '';

  late double lat;
  late double long;

  bool persmissionAllowed = false;
  bool isLoading = true;

  Future<void> handleLocation() async {
    Position position = await Geolocator.getCurrentPosition(
        desiredAccuracy: LocationAccuracy.best);
    if (position != null) {
      persmissionAllowed = true;
    }
  }

  Future<void> getCurrentPositions() async {
    Position position = await Geolocator.getCurrentPosition(
        desiredAccuracy: LocationAccuracy.best);
    if (position != null) {
      lat = position.latitude.toDouble();
      long = position.longitude.toDouble();
      isLoading = false;
      notifyListeners();
    } else {
      print('permission not allowed');
    }
  }

  setAddress(String locAddress) {
    address = locAddress;
    notifyListeners();
  }
}
