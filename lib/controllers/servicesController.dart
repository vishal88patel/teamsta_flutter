import 'dart:convert';

import 'package:get/get.dart';
import 'package:teamsta/constants/export_constants.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:teamsta/models/fixtureModel.dart';
import 'package:teamsta/models/newsModel.dart';
import 'package:teamsta/models/resultsModel.dart';
import 'package:teamsta/models/servicesModel.dart';
import 'package:teamsta/models/services_Models.dart';
import 'package:teamsta/models/teamModel.dart';

import '../models/contactModel.dart';
import '../models/teamMemberModel.dart';
import '../widgets/getLatLng.dart';

class ServicesController extends GetxController {
  // services list
  var servicesList = RxList<ServicesModel>().obs;
  var fixturesList = RxList<FixtureModel>().obs;
  var resultsList = RxList<ResultsModel>().obs;
  var teamInfoList = RxList<TeamModel>().obs;
  var newsList = RxList<NewsModel>().obs;
  var teamMemberList = RxList<TeamMemberModel>().obs;
  var contactList = RxList<ContactModel>().obs;

  // fot the services pages
  var teamServices = RxList<TeamServicesModel>().obs;
  var teamQueryServices = RxList<TeamServicesModel>().obs;
  // for the user calls the team services.
  var userServices = RxList<UserServicesModel>().obs;
  var userQueryServices = RxList<UserServicesModel>().obs;

  RxBool isLoading = false.obs;
  RxBool isSetLoading = false.obs;

  final url = baseUrl + "services";

  TextEditingController titleController = TextEditingController();
  TextEditingController descriptionController = TextEditingController();
  TextEditingController sportOrActivityController = TextEditingController();
  TextEditingController ageController = TextEditingController();
  TextEditingController sexController = TextEditingController();
  TextEditingController abilityController = TextEditingController();
  TextEditingController repeatingDayController = TextEditingController();
  TextEditingController dateController = TextEditingController();
  TextEditingController timeController = TextEditingController();
  TextEditingController address_line_2 = TextEditingController();
  TextEditingController address_line_1 = TextEditingController();
  TextEditingController town_or_city = TextEditingController();
  TextEditingController postcode = TextEditingController();
  TextEditingController county = TextEditingController();

  // headers
  Map<String, String> headers = {
    "Authorization": "Bearer $accessToken",
    "Accept": "application/json",
    "Content-Type": "application/json",
    "App-Key": env("APP_KEY"),
  };

  clearControllers() {
    titleController.clear();
    descriptionController.clear();
    sportOrActivityController.clear();
    ageController.clear();
    sexController.clear();
    abilityController.clear();
    repeatingDayController.clear();
    dateController.clear();
    timeController.clear();
    address_line_2.clear();
    address_line_1.clear();
    town_or_city.clear();
    postcode.clear();
    county.clear();
  }

//* get services
  Future<void> getService() async {
    final allUrl = baseUrl + "user/services";
    final Uri newUrl = Uri.parse(allUrl);
    isLoading.toggle();
    final response = await http.get(newUrl, headers: headers);
    var jsonResponse = json.decode(response.body);

    try {
      switch (response.statusCode) {
        case 200:
          print(boxTeamMember.read("isTeam"));
          print(jsonResponse);
          userServices.value.clear();
          teamServices.value.clear();
          //* Get user services for the team.
          if (boxTeamMember.read("isTeam") == true) {
            for (int i = 0; i < jsonResponse["appUsers"].length; i++) {
              for (int j = 0;
                  j < jsonResponse["appUsers"][i]["services"].length;
                  j++) {
                var teamInfo = TeamServicesModel.fromJson(
                    jsonResponse["appUsers"][i]["services"][j]);
                await teamInfo.getTheDistance();
                teamServices.value.add(teamInfo);
              }
            }
            teamServices.value.sort((a, b) {
              if (a.distance == null) {
                return 1;
              } else if (b.distance == null) {
                return -1;
              } else {
                return a.distance!.compareTo(b.distance!);
              }
            });
          }

          //* Get team services for the user
          else {
            for (int i = 0; i < jsonResponse['teams'].length; i++) {
              for (int j = 0;
                  j < jsonResponse["teams"][i]["services"].length;
                  j++) {
                var userInfo = UserServicesModel.fromJson(
                    jsonResponse["teams"][i]["services"][j]);
                await userInfo.getTheDistance();
                userServices.value.add(userInfo);
              }
              userServices.value.sort((a, b) {
                if (a.distance == null) {
                  return 1;
                } else if (b.distance == null) {
                  return -1;
                } else {
                  return a.distance!.compareTo(b.distance!);
                }
              });
            }
          }
          userServices.refresh();
          teamServices.refresh();
          isLoading.toggle();
          break;
        default:
          isLoading.toggle();
          Get.snackbar(
              response.statusCode.toString(), response.reasonPhrase.toString(),
              colorText: Colors.white);
      }
    } catch (e) {
      print(e.toString());
    }
  }

//* get all services
  getAllServices(int id) async {
    final thisBaseUrl = baseUrl + "team_info/$id";
    final Uri newUrl = Uri.parse(thisBaseUrl);
    isLoading.toggle();
    final response = await http.get(newUrl, headers: headers);
    var jsonResponse = json.decode(response.body);
    try {
      switch (response.statusCode) {
        case 200:
          print(id);
          print(jsonResponse);
          // isTeam = jsonResponse['user']['user_role'];
          servicesList.value.clear();
          fixturesList.value.clear();
          resultsList.value.clear();
          teamInfoList.value.clear();
          newsList.value.clear();
          teamMemberList.value.clear();
          contactList.value.clear();

          //* TeamInfo
          servicesController.teamInfoList.value
              .add(TeamModel.fromJson(jsonResponse['user']['team']));

          //* fixtures
          for (Map<String, dynamic> fixtures in jsonResponse['user']
              ['fixtures']) {
            fixturesList.value.add(FixtureModel.fromJson(fixtures));
          }

          //* results
          for (Map<String, dynamic> results in jsonResponse['user']
              ['results']) {
            resultsList.value.add(ResultsModel.fromJson(results));
          }

          //* services
          for (Map<String, dynamic> service in jsonResponse['user']
              ['services']) {
            servicesList.value.add(ServicesModel.fromJson(service));
          }

          // //* News
          for (Map<String, dynamic> news in jsonResponse['user']['news']) {
            newsList.value.add(NewsModel.fromJson(news));
          }

          //* teamMembers
          for (Map<String, dynamic> teamMember in jsonResponse['user']
              ['team_members']) {
            teamMemberList.value.add(TeamMemberModel.fromJson(teamMember));
          }
          // //* Contacts
          for (Map<String, dynamic> contact in jsonResponse['user']['team']
              ['phones']) {
            contactList.value.add(ContactModel.fromJson(contact));
          }
          for (Map<String, dynamic> contact in jsonResponse['user']['team']
              ['emails']) {
            contactList.value.add(ContactModel.fromJson(contact));
          }
          for (Map<String, dynamic> contact in jsonResponse['user']['team']
              ['websites']) {
            contactList.value.add(ContactModel.fromJson(contact));
          }
          print(contactList.value);
          servicesList.refresh();
          isLoading.toggle();
          break;
        case 401:
          Get.snackbar(
              'Unauthorised ', 'You are not authorised to perform this action.',
              colorText: Colors.white, duration: Duration(seconds: 3));
          Future.delayed(Duration(seconds: 3), () => Get.offAllNamed("/login"));
          break;
        default:
          isLoading.toggle();
          Get.snackbar(
              response.statusCode.toString(), response.reasonPhrase.toString(),
              colorText: Colors.white);
      }
    } catch (e) {
      print(e.toString());
    }
  }

//* set services
  createService(String age) async {
    final Uri newUrl = Uri.parse(url);

    final response = await http.post(
      newUrl,
      headers: headers,
      body: jsonEncode(
        {
          "title": titleController.text,
          "description": descriptionController.text,
          "sport_or_activity": sportOrActivityController.text,
          "age": age,
          "ability_level": abilityController.text,
          "sex": sexController.text,
          "repeating_day": repeatingDayController.text,
          "date": dateController.text,
          "time": timeController.text,
          "address_line_1":
              boxTeamMember.read("isTeam") && address_line_1.text.isEmpty
                  ? boxHomeAddress.read("address_line_1")
                  : address_line_1.text,
          "address_line_2":
              boxTeamMember.read("isTeam") && address_line_1.text.isEmpty
                  ? boxHomeAddress.read("address_line_2")
                  : address_line_2.text,
          "city_or_town":
              boxTeamMember.read("isTeam") && address_line_1.text.isEmpty
                  ? boxHomeAddress.read("town_or_city")
                  : town_or_city.text,
          "postcode":
              boxTeamMember.read("isTeam") && address_line_1.text.isEmpty
                  ? boxHomeAddress.read("county")
                  : postcode.text,
          "county": boxTeamMember.read("isTeam") && address_line_1.text.isEmpty
              ? boxHomeAddress.read("post_code")
              : county.text,
        },
      ),
    );

    var jsonResponse = jsonDecode(response.body);
    isSetLoading.toggle();
    try {
      switch (response.statusCode) {
        case 201:
          isSetLoading.toggle();
          print(jsonResponse['service']);
          servicesList.value
              .add(ServicesModel.fromJson(jsonResponse['service']));
          servicesList.refresh();
          Get.back();
          clearControllers();
          break;
        default:
          isSetLoading.toggle();
          print(jsonResponse);
          print(response.statusCode);
          Get.snackbar(
              response.statusCode.toString(), response.reasonPhrase.toString(),
              colorText: Colors.white);
      }
    } catch (e) {
      print(e.toString());
    }
  }

//* delete services
  deleteService(int id) async {
    final Uri newUrl = Uri.parse(url + "/$id");
    var response = await http.delete(newUrl, headers: headers);

    var jsonResponse = jsonDecode(response.body);
    try {
      switch (response.statusCode) {
        case 200:
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

//* update services
  updateService(int id, String age) async {
    final Uri newUrl = Uri.parse(url + "/$id");
    final response = await http.put(
      newUrl,
      headers: headers,
      body: jsonEncode(
        {
          "title": titleController.text,
          "description": descriptionController.text,
          "sport_or_activity": sportOrActivityController.text,
          "age": age,
          "ability_level": abilityController.text,
          "sex": sexController.text,
          "repeating_day": repeatingDayController.text,
          "date": dateController.text,
          "time": timeController.text,
          "address_line_1":
              boxTeamMember.read("isTeam") && address_line_1.text.isEmpty
                  ? boxHomeAddress.read("address_line_1")
                  : address_line_1.text,
          "address_line_2":
              boxTeamMember.read("isTeam") && address_line_1.text.isEmpty
                  ? boxHomeAddress.read("address_line_2")
                  : address_line_2.text,
          "city_or_town":
              boxTeamMember.read("isTeam") && address_line_1.text.isEmpty
                  ? boxHomeAddress.read("town_or_city")
                  : town_or_city.text,
          "postcode":
              boxTeamMember.read("isTeam") && address_line_1.text.isEmpty
                  ? boxHomeAddress.read("county")
                  : postcode.text,
          "county": boxTeamMember.read("isTeam") && address_line_1.text.isEmpty
              ? boxHomeAddress.read("post_code")
              : county.text,
        },
      ),
    );

    var jsonResponse = jsonDecode(response.body);

    try {
      switch (response.statusCode) {
        case 200:
          print(jsonResponse);
          break;
        default:
          print("id: $id");
          print(response.statusCode);
          print(response.reasonPhrase);
          print(jsonResponse);
      }
    } catch (e) {
      print(e.toString());
    }
  }

  //* get the services from the users and teams
  userServicesApi() async {
    final newURl = Uri.parse(url);

    final response = await http.get(newURl, headers: headers);

    var jsonResponse = jsonDecode(response.body);

    try {
      switch (response.statusCode) {
        case 200:
          servicesList.value.clear();
          for (Map<String, dynamic> service in jsonResponse['services']) {
            servicesList.value.add(ServicesModel.fromJson(service));
          }
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
