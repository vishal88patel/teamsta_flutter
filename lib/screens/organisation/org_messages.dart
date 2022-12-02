import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:teamsta/constants/controllers.dart';
import 'package:teamsta/controllers/chatController.dart';
import 'package:teamsta/screens/organisation/org_in_app_chat.dart';
import 'package:teamsta/screens/page_exports.dart';

class TeamMessages extends StatefulWidget {
  const TeamMessages({Key? key}) : super(key: key);

  @override
  State<TeamMessages> createState() => _TeamMessagesState();
}

class _TeamMessagesState extends State<TeamMessages> {
  ValueNotifier<bool> isChecking = ValueNotifier(false);
  TextEditingController messagingController = TextEditingController();

  @override
  void initState() {
    super.initState();
    // vishal-----//
    // isChecking.addListener(checkAgain);
    // vishal-----//

  }

  checkAgain() {
    Future.delayed(Duration(seconds: 5), () => print("hello")).then((value) {
      if (mounted) {
        checkAgain();
      }
    });
  }

  @override
  void dispose() {
    super.dispose();
    isChecking.removeListener(checkAgain);
  }

  @override
  Widget build(BuildContext context) {
    // print(userGetController.teamInfo.value[0].groups.length);
    return Scaffold(
      appBar: AppBar(
        title: Text("Messages"),
      ),
      body: GetX<ChatController>(
        init: chatController,
        builder: (data) {
          if (data.isLoading.value == true) {
            return Center(
              child: Container(),
            );
          } else if (data.isLoading.value == false &&
              data.teamMessage.value[0].user.groups.length == 0) {
            return Center(
              child: Text(
                "There are no chats",
                style: Theme.of(context).textTheme.headline2,
              ),
            );
          } else
            return Column(
              children: [
                ListView.builder(
                  shrinkWrap: true,
                  itemCount: data.teamMessage.value[0].user.groups.length,
                  itemBuilder: (context, index) {
                    return Padding(
                      padding: EdgeInsets.symmetric(
                        vertical: 10,
                      ),
                      child: Card(
                        child: ListTile(
                          onTap: () {
                            //TODO: request the correct chat

                            Get.to(InAppChat(), arguments: {"id": index});
                          },
                          title: Text(
                            data.teamMessage.value[0].user.groups[index].name,
                            style: Theme.of(context).textTheme.headline3,
                          ),
                          subtitle: Text(
                            data.teamMessage.value[0].user.groups[index]
                                .welcomeMessage,
                            style: Theme.of(context).textTheme.headline3,
                          ),
                          trailing: Text(
                            data.teamMessage.value[0].user.groups[index]
                                .createdAt
                                .toString(),
                            style: Theme.of(context).textTheme.headline3,
                          ),
                        ),
                      ),
                    );
                  },
                ),
                ListView.builder(
                  shrinkWrap: true,
                  itemCount: data.chatInfo.value.length,
                  itemBuilder: (context, index) {
                    return InkWell(
                      onTap: () {
                        Get.to(OrgInAppChat(), arguments: {
                          "chat": data.chatInfo.value[index],
                        });
                      },
                      child: Card(
                        child: ListTile(
                          title: Text(
                            data.chatInfo.value[index].name,
                            style: Theme.of(context).textTheme.headline2,
                          ),
                          subtitle: Text(
                            data.chatInfo.value[index].conversation.length == 0
                                ? "No messages yet"
                                : data.chatInfo.value[index].conversation[0]
                                    .message,
                            style: Theme.of(context).textTheme.headline3,
                          ),
                        ),
                      ),
                    );
                  },
                ),
              ],
            );
        },
      ),
    );
  }
}
