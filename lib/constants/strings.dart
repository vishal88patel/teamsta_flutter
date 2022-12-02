import 'dart:io';

import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:teamsta/constants/export_constants.dart';

String baseUrl = 'https://teamsta.createaclients.co.uk/api/';
String imageBaseUrl = 'https://teamsta.createaclients.co.uk/';
String imageBaseWithout = 'https://teamsta.createaclients.co.uk';

String? accessToken = boxAccessToken.read("accessToken") != null
    ? boxAccessToken.read("accessToken")
    : null;
String? userId;

// Google lat and long for the maps
double? lat;
double? lng;

double? userLat;
double? userLng;
// set the user home or away
RxBool homeOrAway = false.obs;

// used to update the lat long on filter
 bool latUpdate = false;

// set the time for the user
//? don't know if im using this will check later.
extension TimeFormats on DateTime {
  String get asString {
    var formatter = NumberFormat('00');
    return formatter.format(hour) + ':' + formatter.format(minute);
  }
}
//TODO: check if these two are being used.

String? terms;

String? privacy;

// change the date format to the correct format
String? ukDateFormat;

// Keep the list of files coming from the fixtures and results
List<File> imageFile = [];

//* Images size and quality
int quality = 50;
int percentage = 60;

File? clubImage;
File? singleImage;

// Need to dispose the pending checker in the pending page.
RxBool pending = false.obs;

//TODO: check if this needs to be here.

//* App Key Android
String env(String key) {
  switch (key) {
    case "APP_KEY":
      return "base64:AhBe91u5Y0vvxrojQTgPkYrSJxM7P+iJaSi1sMYjTwA=";
    case "GoogleKey":
      return "AIzaSyBjaY2nvifrAJMYXnwyBazoUbPxKAggNVU";
    default:
      return "";
  }
}
