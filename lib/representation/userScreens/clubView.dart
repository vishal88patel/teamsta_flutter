import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:teamsta/constants/export_constants.dart';
import 'package:tuple/tuple.dart';

import '../../Global/GlobalList/clubViewList.dart';

class ClubView extends StatelessWidget {
  const ClubView({
    Key? key,
  }) : super(key: key);

  static RxBool following = false.obs;

  @override
  Widget build(BuildContext context) {
    following.value = Get.arguments["isFollowing"];
    return DefaultTabController(
      length: clubViewPages.length,
      child: Scaffold(
        appBar: AppBar(
          bottom: PreferredSize(
            preferredSize: Size.fromHeight(135),
            child: Container(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Padding(
                    padding: EdgeInsets.only(
                      right: 10,
                      bottom: 10,
                    ),
                    child: ListTile(
                      // tileColor: Colors.white,
                      title: Text(Get.arguments["clubName"].toString(),
                          style: Theme.of(context)
                              .textTheme
                              .headline2!
                              .copyWith(color: Colors.white)),
                      subtitle: Text(
                        Get.arguments["clubSubTitle"].toString(),
                        style: Theme.of(context)
                            .textTheme
                            .headline3!
                            .copyWith(color: Colors.white),
                      ),
                      trailing: CircleAvatar(
                        backgroundImage:
                            NetworkImage("${Get.arguments["clubImage"]}"),
                      ),
                    ),
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      Container(
                        height: 40,
                        width: mobileWidth / 3,
                        child: TextButton.icon(
                          style: TextButton.styleFrom(
                              primary: Colors.white,
                              backgroundColor: customPurple,
                              shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(10))),
                          onPressed: () {
                            followingController
                                .followClub(Get.arguments["clubId"])
                                .then((_) {
                              following.toggle();
                            });
                          },
                          icon: Image.asset(
                            CustomImage().follow,
                            height: 20,
                            color: Colors.white,
                          ),
                          label: Obx(
                            () => Text(
                              following.value ? "Following" : "Follow",
                              style: Theme.of(context)
                                  .textTheme
                                  .headline3!
                                  .copyWith(color: Colors.white),
                            ),
                          ),
                        ),
                      ),
                      Container(
                        height: 40,
                        width: mobileWidth / 2 + 5,
                        child: TextButton.icon(
                          style: TextButton.styleFrom(
                              primary: Colors.white,
                              backgroundColor: customPurple,
                              shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(10))),
                          onPressed: () {
                            //TODO: get this from the api
                          },
                          icon: Image.asset(
                            CustomImage().chatting,
                            height: 20,
                            color: Colors.white,
                          ),
                          label: Text(
                            "Apply to Group Chat",
                            style: Theme.of(context)
                                .textTheme
                                .headline3!
                                .copyWith(color: Colors.white),
                          ),
                        ),
                      ),
                    ],
                  ),
                  TabBar(
                    padding: EdgeInsets.symmetric(vertical: 10),
                    isScrollable: true,
                    indicatorColor: Colors.orange,
                    tabs: [
                      Text(
                        "Fixtures",
                      ),
                      Text(
                        "Results",
                      ),
                      Text(
                        "Services",
                      ),
                      Text(
                        "News",
                      ),
                      Text(
                        "Team",
                      ),
                      Text(
                        "Contacts",
                      ),
                      Text(
                        "About",
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
        ),
        body: TabBarView(
            children: clubViewPages
                .map<Widget>((Tuple2 page) => page.item2)
                .toList()),
      ),
    );
  }
}
