import 'dart:io';

import 'package:geolocator/geolocator.dart';

File? image;
String defaultImage =
    'https://firebasestorage.googleapis.com/v0/b/fresh-mart-authservice.appspot.com/o/Placeholder%2F115-1150152_default-profile-picture-avatar-png-green.png?alt=media&token=75be0bfb-73b0-4010-8ff0-044f2cbdc4ad';

bool isLoadingEpsu = false;
bool isLoadingOTPage = false;
bool isLoadingLogin = false;
bool isLoadingEditProfile = false;
bool isLoadingAddress = false;
String orderAddress = '';
late double lattitude;
late double longtiude;

Future setCurrentLocation() async {
  Position position = await Geolocator.getCurrentPosition(
      desiredAccuracy: LocationAccuracy.best);
  if (position != null) {
    lattitude = position.latitude;
    longtiude = position.longitude;
  }
}
