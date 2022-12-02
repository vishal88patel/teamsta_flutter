import 'dart:convert';

import 'package:get/get.dart';
import 'package:teamsta/constants/export_constants.dart';
import 'package:http/http.dart' as http;

import '../models/userModel.dart';

class FollowingController {
// headers
  Map<String, String> headers = {
    'Accept': 'application/json',
    "App-Key": env("APP_KEY"),
    'Authorization': 'Bearer $accessToken',
  };

  // follow a club
  followClub(int teamId) async {
    final url = baseUrl + "user/follow_team/$teamId";

    final newUrl = Uri.parse(url);

    final response = await http.post(newUrl, headers: headers);

    var jsonResponse = json.decode(response.body);

    try {
      print(teamId);
      switch (response.statusCode) {
        case 200:
          print(jsonResponse);
          userGetController.getUserInfo();
          break;
           case 401:
          boxAccessToken.erase();
          accessToken = "";
          boxTeamMember.erase();
          Get.offAllNamed("/login");

          break;
        default:
          Get.snackbar(
              response.statusCode.toString(), response.reasonPhrase.toString());
      }
    } catch (e) {
      print(e.toString());
    }
  }

  // unfollow a club
  unfollowClub(
    int teamId,
    int index,
  ) async {
    final url = baseUrl + "user/unfollow_team/$teamId";

    final newUrl = Uri.parse(url);

    final response = await http.post(newUrl, headers: headers);

    var jsonResponse = json.decode(response.body);

    try {
      print(teamId);
      switch (response.statusCode) {
        case 200:
          print(jsonResponse);
          userGetController.userInfo.value.removeAt(index);
          break;
           case 401:
          boxAccessToken.erase();
          accessToken = "";
          boxTeamMember.erase();
          Get.offAllNamed("/login");

          break;
        default:
          Get.snackbar(
              response.statusCode.toString(), response.reasonPhrase.toString());
      }
    } catch (e) {
      print(e.toString());
    }
  }
}
