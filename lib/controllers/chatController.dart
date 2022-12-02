import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'package:teamsta/constants/export_constants.dart';
import 'package:teamsta/models/chatModel.dart';
import 'package:teamsta/models/teamChatModel.dart';

class ChatController extends GetxController {
  var chatInfo = RxList<ChatModel>().obs;
  var messages = RxList<ChatModel>().obs;
  var teamMessage = RxList<TeamChat>().obs;
  RxBool isLoading = true.obs;

  TextEditingController orgChatController = TextEditingController();

  @override
  void onInit() {
    getAllChat();
    super.onInit();
  }

  // headers
  Map<String, String> appHeaders = {
    'Content-Type': 'application/json',
    'App-Key': env("APP_KEY"),
    'Accept': 'application/json',
    "authorization": "Bearer $accessToken",
  };

//* Get all Chat
  getAllChat() async {
    final url = baseUrl + "all-chats";

    final Uri newUrl = Uri.parse(url);

    var response = await http.get(
      newUrl,
      headers: appHeaders,
    );

    var jsonResponse = json.decode(response.body);

    try {
      switch (response.statusCode) {
        case 200:
          for (Map<String, dynamic> item in jsonResponse['group_chats']) {
            chatInfo.value.add(ChatModel.fromJson(item));
          }
          for (Map<String, dynamic> item in jsonResponse['private_chats']) {
            chatInfo.value.add(ChatModel.fromJson(item));
          }
          teamMessage.value.add(TeamChat.fromJson(jsonResponse));

          chatInfo.value.refresh();
          print("This is the response: $jsonResponse");
          isLoading.value = false;
          break;
        case 401:
          boxAccessToken.erase();
          accessToken = "";
          boxTeamMember.erase();
          Get.offAllNamed("/login");

          break;
        default:
          print("${response.statusCode}: ${response.reasonPhrase}");
          print(jsonResponse);
      }
    } catch (e) {}
  }

// get single chat

// get group chat

// set single chat

// set group chat

// delete single chat

//? delete group chat

}
