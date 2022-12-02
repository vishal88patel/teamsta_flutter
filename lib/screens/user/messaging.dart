import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:teamsta/constants/controllers.dart';
import 'package:teamsta/controllers/chatController.dart';
import 'package:teamsta/widgets/widgets.dart';

Rx<TextEditingController> _searchController = TextEditingController().obs;

class MessagingPage extends StatelessWidget {
  const MessagingPage({Key? key}) : super(key: key);

  checkAgain() {
    Future.delayed(Duration(seconds: 5), () => print("hello"));
  }

  static TextEditingController messageSearchController =
      TextEditingController();
  static RxBool isVisible = true.obs;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text("Messaging"),
          bottom: PreferredSize(
            preferredSize: Size.fromHeight(100),
            child: Padding(
              padding: EdgeInsets.symmetric(vertical: 15),
              child: CustomSearchBar(
                controller: _searchController.value,
                isVisible: isVisible,
                onChange: (value) {
                  //TODO: check that this is working

                  teamGetController.queryTeamInfo.value.clear();
                  if (messageSearchController.text.isEmpty) {
                    isVisible.value = true;
                  } else {
                    isVisible.value = false;

                    for (var teamInfo in teamGetController.teamInfo.value) {
                      if (teamInfo.clubName.toLowerCase().contains(value)) {
                        teamGetController.queryTeamInfo.value.add(teamInfo);
                      }
                    }
                  }
                },
              ),
            ),
          ),
        ),
        body: GetX<ChatController>(
          init: chatController,
          builder: (data) {
            if (data.isLoading.value == true) {
              return Center(
                child: CircularProgressIndicator(),
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
                                //TODO: Go to chat page
                              },
                            ),
                          ),
                        );
                      })
                ],
              );
          },
        ));
  }
}
