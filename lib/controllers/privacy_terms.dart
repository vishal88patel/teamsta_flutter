import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:teamsta/constants/export_constants.dart';
import 'package:http/http.dart' as http;

class PrivacyTermsController extends GetxController {
  Map<String, String> appHeaders = {
    'Content-Type': 'application/json',
    'Accept': 'application/json',
  };

  RxBool teamLoading = true.obs;
  RxBool privacyLoading = true.obs;

  @override
  void onInit() {
    getTerms();
    getPrivacy();
    super.onInit();
  }

  // get the terms and conditions
  getTerms() async {
    final url = baseUrl + "terms_and_conditions";

    final newUrl = Uri.parse(url);

    final response = await http.get(
      newUrl,
      headers: appHeaders,
    );

    var jsonResponse = json.decode(response.body);

    switch (response.statusCode) {
      case 200:
        terms = jsonResponse["terms_and_conditions"][0]["text"];
        teamLoading.toggle();
        break;

      case 401:
        Get.snackbar("You Are unhorsed to view this data", "Please Login",
            colorText: Colors.white, duration: Duration(seconds: 3));
        Future.delayed(Duration(seconds: 3), () => Get.offAllNamed('/login'));
        break;
      default:
        print("${response.statusCode} ${response.reasonPhrase}");
    }
  }
// get privacy policy
  getPrivacy() async {
    final url = baseUrl + "privacy_policy";

    final newUrl = Uri.parse(url);

    final response = await http.get(
      newUrl,
      headers: appHeaders,
    );

    var jsonResponse = json.decode(response.body);

    switch (response.statusCode) {
      case 200:
        privacy = jsonResponse["privacy_policies"][0]["text"];
        privacyLoading.toggle();
        break;

      case 401:
        Get.snackbar("You Are unhorsed to view this data", "Please Login",
            colorText: Colors.white, duration: Duration(seconds: 3));
        Future.delayed(Duration(seconds: 3), () => Get.offAllNamed('/login'));
        break;
      default:
        print("${response.statusCode} ${response.reasonPhrase}");
    }
  }
}
