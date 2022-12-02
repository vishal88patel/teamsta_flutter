import 'dart:convert';

import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'package:intl/intl.dart';
import 'package:teamsta/constants/export_constants.dart';
import 'package:teamsta/models/notificationsModel.dart';

class NotificationsController {
  var notificationList = RxList<NotificationsModel>().obs;
  var newsList = RxList<News>().obs;
  var fixtureList = RxList<Fixture>().obs;

  Map<String, String> headers = {
    'Content-Type': 'application/json',
    'Accept': 'application/json',
    "Authorization": "Bearer $accessToken",
  };

  final url = baseUrl + "user/notifications";

  //* get notifications
  getNotification() async {
    final newUrl = Uri.parse(url);

    final response = await http.get(newUrl, headers: headers);

    final responseJson = json.decode(response.body);

    try {
      switch (response.statusCode) {
        case 200:
          print("Notifications: ----> " + responseJson.toString());
          notificationList.value.clear();
          newsList.value.clear();
          fixtureList.value.clear();
          //* notifications
          for (int i = 0; i < responseJson['favoriteTeams'].length; i++) {
            final notification =
                NotificationsModel.fromJson(responseJson['favoriteTeams'][i]);
            notificationList.value.add(notification);
            for (var news in notification.news) {
              var today = DateTime.now();
              if (DateTime(today.year, today.month, today.day)
                  .subtract(Duration(days: 30))
                  .isBefore(news.createdAt)) {
                newsList.value.add(news);
              }
            }
            for (var fixture in notification.fixtures) {
              var today = DateTime.now();
              var dateFormat = DateFormat('yyyy/MM/dd').parse(fixture.date);
              if (DateTime(today.year, today.month, today.day)
                  .subtract(const Duration(days: 30))
                  .isBefore(dateFormat)) {
                fixtureList.value.add(fixture);
              }
            }
          }

          break;
        default:
          print(responseJson);
          print(response.statusCode);
          print(response.reasonPhrase);
          Get.snackbar(
              response.statusCode.toString(), response.reasonPhrase.toString());
      }
    } catch (e) {
      print(e.toString());
    }
  }
}
