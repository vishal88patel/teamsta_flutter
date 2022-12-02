import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:teamsta/constants/export_constants.dart';
import 'package:http/http.dart' as http;

import '../models/teamModel.dart';

class GetTeamInfoController extends GetxController {
  var teamInfo = RxList<TeamModel>().obs;
  var queryTeamInfo = RxList<TeamModel>().obs;

  TextEditingController homeSearchController = TextEditingController();

  RxBool isLoading = false.obs;

  @override
  void onInit() {
    // getTeamInfo();
    super.onInit();
  }

//* Get all team info
  getTeamInfo() async {
    final url = baseUrl + "teams";

    final newUrl = Uri.parse(url);

    Map<String, String> appHeaders = {
      'Content-Type': 'application/json',
      'App-Key': env("APP_KEY"),
      'Accept': 'application/json',
      "authorization": "Bearer $accessToken",
    };

    final response = await http.get(
      newUrl,
      headers: appHeaders,
    );
    final data = json.decode(response.body);
    isLoading.toggle();
    try {
      switch (response.statusCode) {
        case 200:
          print("Team Info===>>> ${data['teams']}");
          teamInfo.value.clear();
          for (Map<String, dynamic> item in data["teams"]) {
            final response = TeamModel.fromJson(item);
            if (response.isApproved == "approved") {
              await response.getTheDistance();
              teamInfo.value.add(response);
            }
          }
          teamInfo.value.sort((a, b) {
            if (a.distance == null) {
              return 1;
            } else if (b.distance == null) {
              return -1;
            } else {
              return a.distance!.compareTo(b.distance!);
            }
          });

          isLoading.toggle();
          break;
        case 401:
          boxAccessToken.erase();
          accessToken = null;
          boxTeamMember.erase();
          Get.offAllNamed("/login");

          break;
        default:
          isLoading.toggle();
          Get.snackbar(
              response.statusCode.toString(), response.reasonPhrase.toString(),
              colorText: Colors.white, duration: Duration(seconds: 3));
      }
    } catch (e) {
      Get.snackbar('Error', e.toString(),
          colorText: Colors.white, duration: Duration(seconds: 3));
    }
  }
}
