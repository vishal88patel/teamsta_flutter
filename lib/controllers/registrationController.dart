import 'dart:convert';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:teamsta/constants/export_constants.dart';
import 'package:http/http.dart' as http;
import 'package:teamsta/constants/string_constants.dart';


import '../widgets/loadingPage.dart';
import '../widgets/widgets.dart';

class Information {
  TextEditingController nameController = TextEditingController();
  TextEditingController surnameController = TextEditingController();
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();

  // organisation controllers
  TextEditingController companyNameController = TextEditingController();
  TextEditingController companyDescriptionController = TextEditingController();
  TextEditingController companySportController = TextEditingController();
  TextEditingController companyAddressLine1Controller = TextEditingController();
  TextEditingController companyAddressLine2Controller = TextEditingController();
  TextEditingController companyTownCity = TextEditingController();
  TextEditingController companyCounty = TextEditingController();
  TextEditingController companyPostCode = TextEditingController();
  TextEditingController token = TextEditingController();

  // image for teams and users
  File? imageFile;

  // in this case user is actually the team
  final userPhoneInfo = <String, dynamic>{}.obs;
  final userEmailInfo = <String, dynamic>{}.obs;
  final userWebsiteInfo = <String, dynamic>{}.obs;
  final teamResults = <Map<String, dynamic>>[].obs;

  clearControllers() {
    nameController.clear();
    surnameController.clear();
    emailController.clear();
    passwordController.clear();
    companyNameController.clear();
    companyDescriptionController.clear();
    companySportController.clear();
    companyAddressLine1Controller.clear();
    companyAddressLine2Controller.clear();
    companyTownCity.clear();
    companyCounty.clear();
    companyPostCode.clear();
    token.clear();
  }

  Map<String, String> appHeaders = {
    'Content-Type': 'application/json',
    // 'App-Key': dotenv.env['APP_KEY']!,
    'App-Key': env("APP_KEY"),
    'Accept': 'application/json',
    if (accessToken != null) "authorization": "Bearer $accessToken",
  };

  //* create a user account
  registerUser() async {
    final url = baseUrl + "user/register";
    final newUrl = Uri.parse(url);

    final uploadRequest = await http.MultipartRequest(
      'POST',
      newUrl,
    )
      ..headers.addAll(appHeaders)
      ..fields.addAll({
        'email': emailController.text,
        'password': passwordController.text,
        'first_name': nameController.text,
        'last_name': surnameController.text,
        'role_id': "2",
        'is_team_admin': "0",
        'terms_and_conditions': "1",
        'privacy_policy': "1",
      })
      ..files.add(await http.MultipartFile.fromPath(
        'image',
        singleImage!.path,
      ));

    var response = await http.Response.fromStream(await uploadRequest.send());
    var jsonResponse = json.decode(response.body);

    try {
      switch (response.statusCode) {
        case 201:
          print(jsonResponse['user']["image"]["img_url"]);
          accessToken = jsonResponse['access_token'];
          boxAccessToken.write("accessToken", accessToken);
          boxID.write("email", jsonResponse['user']["email"]);
          boxID.write("userID", jsonResponse['user']['id']);
         
          clearControllers();
          Get.offNamed('/nav');
          break;
        default:
          print(response.statusCode);
          print(response.reasonPhrase);
          print(jsonResponse);
          Get.snackbar(
            // "Error ${response.statusCode}",
            StringConstants.ERROR,
            jsonResponse['message'].toString(),
            colorText: Colors.white,
            duration: Duration(
              seconds: 3,
            ),
          );
      }
    } catch (e) {
      print("Create User Error: $e");
    }
  }

  //* login a user account
  userLogin() async {
    final url = baseUrl + "user/login";
    final newUrl = Uri.parse(url);

    final response = await http.post(
      newUrl,
      headers: appHeaders,
      body: jsonEncode(
        {
          'email': emailController.text,
          'password': passwordController.text,
        },
      ),
    );
    final responseJson = json.decode(response.body);
    try {
      if (response.statusCode == 200) {
        print(responseJson);
        print(responseJson['access_token']);
        boxPending.read("pending");
        print("is Team" + boxTeamMember.read('isTeam').toString());

        if (boxTeamMember.read("isTeam") == null &&
            responseJson["user"]["user_role"] == "TeamUser") {
          boxTeamMember.write("isTeam", true);
         /* if (boxPending.read("isPending") == true ||
              boxPending.read("isPending") == null) {*/
            if (responseJson["user"]["is_approved"] != "approved") {
            accessToken = await responseJson['access_token'];
            print(accessToken);
            boxAccessToken.write("accessToken", accessToken);
            boxHomeAddress.write("address_line_1",
                responseJson['user']['team']['address_line_1']);
            boxHomeAddress.write("address_line_2",
                responseJson['user']['team']['address_line_2']);
            boxHomeAddress.write(
                "town_or_city", responseJson['user']['team']['town_or_city']);
            boxHomeAddress.write(
                "county", responseJson['user']['team']['county']);
            boxHomeAddress.write(
                "post_code", responseJson['user']['team']['post_code']);
            clearControllers();
            //-----vishal-------
            // Get.offNamed("/pending");
            Get.offNamed("/nav");
            //---- vishal
          } else {
            accessToken = await responseJson['access_token'];
            boxAccessToken.write("accessToken", accessToken);
            boxHomeAddress.write("address_line_1",
                responseJson['user']['team']['address_line_1']);
            boxHomeAddress.write("address_line_2",
                responseJson['user']['team']['address_line_2']);
            boxHomeAddress.write(
                "town_or_city", responseJson['user']['team']['town_or_city']);
            boxHomeAddress.write(
                "county", responseJson['user']['team']['county']);
            boxHomeAddress.write(
                "post_code", responseJson['user']['team']['post_code']);
            clearControllers();
            Get.offNamed("/nav");
          }
        } else {
          boxTeamMember.write("isTeam", false);

          accessToken = await responseJson['access_token'];

          boxAccessToken.write("accessToken", accessToken);
          clearControllers();
          Get.offAllNamed("/nav");
        }
      } else if(response.statusCode == 400){
        Get.snackbar(
            StringConstants.ERROR,responseJson['message'].toString(),
            colorText: Colors.white);
      }else{
        Get.offNamed("/pending");
        Get.snackbar(
            StringConstants.ERROR,responseJson['message'].toString(),
            colorText: Colors.white);
        // Get.snackbar(response.reasonPhrase.toString(),
        //     responseJson['message'].toString(),
        //     colorText: Colors.white, duration: Duration(seconds: 5));
      }
    } catch (e) {
      print(e.toString());
    }
  }

  // logout a user account
  logout() {
    // nothing from the database will just clear everything and send to login
    boxAccessToken.erase();
    accessToken = null;
    boxTeamMember.erase();
    clearControllers();
    imageFile = null;
    singleImage = null;
    boxForgottenPassword.erase();
    boxPending.erase();
    boxHomeAddress.erase();
    boxLastLocation.erase();
    Get.offAllNamed('/login');
  }

  //* delete a user account
  deleteUser() async {
    final url = baseUrl + "user";
    final newUrl = Uri.parse(url);

    Map<String, String> appHeaders = {
      'Content-Type': 'application/json',
      // 'App-Key': dotenv.env['APP_KEY']!,
      'App-Key': env("APP_KEY"),
      'Accept': 'application/json',
      if (accessToken != null) "Authorization": "Bearer $accessToken",
    };

    final response = await http.delete(
      newUrl,
      headers: appHeaders,
    );

    try {
      if (response.statusCode == 200) {
       
        print(response.body);
        clearControllers();
        boxAccessToken.erase();
        accessToken = null;
        boxTeamMember.erase();
        boxHomeAddress.erase();
        boxPending.erase();
        boxLastLocation.erase();
        singleImage = null;
        imageFile = null;
        singleImage = null;
        boxID.erase();
        Get.offAllNamed("/");
      } else if (response.statusCode == 401) {
        boxAccessToken.erase();
        print(response.body);
        accessToken = null;
        print("Access token: $accessToken");
        Get.snackbar(
            'Unauthorised ', 'You are not authorised to perform this action.',
            colorText: Colors.white, duration: Duration(seconds: 3));
        Future.delayed(Duration(seconds: 3), () => Get.offAllNamed("/login"));
      }
    } catch (e) {
      print(e.toString());
      Get.snackbar('Error', e.toString(),
          colorText: Colors.white, duration: Duration(seconds: 3));
    }
  }

  //* Team Registration
  teamRegistration() async {
    final url = baseUrl + "user/register";
    final newUrl = Uri.parse(url);

    final uploadRequest = await http.MultipartRequest("post", newUrl)
      ..headers.addAll({
        'Content-Type': 'multipart/form-data',
        // 'App-Key': dotenv.env['APP_KEY']!,
        'App-Key': env("APP_KEY"),
        'Accept': 'application/json',
      })
      ..fields.addAll({
        'email': emailController.text.trim(),
        'password': passwordController.text,
        'first_name': nameController.text,
        'last_name': surnameController.text,
        'role_id': "2",
        'is_team_admin': "1",
        'terms_and_conditions': "1",
        'privacy_policy': "1",
        'club_name': companyNameController.text,
        'description': companyDescriptionController.text,
        'category': companySportController.text,
        'address_line_1': companyAddressLine1Controller.text,
        'address_line_2': companyAddressLine2Controller.text,
        'town_or_city': companyTownCity.text,
        'county': companyCounty.text,
        'postcode': companyPostCode.text,
        'phones': jsonEncode(userPhoneInfo),
        'emails': jsonEncode(userEmailInfo),
        'sites': jsonEncode(userWebsiteInfo),
      })
      ..files.addAll([
        await http.MultipartFile.fromPath("image", imageFile!.path),
        await http.MultipartFile.fromPath("user_image", singleImage!.path)
      ]);

    try {
      Get.dialog(barrierColor: Colors.transparent, LoadingPage());
      var response = await http.Response.fromStream(await uploadRequest.send());
      var jsonResponse = json.decode(response.body);
      switch (response.statusCode) {
        case 201:
          print(response.body);
          boxPending.write("pending", true);
          boxTeamMember.write("teamMember", true);
          boxAccessToken.write("accessToken", jsonResponse['access_token']);
          accessToken = jsonResponse['access_token'];
          singleImage = null;
          imageFile = null;
        
          clearControllers();
          Get.offAllNamed('/pending');
          break;

        default:
          Get.back();
          print(response.body);
          Get.snackbar(
              response.statusCode.toString(), jsonResponse['errors']['email'][0].toString(),
              colorText: Colors.white, duration: Duration(seconds: 3));
      }
    } catch (e) {
      print(e.toString());
    }
  }

  //* update team
  teamUpdate(int id) async {
    final url = baseUrl + "teams/$id";

    final newUrl = Uri.parse(url);

    final response = await http.put(newUrl,
        headers: appHeaders,
        body: jsonEncode({
          "club_name": companyNameController.text,
          "description": companyDescriptionController.text,
          "category": companySportController.text,
          "address_line_1": companyAddressLine1Controller.text,
          "address_line_2": companyAddressLine2Controller.text,
          "town_or_city": companyTownCity.text,
          "county": companyCounty.text,
          "postcode": companyPostCode.text,
        }));

    var jsonResponse = json.decode(response.body);

    try {
      switch (response.statusCode) {
        case 200:
          print(jsonResponse);
          clearControllers();
          userGetController.teamInfo.value.clear();
          userGetController.getUserInfo();
          // userGetController.getUserInfo();
          Get.back();
          break;
        default:
          print(response.statusCode);
          print(response.reasonPhrase);
          print(jsonResponse);
      }
    } catch (e) {
      print(e.toString());
    }
  }

  //* forgotten Password
  forgotPassword(String email) async {
    final url = baseUrl + "password/email";

    final Uri newUrl = Uri.parse(url);

    final response = await http.post(
      newUrl,
      headers: appHeaders,
      body: jsonEncode(
        {
          'email': email,
        },
      ),
    );

    try {
      switch (response.statusCode) {
        case 200:
          Get.back();
          boxForgottenPassword.write("forgotten", true);
          boxForgottenPassword.write("email", emailController.text);
          Get.dialog(
              barrierColor: Colors.transparent,
              NewPasswordForm(passwordController: passwordController));
          Get.snackbar('Password Recovery', 'sent to your email');
          break;
        default:
          Get.snackbar(
              'Error ${response.statusCode}', '${response.reasonPhrase}');
      }
    } catch (e) {
      print(e.toString());
    }
  }

  //* send code to reset password
  resetPassword(String email) async {
    final url = baseUrl + "password/submit";

    final Uri newUrl = Uri.parse(url);

    final response = await http.post(
      newUrl,
      headers: appHeaders,
      body: jsonEncode(
        {
          'email': email.trim(),
          'password': passwordController.text.trim(),
          'code': token.text,
        },
      ),
    );

    var jsonResponse = json.decode(response.body);

    try {
      switch (response.statusCode) {
        case 200:
          print(jsonResponse['user']);
          boxForgottenPassword.erase();
          Get.snackbar('Password', 'Successfully Changed');
          clearControllers();
          Get.offAllNamed("/login");
          break;
        default:
          Get.snackbar(
              'Error ${response.statusCode}', '${response.reasonPhrase}');
      }
    } catch (e) {
      print(e.toString());
    }
  }

//! not working
  //* update team contact information
  updateTeamContactInfo() async {
    final url = baseUrl + "teams/update-details";

    final newUrl = Uri.parse(url);

    final response = await http.put(newUrl,
        headers: appHeaders,
        body: jsonEncode({
          "phone": jsonEncode(userPhoneInfo),
          "email": jsonEncode(userEmailInfo),
          "site": jsonEncode(userWebsiteInfo),
        }));

    var jsonResponse = json.decode(response.body);

    try {
      switch (response.statusCode) {
        case 201:
          print(jsonResponse);
          clearControllers();
          userGetController.teamInfo.value.clear();
          userGetController.getUserInfo();
          // userGetController.getUserInfo();
          Get.back();
          break;
        default:
          print(response.statusCode);
          print(response.reasonPhrase);
          print(jsonResponse);
      }
    } catch (e) {
      print(e.toString());
    }
  }

  //* update the contact numbers
  updateContactNumbers(
    String name,
    String phone,
  ) async {
    final url = baseUrl + "user/add_phone_number";

    final newUrl = Uri.parse(url);

    final response = await http.post(newUrl,
        headers: appHeaders,
        body: jsonEncode({
          "name": name,
          "number": phone,
        }));

    var jsonResponse = json.decode(response.body);

    try {
      switch (response.statusCode) {
        case 201:
          print(jsonResponse);
          break;
        default:
          print(response.statusCode);
          print(response.reasonPhrase);
          print(jsonResponse);
      }
    } catch (e) {
      print(e.toString());
    }
  }

  //* update the email addresses
  updateEmailAddresses(
    String name,
    String email,
  ) async {
    final url = baseUrl + "user/add_email";

    final newUrl = Uri.parse(url);

    final response = await http.post(newUrl,
        headers: appHeaders,
        body: jsonEncode({
          "name": name,
          "email": email,
        }));

    var jsonResponse = json.decode(response.body);

    try {
      switch (response.statusCode) {
        case 201:
          print(jsonResponse);
          break;
        default:
          print(response.statusCode);
          print(response.reasonPhrase);
          print(jsonResponse);
      }
    } catch (e) {
      print(e.toString());
    }
  }

  //* update the website addresses
  updateWebsiteAddresses(
    String name,
    String website,
  ) async {
    final url = baseUrl + "user/add_website";

    final newUrl = Uri.parse(url);

    final response = await http.post(newUrl,
        headers: appHeaders,
        body: jsonEncode({
          "name": name,
          "url": website,
        }));

    var jsonResponse = json.decode(response.body);

    try {
      switch (response.statusCode) {
        case 201:
          print(jsonResponse);
          break;
        default:
          print(response.statusCode);
          print(response.reasonPhrase);
          print(jsonResponse);
      }
    } catch (e) {
      print(e.toString());
    }
  }
}
