import 'dart:convert';

import 'package:get/get.dart';
import 'package:teamsta/constants/export_constants.dart';
import 'package:http/http.dart' as http;
import 'package:teamsta/models/teamModel.dart';

class TeamController {
  var teamSettings = RxList<TeamModel>().obs;
  var emailsList = RxList<Emails>().obs;
  var phoneList = RxList<Contacts>().obs;
  var websiteList = RxList<Websites>().obs;

  // app headers
  static Map<String, String> appHeaders = {
    // "Content-Type": "application/json",
    "Accept": "application/json",
    "App-Key": env("APP_KEY"),
    if (accessToken != null) "Authorization": "$accessToken",
  };
  getTeam() async {
    final url = baseUrl + "teams";

    final newUrl = Uri.parse(url);

    final response = await http.get(
      newUrl,
      headers: appHeaders,
    );

    var jsonResponse = jsonDecode(response.body);

    try {
      switch (response.statusCode) {
        case 200:
          // for (Map<String, dynamic> item in jsonResponse["teams"]) {
          //   teamSettings.value.add(TeamModel.fromJson(item));
          // }
          emailsList.value.clear();
          phoneList.value.clear();
          websiteList.value.clear();
          print(jsonResponse['teams'][0]["id"]);
          print(boxID.read("id"));
          //? List of emails
          for (int i = 0; i < jsonResponse["teams"].length; i++) {
            if (jsonResponse["teams"][i]['id'] == boxID.read('id')) {
              for (Map<String, dynamic> item in jsonResponse["teams"][i]
                  ['emails']) {
                emailsList.value.add(Emails.fromJson(item));
              }
            }
          }

          //? List of contacts
          for (int i = 0; i < jsonResponse['teams'].length; i++) {
            if (jsonResponse['teams'][i]["id"] == boxID.read("id")) {
              for (Map<String, dynamic> item in jsonResponse['teams'][i]
                  ["phones"]) {
                phoneList.value.add(Contacts.fromJson(item));
              }
            }
          }
          //? List of websites
          for (int i = 0; i < jsonResponse['teams'].length; i++) {
            if (jsonResponse['teams'][i]["id"] == boxID.read("id")) {
              for (Map<String, dynamic> item in jsonResponse['teams'][i]
                  ["sites"]) {
                websiteList.value.add(Websites.fromJson(item));
              }
            }
          }
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

  //* update contacts list
  updateContacts(int id) async {
    final contactUrl = baseUrl + "user/update_phone_number/$id";

    final newUrl = Uri.parse(contactUrl);

    final response = await http.put(newUrl,
        headers: appHeaders,
        body: jsonEncode({'name': "Home", 'number': "+447123456789"}));

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
      print(e);
    }
  }

  //* update emails list
  updateEmails(int id) async {
    final emailUrl = baseUrl + "user/update_email/$id";

    final newUrl = Uri.parse(emailUrl);

    final response = await http.put(
      newUrl,
      headers: appHeaders,
      body: jsonEncode(
        {
          'name': "Home",
          'email': "jason@gmail.com",
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
          print(response.statusCode);
          print(response.reasonPhrase);
          print(jsonResponse);
      }
    } catch (e) {
      print(e);
    }
  }

  //* update websites list
  updateWebsites(int id) async {
    final websiteUrl = baseUrl + "user/update_site/$id";

    final newUrl = Uri.parse(websiteUrl);

    final response = await http.put(
      newUrl,
      headers: appHeaders,
      body: jsonEncode(
        {
          'name': "Home",
          'website': "https://www.google.com",
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
          print(response.statusCode);
          print(response.reasonPhrase);
          print(jsonResponse);
      }
    } catch (e) {
      print(e);
    }
  }

  //* Delete contacts numbers
  deleteContactNumber(int id) async {
    final url = baseUrl + "user/delete_phone_number/${id}";

    final newUrl = Uri.parse(url);

    final response = await http.delete(
      newUrl,
      headers: appHeaders,
    );

    var jsonResponse = jsonDecode(response.body);

    try {
      switch (response.statusCode) {
        case 200:
          print(jsonResponse);
          print(response.statusCode);
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

  //* Delete emails
  deleteEmail(int id) async {
    final url = baseUrl + "user/delete_email/${id}";

    final newUrl = Uri.parse(url);

    final response = await http.delete(
      newUrl,
      headers: appHeaders,
    );

    var jsonResponse = jsonDecode(response.body);

    try {
      switch (response.statusCode) {
        case 200:
          print(jsonResponse);
          print(response.statusCode);
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

  //* Delete websites
  deleteWebsite(int id) async {
    final url = baseUrl + "user/delete_site/${id}";

    final newUrl = Uri.parse(url);

    final response = await http.delete(
      newUrl,
      headers: appHeaders,
    );

    var jsonResponse = jsonDecode(response.body);

    try {
      switch (response.statusCode) {
        case 200:
          print(response.statusCode);
          print(jsonResponse);
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
}
