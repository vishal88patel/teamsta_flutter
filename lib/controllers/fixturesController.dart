import 'dart:convert';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:teamsta/constants/export_constants.dart';
import 'package:http/http.dart' as http;

import '../constants/string_constants.dart';
import '../models/fixtureModel.dart';

class FixturesController extends GetxController {
  var fixtureInfo = RxList<FixtureModel>().obs;

  RxBool isLoading = false.obs;

//* create a fixture
  Future<void> fixtureCreate({
    required String vs,
    required String date,
    required String time,
    required String addressLine1,
    required String addressLine2,
    required String town,
    required String county,
    required String postCode,
    required String description,
    required String isHome,
    List<File>? imageFile,
  }) async {
    final url = baseUrl + "fixtures";

    final newUrl = Uri.parse(url);

    http.Response response;
    isLoading.toggle();
    if (imageFile!.isEmpty) {
      Map<String, String> appHeaders = {
        'Content-Type': 'application/json',
        'App-Key': env("APP_KEY"),
        'Accept': 'application/json',
        "authorization": "Bearer $accessToken",
      };

      response = await http.post(newUrl,
          headers: appHeaders,
          body: jsonEncode(
            {
              'vs': vs,
              'date': date,
              'time': time,
              'description': description,
              'is_home': isHome,
              'address_line_1': addressLine1,
              'address_line_2': addressLine2 == "" ? null : addressLine2,
              'town_or_city': town,
              'county': county,
              'postcode': postCode,
            },
          ));
    } else {
      Map<String, String> appHeaders = {
        'Content-Type': 'multipart/form-data',
        // 'App-Key': dotenv.env['APP_KEY']!,
        'App-Key': env("APP_KEY"),
        'Accept': 'application/json',
        "authorization": "Bearer $accessToken",
      };
      List<http.MultipartFile> newList = [];
      for (int i = 0; i < imageFile.length; i++) {
        newList.add(await http.MultipartFile.fromPath(
            'images[${i}]', imageFile[i].path));
      }
      final uploadRequest = await http.MultipartRequest(
        'POST',
        newUrl,
      )
        ..headers.addAll(appHeaders)
        ..fields.addAll({
          'vs': vs,
          'date': date,
          'time': time,
          'description': description,
          'is_home': isHome,
          'address_line_1': addressLine1,
          'address_line_2': addressLine2,
          'town_or_city': town,
          'county': county,
          'postcode': postCode,
        })
        ..files.addAll(
          newList,
        );

      response = await http.Response.fromStream(await uploadRequest.send());
    }

    var jsonResponse = json.decode(response.body);

    try {
      switch (response.statusCode) {
        case 201:
          isLoading.toggle();
          fixtureInfo.value.add(FixtureModel.fromJson(jsonResponse['fixture']));
          break;
        case 401:
          print("401: ${response.reasonPhrase}");
          break;

        default:
          print("${response.statusCode}: ${response.reasonPhrase}");
          Get.snackbar(
              'Error ${response.statusCode}', response.reasonPhrase.toString());
      }
    } catch (e) {
      print("Error ----> $e");
    }
  }

//* get all fixtures
  getFixtures() async {
    final url = baseUrl + "fixtures";

    final newUrl = Uri.parse(url);

    Map<String, String> appHeaders = {
      'Content-Type': 'application/json',
      // 'App-Key': dotenv.env['APP_KEY']!,
      'App-Key': env("APP_KEY"),
      'Accept': 'application/json',
      "authorization": "Bearer $accessToken",
    };

    final response = await http.get(
      newUrl,
      headers: appHeaders,
    );

    var jsonResponse = json.decode(response.body);

    try {
      switch (response.statusCode) {
        case 200:
          print(jsonResponse);
          fixtureInfo.value.clear();
          for (Map<String, dynamic> item in jsonResponse) {
            fixtureInfo.value.add(FixtureModel.fromJson(item));
          }
          break;
        case 401:
          boxAccessToken.erase();
          accessToken = "";
          boxTeamMember.erase();
          Get.offAllNamed("/login");

          break;

        default:
          Get.snackbar(
            "Error: ${response.statusCode}",
            response.reasonPhrase.toString(),
          );
      }
    } catch (e) {
      print("Error ----> $e");
    }
  }

//* update a fixture
  editFixture({
    required String vs,
    required String date,
    required String time,
    required String addressLine1,
    required String addressLine2,
    required String town,
    required String county,
    required String postCode,
    required String description,
    required int isHome,
    required int id,
    List<File>? editFile,
  }) async {
    final url = baseUrl + "fixtures/";

    final newUrl = Uri.parse(url + "$id");
    isLoading.toggle();
    Map<String, String> appHeaders = {
      'Content-Type': 'application/json',
      // 'App-Key': dotenv.env['APP_KEY']!,
      'App-Key': env("APP_KEY"),
      'Accept': 'application/json',
      "Authorization": "Bearer $accessToken",
    };

    final response = await http.put(
      newUrl,
      headers: appHeaders,
      body: jsonEncode(
        {
          'vs': vs,
          'date': date,
          'time': time,
          'description': description,
          'is_home': isHome,
          'address_line_1': addressLine1,
          'address_line_2': addressLine2 == "" ? null : addressLine2,
          'town_or_city': town,
          'county': county,
          'postcode': postCode,
        },
      ),
    );

    var jsonResponse = json.decode(response.body);

    try {
      switch (response.statusCode) {
        case 200:
          print(jsonResponse);
          // fixtureInfo.value.add(FixtureModel.fromJson(jsonResponse['fixture']));
          editFile!.length != 0
              ? updateFixtureIMages(id, editFile).then((_) async {
                  await getFixtures();
                  fixtureInfo.value.refresh();
                })
              : {getFixtures(), fixtureInfo.value.refresh()};
          isLoading.toggle();
          Get.back();
          break;
        case 401:
          boxAccessToken.erase();
          accessToken = "";
          boxTeamMember.erase();
          Get.offAllNamed("/login");

          break;
        default:
          isLoading.toggle();
          Get.snackbar(
            "Error: ${response.statusCode}",
            response.reasonPhrase.toString(),
          );

          print(response.statusCode);
          print(response.reasonPhrase);
      }
    } catch (e) {
      print("Error ----> $e");
    }
  }

  //* Add  Images to a fixture
  updateFixtureIMages(int fixtureId, List<File> editFile) async {
    List<http.MultipartFile> newList = [];
    for (int i = 0; i < editFile.length; i++) {
      newList.add(
          await http.MultipartFile.fromPath('images[$i]', editFile[i].path));
    }
    final url = baseUrl + "upload/fixture_images/$fixtureId";

    final newUrl = Uri.parse(url);

    Map<String, String> appHeaders = {
      'Content-Type': 'application/json',
      'App-Key': env("APP_KEY"),
      'Accept': 'application/json',
      "Authorization": "Bearer $accessToken",
    };

    final uploadRequest = await http.MultipartRequest(
      'POST',
      newUrl,
    )
      ..headers.addAll(appHeaders);

    if (newList.length > 0) {
      uploadRequest.files.addAll(
        newList,
      );
    }

    final response = await http.Response.fromStream(await uploadRequest.send());

    var jsonResponse = json.decode(response.body);

    try {
      switch (response.statusCode) {
        case 200:
          print(" Fixture Image: " + jsonResponse.toString());
          break;
        case 401:
          print("401: ${response.reasonPhrase}");
          break;
        default:
          print("${response.statusCode}: ${response.reasonPhrase}");
      }
    } catch (e) {
      print("Error ----> $e");
    }
  }

//* delete a fixture
  deleteFixture(int id) async {
    final url = baseUrl + "fixtures/$id";

    final newUrl = Uri.parse(url);

    Map<String, String> appHeaders = {
      'Content-Type': 'application/json',
      // 'App-Key': dotenv.env['APP_KEY']!,
      'App-Key': env("APP_KEY"),
      'Accept': 'application/json',
      "authorization": "Bearer $accessToken",
    };

    final response = await http.delete(
      newUrl,
      headers: appHeaders,
    );

    var jsonResponse = json.decode(response.body);

    try {
      switch (response.statusCode) {
        case 200:
          print(jsonResponse);
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
      print("Error ----> $e");
    }
  }

  //* Delete Fixture single image
  deleteFixtureImage(int id) async {
    final url = baseUrl + "fixtures/img_delete/$id";

    final newUrl = Uri.parse(url);

    Map<String, String> appHeaders = {
      'Content-Type': 'application/json',
      'App-Key': env("APP_KEY"),
      'Accept': 'application/json',
      "authorization": "Bearer $accessToken",
    };

    final response = await http.delete(
      newUrl,
      headers: appHeaders,
    );

    // var jsonResponse = json.decode(response.body);

    try {
      switch (response.statusCode) {
        // case 200:
        //   // print(jsonResponse);
        //   break;
          case 204:
          // print(jsonResponse);
          break;
        case 401:
          boxAccessToken.erase();
          accessToken = "";
          boxTeamMember.erase();
          Get.offAllNamed("/login");

          break;

        default:
          Get.snackbar(
              StringConstants.ERROR, response.reasonPhrase.toString(),
              colorText: Colors.white);
          // Get.snackbar(
          //     response.statusCode.toString(), response.reasonPhrase.toString());
      }
    } catch (e) {
      print("Error ----> $e");
    }
  }
}
