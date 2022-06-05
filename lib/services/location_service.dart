import 'dart:async';

import 'package:location/location.dart';

import '../models/user_location.dart';

class LocationService {
  late UserLocation _currentLocation;

  var location = Location();
  StreamController<UserLocation> _locationController =
      StreamController<UserLocation>();

  Stream<UserLocation> get locationStream => _locationController.stream;

  LocationService() {
    // Request permission to use location
    location.requestPermission().then((granted) {
      if (granted == PermissionStatus.GRANTED) {
        // If granted listen to the onLocationChanged stream and emit over our controller
        location.onLocationChanged().listen((locationData) {
          if (locationData != null) {
            _locationController.add(UserLocation(
              locationData.latitude,
              locationData.longitude,
            ));
          }
        });
      }
    });
  }

  Future<UserLocation> getLocation() async {
    try {
      var userLocation = await location.getLocation();
      _currentLocation = UserLocation(
        userLocation.latitude,
        userLocation.longitude,
      );
    } on Exception catch (e) {
      print('Could not get location: ${e.toString()}');
    }

    return _currentLocation;
  }
}
