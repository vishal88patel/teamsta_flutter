import 'package:get/get.dart';
import 'package:google_place/google_place.dart';

import '../constants/export_constants.dart';

class LocationService {
  textSearch(String location) async {
    // var googlePlace = GooglePlace(dotenv.env['GoogleKey']!);
    var googlePlace = GooglePlace(env('GoogleKey'));
    var result = await googlePlace.search.getTextSearch(location);
    if (result!.results == null) {
      Get.snackbar("Bad Data", "Seems the address can't be found");
    } else {
      var placeId = result.results!.first.placeId;
      lat = result.results!.first.geometry!.location!.lat;
      lng = result.results!.first.geometry!.location!.lng;

      return placeId;
    }
  }
}
