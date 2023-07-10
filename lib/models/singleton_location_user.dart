import 'package:latlong2/latlong.dart';

class SingletonLocationUser {
  //here is a service auth when the user login
  //then, can use stories values inside whole code
  //like bloc, pages, services...

  LatLng? _userLatLng;

  static final SingletonLocationUser _singletonUser =
      SingletonLocationUser._internal();

  factory SingletonLocationUser() {
    return _singletonUser;
  }

  SingletonLocationUser._internal();

  setLocationUser(LatLng value) {
    _userLatLng = value;
  }

  removeLocationUser() {
    _userLatLng = null;
  }

  LatLng? get userLocation => _userLatLng;
}
