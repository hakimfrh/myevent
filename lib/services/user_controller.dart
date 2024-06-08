import 'package:geolocator/geolocator.dart';
import 'package:myevent/services/firebase.dart';
import 'package:myevent/services/location.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../model/user.dart';

class UserController {
  static final UserController _instance = UserController._internal();

  factory UserController() {
    return _instance;
  }

  UserController._internal();

  User? user;
  double? latitude;
  double? longitude;
  String? cityName;

  void clearUser() {
    user = null;
  }

  void logout() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.remove('login');
    await prefs.remove('pass');
    FirebaseController.logout();
    clearUser();
  }

  Future<String> refreshLocation() async {
    latitude = null;
    longitude = null;
    cityName = null;

    try {
      LocationService locationService = LocationService();
      Position position = await locationService.getCurrentLocation();
      cityName = await locationService.getCityName(position);
      latitude = position.latitude;
      longitude = position.longitude;
      return 'ok';
    } catch (e) {
      return e.toString();
    }
  }
}
