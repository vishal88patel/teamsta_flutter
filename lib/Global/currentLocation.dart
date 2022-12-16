//   //* get the current location of the device.
//   import 'package:geolocator/geolocator.dart';

// getLocation() async {
//     bool serviceEnabled;
//     LocationPermission permission;
//     double? lat;
//     double? long;

//     // Test if location services are enabled.
//     serviceEnabled = await Geolocator.isLocationServiceEnabled();
//     if (!serviceEnabled) {
//       return Future.error('Location services are disabled.');
//     }

//     permission = await Geolocator.checkPermission();
//     if (permission == LocationPermission.denied) {
//       permission = await Geolocator.requestPermission();
//       if (permission == LocationPermission.denied) {
//         return Future.error('Location permissions are denied');
//       }
//     }

//     if (permission == LocationPermission.deniedForever) {
//       // Permissions are denied forever, handle appropriately.
//       return Future.error(
//           'Location permissions are permanently denied, we cannot request permissions.');
//     }
//     Position position = await Geolocator.getCurrentPosition(
//         desiredAccuracy: LocationAccuracy.high);
//     setState(() {
//       lat = position.latitude;
//       long = position.longitude;
//     });
//     List<Placemark> placemarks = await placemarkFromCoordinates(lat!, long!);
//     locationController.text = placemarks[0].street.toString();
//     cityController.text = placemarks[0].locality.toString();
//     countryController.text = placemarks[0].country.toString();
//     // return position
//   }