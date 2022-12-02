import 'package:get/get.dart';
import 'package:teamsta/constants/export_constants.dart';
import 'package:http/http.dart' as http;
import 'package:teamsta/models/teamUserModel.dart';
import 'dart:convert';

import 'package:teamsta/models/userModel.dart';

class GetUserInfoController extends GetxController {
  var userInfo = RxList<UserModel>().obs;
  var teamInfo = RxList<TeamUserModel>().obs;

  RxBool isLoading = true.obs;

  //* team pending
  teamPending() async {
    final url = baseUrl + "user";

    final newUrl = Uri.parse(url);

    Map<String, String> appHeaders = {
      'Content-Type': 'application/json',
      // 'App-Key': dotenv.env['APP_KEY']!,
      'App-Key': env("APP_KEY"),
      'Accept': 'application/json',
      if (accessToken != null) "authorization": "Bearer $accessToken",
    };

    final response = await http.get(
      newUrl,
      headers: appHeaders,
    );
    var jsonResponse = json.decode(response.body);

    try {
      if (response.statusCode == 200) {
        print(jsonResponse);
        switch (jsonResponse['is_approved']) {
          case "approved":
            boxPending.write('pending', false);
            Get.offNamed("/nav");
            print("done");
            pending.toggle();
            print(jsonResponse);
            print(jsonResponse['is_approved']);
            break;
          case 401:
            boxAccessToken.erase();
            accessToken = "";
            boxTeamMember.erase();

            Get.offAllNamed("/login");

            break;
          default:
            boxPending.write('pending', true);
            print("Still pending");
        }
      } else {
        print(accessToken);
        print(response.statusCode);
        print(response.reasonPhrase);
      }
    } catch (e) {
      print("Error -----> $e");
    }
  }

  //* get user info
  getUserInfo() async {
    final url = baseUrl + "user";

    final newUrl = Uri.parse(url);

    Map<String, String> appHeaders = {
      'Content-Type': 'application/json',
      // 'App-Key': dotenv.env['APP_KEY']!,
      'App-Key': env("APP_KEY"),
      'Accept': 'application/json',
      if (accessToken != null) "authorization": "Bearer $accessToken",
    };

    final response = await http.get(
      newUrl,
      headers: appHeaders,
    );

    var jsonResponse = json.decode(response.body);

    try {
      switch (response.statusCode) {
        case 200:
          if (jsonResponse['user_role'] == "TeamUser") {
            if (boxHomeAddress.read("location") == null) {
              boxHomeAddress.write(
                  "address_line_1", jsonResponse['team']['address_line_1']);
              boxHomeAddress.write(
                  "address_line_2", jsonResponse['team']['address_line_2']);
              boxHomeAddress.write(
                  "town_or_city", jsonResponse['team']['town_or_city']);
              boxHomeAddress.write("county", jsonResponse['team']['county']);
              boxHomeAddress.write(
                  "post_code", jsonResponse['team']['postcode']);
            }
            if (boxID.read("id") == null) {
              boxID.write("id", jsonResponse['team']["id"]);
            }

            teamInfo.value.add(TeamUserModel.fromJson(jsonResponse));
          } else {
            userInfo.value.add(UserModel.fromJson(jsonResponse));
          }

          break;
        case 401:
          boxAccessToken.erase();
          accessToken = "";
          boxTeamMember.erase();
          Get.offAllNamed("/login");

          break;
        default:
          print("${response.statusCode} : ${response.reasonPhrase}");
      }
    } catch (e) {
      print("Error -----> $e");
    }
  }

  //* edit a user account
  updateUser() async {
    final url = baseUrl + "user/update";

    final newUrl = Uri.parse(url);

    Map<String, String> appHeaders = {
      'Content-Type': 'application/json',
      'App-Key': env("APP_KEY"),
      'Accept': 'application/json',
      if (accessToken != null) "authorization": "Bearer $accessToken",
    };

    final response = await http.put(
      newUrl,
      headers: appHeaders,
      body: jsonEncode(
        {
          "first_name": controller.nameController.text,
          "last_name": controller.surnameController.text,
          "email": controller.emailController.text,
          "password": controller.passwordController.text != ""
              ? controller.passwordController.text
              : null,
        },
      ),
    );

    var jsonResponse = jsonDecode(response.body);

    try {
      switch (response.statusCode) {
        case 201:
          print(controller.passwordController.text.trim());
          print(jsonResponse);
          userInfo.value.clear();

          getUserInfo();
          Get.back();
          break;
        case 401:
          boxAccessToken.erase();
          accessToken = "";
          boxTeamMember.erase();
          Get.offAllNamed("/login");

          break;
        default:
          print(jsonResponse);
          print(response.statusCode);
          print(response.reasonPhrase);
      }
    } catch (e) {
      print(e.toString());
    }
  }

  //* create team image
  createTeamImage(int id) async {
    final url = baseUrl + "teams/$id/image";

    final newUrl = Uri.parse(url);

    Map<String, String> appHeaders = {
      'Content-Type': 'application/json',
      'App-Key': env("APP_KEY"),
      'Accept': 'application/json',
      if (accessToken != null) "authorization": "Bearer $accessToken",
    };

    final uploadRequest = await http.MultipartRequest(
      'POST',
      newUrl,
    )
      ..headers.addAll(appHeaders)
      ..files
          .add(await http.MultipartFile.fromPath('image', singleImage!.path));
    isLoading.toggle();
    try {
      final response =
          await http.Response.fromStream(await uploadRequest.send());
      var jsonResponse = jsonDecode(response.body);
      switch (response.statusCode) {
        case 200:
          isLoading.toggle();
          print(jsonResponse);
          teamInfo.value.clear();
          getUserInfo();
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
              response.statusCode.toString(), response.reasonPhrase.toString());
          print(jsonResponse);
          print(response.statusCode);
          print(response.reasonPhrase);
      }
    } catch (e) {
      print(e.toString());
    }
  }

  //* create user image
  createUserImage(int id) async {
    final url = baseUrl + "app_users/$id/image";

    final newUrl = Uri.parse(url);
    Map<String, String> appHeaders = {
      // 'Content-Type': 'multipart/form-data',
      'App-Key': const String.fromEnvironment('APP_KEY'),
      'Accept': 'application/json',
      "authorization": "Bearer $accessToken",
    };

    final uploadRequest = await http.MultipartRequest(
      'POST',
      newUrl,
    )
      ..headers.addAll(appHeaders)
      ..files.addAll(
          [await http.MultipartFile.fromPath('image', singleImage!.path)]);

    var response = await http.Response.fromStream(await uploadRequest.send());
    var jsonResponse = json.decode(response.body);

    try {
      switch (response.statusCode) {
        case 200:
          print("Created user image: -->" + jsonResponse.toString());
          getUserInfo();

          break;
        case 401:
          boxAccessToken.erase();
          accessToken = "";
          boxTeamMember.erase();
          Get.offAllNamed("/login");

          break;
        default:
          print(jsonResponse);
          print(response.statusCode);
          print(response.reasonPhrase);
          Get.snackbar("${response.statusCode}:", '${response.reasonPhrase}');
      }
    } catch (e) {
      print("Error -----> $e");
    }
  }

  //* delete user image
  deleteUserImage(int imageId) async {
    final url = baseUrl + "app_users/$imageId/image";

    final newUrl = Uri.parse(url);
    Map<String, String> appHeaders = {
      'Content-Type': 'application/json',
      'App-Key': const String.fromEnvironment('APP_KEY'),
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
          print("Deleted user image: -->" + jsonResponse.toString());
          break;
        case 401:
          boxAccessToken.erase();
          accessToken = "";
          boxTeamMember.erase();
          Get.offAllNamed("/login");

          break;
        default:
          Get.snackbar("${response.statusCode}:", '${response.reasonPhrase}');
      }
    } catch (e) {
      print("Error -----> $e");
    }
  }

//* delete image
  deleteTeamImage(int imageId) async {
    final url = baseUrl + "teams/$imageId/image";

    final newUrl = Uri.parse(url);
    Map<String, String> appHeaders = {
      'App-Key': const String.fromEnvironment('APP_KEY'),
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
          print("Deleted team image: -->" + jsonResponse.toString());
          break;
        case 401:
          boxAccessToken.erase();
          accessToken = "";
          boxTeamMember.erase();
          Get.offAllNamed("/login");

          break;
        default:
          Get.snackbar("${response.statusCode}:", '${response.reasonPhrase}');
      }
    } catch (e) {
      print("Error -----> $e");
    }
  }
}
