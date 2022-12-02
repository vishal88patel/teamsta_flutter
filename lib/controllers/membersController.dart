import 'dart:convert';
import 'dart:io';

import 'package:get/get.dart';
import 'package:teamsta/constants/export_constants.dart';
import 'package:http/http.dart' as http;
import 'package:teamsta/models/membersModel.dart';

class MemberController extends GetxController {
  var membersList = RxList<MembersModel>().obs;

  RxBool isLoading = true.obs;

//* get member info
  getMember() async {
    final url = baseUrl + "team_members";

    final Uri newUrl = Uri.parse(url);

    final response = await http.get(newUrl, headers: {
      "Authorization": "Bearer $accessToken",
      "Accept": "application/json",
      "App-Key": env("APP_KEY"),
    });

    var jsonResponse = json.decode(response.body);

    try {
      switch (response.statusCode) {
        case 200:
          membersList.value.clear();
          // print(jsonResponse);
          for (Map<String, dynamic> item in jsonResponse) {
            membersList.value.add(MembersModel.fromJson(item));
          }
          membersList.refresh();
          isLoading.toggle();
          break;
        case 401:
          boxAccessToken.erase();
          accessToken = "";
          boxTeamMember.erase();
          Get.offAllNamed("/login");

          break;
        default:
          print(response.statusCode);
          print(response.reasonPhrase);
          print(jsonResponse);
      }
    } catch (e) {}
  }

//* set member info
  setMember(final File image, final String name, final String bio,
      final String role) async {
    final url = baseUrl + "team_members";

    final Uri newUrl = Uri.parse(url);

    Map<String, String> appHeaders = {
      'App-Key': env("APP_KEY"),
      'Accept': 'application/json',
      "authorization": "Bearer $accessToken",
    };

    final uploadRequest = await http.MultipartRequest(
      'POST',
      newUrl,
    )
      ..headers.addAll(appHeaders)
      ..fields.addAll({
        'name': name,
        'bio': bio,
        'role': role,
      })
      ..files.add(await http.MultipartFile.fromPath('image', image.path));

    var response = await http.Response.fromStream(await uploadRequest.send());
    var jsonResponse = json.decode(response.body);

    try {
      switch (response.statusCode) {
        case 201:
          print(jsonResponse);
          membersList.value
              .add(MembersModel.fromJson(jsonResponse['team_member']));
          Get.back();
          break;
        case 401:
          boxAccessToken.erase();
          accessToken = "";
          boxTeamMember.erase();
          Get.offAllNamed("/login");

          break;
        default:
          print(response.statusCode);
          print(response.reasonPhrase);
          print(jsonResponse);
      }
    } catch (e) {}
  }

//* delete member info
  deleteMember(
    int id,
  ) async {
    final url = baseUrl + "team_members/$id";
    final Uri newUrl = Uri.parse(url);
    final response = await http.delete(newUrl, headers: {
      "Authorization": "Bearer $accessToken",
      "Accept": "application/json",
      "App-Key": env("APP_KEY"),
    });
    var jsonResponse = json.decode(response.body);
    try {
      switch (response.statusCode) {
        case 200:
          print(jsonResponse);
          membersList.value.clear();
          await getMember();
          break;
        case 401:
          boxAccessToken.erase();
          accessToken = "";
          boxTeamMember.erase();
          Get.offAllNamed("/login");

          break;
        default:
          print(response.statusCode);
          print(response.reasonPhrase);
          print(jsonResponse);
      }
    } catch (e) {
      print(e);
    }
  }

  //* update member
  updateMember(
    int id,
    final String name,
    final String bio,
    final String role,
  ) async {
    final url = baseUrl + "team_members/$id";
    final Uri newUrl = Uri.parse(url);

    Map<String, String> appHeaders = {
      'App-Key': env("APP_KEY"),
      'Accept': 'application/json',
      "Content-Type": "application/json",
      "authorization": "Bearer $accessToken",
    };

    final response = await http.put(newUrl,
        headers: appHeaders,
        body: jsonEncode({
          "name": name,
          "bio": bio,
          "role": role,
        }));

    var jsonResponse = json.decode(response.body);

    try {
      switch (response.statusCode) {
        case 200:
          print(jsonResponse);
          isLoading.toggle();
          if (controller.imageFile != null) {
            imageDelete(id).then((response) {
              if (response.statusCode == 200) {
                memberImageAdd(id).then((_) {
                  print("went in");
                  controller.imageFile = null;
                });
              }
            });
          }
          getMember().then((_) => Get.back());
          break;
        case 401:
          boxAccessToken.erase();
          accessToken = "";
          boxTeamMember.erase();
          Get.offAllNamed("/login");

          break;
        default:
          isLoading.toggle();
          print(response.statusCode);
          print(response.reasonPhrase);
          print(jsonResponse);
      }
    } catch (e) {
      print(e);
    }
  }

  //* add single image for update
  // id is from the card.
  memberImageAdd(int id) async {
    final url = baseUrl + "team_members/img_add/$id";

    final Uri newUrl = Uri.parse(url);

    Map<String, String> appHeaders = {
      'Content-Type': 'multipart/form-data',
      'App-Key': const String.fromEnvironment('APP_KEY'),
      'Accept': 'application/json',
      "authorization": "Bearer $accessToken",
    };

    final uploadRequest = await http.MultipartRequest(
      'POST',
      newUrl,
    )
      ..headers.addAll(appHeaders)
      ..files.add(
        await http.MultipartFile.fromPath(
          'image',
          controller.imageFile!.path,
        ),
      );

    var response = await http.Response.fromStream(await uploadRequest.send());
    var jsonResponse = json.decode(response.body);

    try {
      switch (response.statusCode) {
        case 200:
          print("Image added successfully");
          print(jsonResponse);
          break;
        default:
          print(response.statusCode);
          print(response.reasonPhrase);
          print(jsonResponse);
          Get.snackbar('Error: ${response.statusCode}',
              response.reasonPhrase.toString());
      }
    } catch (e) {}
  }

  //*delete single image
  imageDelete(int id) async {
    // final url = baseUrl + "team_members/img_delete/$id";
    final url = baseUrl + "team_members/image_delete/$id";

    final newUrl = Uri.parse(url);

    Map<String, String> appHeaders = {
      'App-Key': env("APP_KEY"),
      'Accept': 'application/json',
      "authorization": "Bearer $accessToken",
    };

    final response = await http.delete(newUrl, headers: appHeaders);

    var jsonResponse = json.decode(response.body);

    try {
      switch (response.statusCode) {
        case 200:
          print("Image deleted successfully");
          print(jsonResponse);
          break;
        case 401:
          boxAccessToken.erase();
          accessToken = "";
          boxTeamMember.erase();
          Get.offAllNamed("/login");

          break;
        default:
          print(response.statusCode);
          print(response.reasonPhrase);
          print(jsonResponse);
          Get.snackbar("Error: ${response.statusCode}",
              response.reasonPhrase.toString());
      }
    } catch (e) {
      print(e);
    }
  }
}
