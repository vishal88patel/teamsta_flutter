import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_geocoding/google_geocoding.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

import '../constants/string_constants.dart';
import '../constants/strings.dart';

class GetLatLng{
  Future<LatLng?> getCoords(String addressFields) async {
    GeocodingResponse? response;

    try {
      response = await GoogleGeocoding(env('GoogleKey'))
          .geocoding
          .get(addressFields, []);
    } catch (e) {
      // Get.snackbar("Error", "Unable to match address");
      // Get.snackbar(
      //     StringConstants.ERROR, "Unable to find address",
      //     colorText: Colors.white);
      return null;
    }
    if (response == null ||
        response.results == null ||
        response.results!.isEmpty ||
        response.results![0].geometry == null ||
        response.results![0].geometry!.location == null) {
      // Get.snackbar("Error", "Unable to match address");
      // Get.snackbar(
      //     StringConstants.ERROR, "Unable to find address",
      //     colorText: Colors.white);
      return null;
    }

    return LatLng(response.results![0].geometry!.location!.lat!,
        response.results![0].geometry!.location!.lng!);
  }
}