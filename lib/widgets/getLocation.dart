import 'package:geolocator/geolocator.dart';
import 'package:teamsta/constants/prefrence_box.dart';
import 'package:teamsta/constants/global_strings.dart';

class GetLocation {
  getLocation() async {
    bool serviceEnabled;
    LocationPermission permission;

    serviceEnabled = await Geolocator.isLocationServiceEnabled();
    if (!serviceEnabled) {
      permission = await Geolocator.requestPermission();
    }

    permission = await Geolocator.checkPermission();
    if (permission == LocationPermission.denied) {
      permission = await Geolocator.requestPermission();
      if (permission == LocationPermission.denied) {
        return Future.error('Location permissions are denied');
      }
    }

    if (permission == LocationPermission.deniedForever) {
      return Future.error(
          'Location permissions are permanently denied, we cannot request permissions.');
    }

    Position position = await Geolocator.getCurrentPosition(
      desiredAccuracy: LocationAccuracy.bestForNavigation,
    );
    userLat = position.latitude;
    userLng = position.longitude;
    if (userLat != null && userLng != null) {
      boxLastLocation.write('lat', userLat);
      boxLastLocation.write('lng', userLng);
    }
  }

  double calculateDistance(
    lat2,
    lon2,
  ) {
    dynamic lat1;
    dynamic lon1;
    // var p = 0.017453292519943295;
    // var a = 0.5 -
    //     cos((lat2 - lat1) * p) / 2 +
    //     cos(lat1 * p) * cos(lat2 * p) * (1 - cos((lon2 - lon1) * p)) / 2;
    // double km = 12742 * asin(sqrt(a));
    // double miles = km / 1.609344;
    // double roundedMiles = double.parse(miles.toStringAsFixed(1));
    // return roundedMiles;
    if (latUpdate == true) {
      lat1 = lat;
      lon1 = lng;
    } else if (boxLastLocation.read('lat') != null) {
      lat1 = boxLastLocation.read('lat');
      lon1 = boxLastLocation.read('lng');
      lat = boxLastLocation.read('lat');
      lng = boxLastLocation.read('lng');
    } else {
      lat1 = userLat;
      lon1 = userLng;
      lat = userLat;
      lng = userLng;
    }

    double distanceInMeters =
        Geolocator.distanceBetween(lat1, lon1, lat2, lon2);
    double km = distanceInMeters / 1000;
    double miles = km / 1.609344;
    double roundedMiles = double.parse(miles.toStringAsFixed(1));
    return roundedMiles;
  }
}
