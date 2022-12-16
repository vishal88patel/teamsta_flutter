import 'package:flutter/material.dart';
import 'package:flutter_toggle_tab/flutter_toggle_tab.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:teamsta/constants/export_constants.dart';
import 'package:teamsta/widgets/getLatLng.dart';
import 'package:teamsta/widgets/getLocation.dart';
import "package:get/get.dart";

class FollowingPage extends StatelessWidget {
  const FollowingPage({Key? key}) : super(key: key);

  static RxInt _selectedIndex = 0.obs;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Following"),
        bottom: PreferredSize(
          preferredSize: Size.fromHeight(100),
          child: Padding(
            padding: EdgeInsets.symmetric(horizontal: 10, vertical: 30),
            child: Obx(
              () => FlutterToggleTab(
                isScroll: false,
                labels: ["Notifications", "Following"],
                borderRadius: 15,
                unSelectedBackgroundColors: [Colors.white.withOpacity(.3)],
                selectedBackgroundColors: [customPurple],
                unSelectedTextStyle: Theme.of(context).textTheme.headline3!,
                selectedIndex: _selectedIndex.value,
                selectedLabelIndex: (index) {
                  _selectedIndex.value = index;
                },
                height: 40,
                width: 90,
                begin: Alignment.center,
                selectedTextStyle: Theme.of(context)
                    .textTheme
                    .headline3!
                    .copyWith(color: Colors.white),
              ),
            ),
          ),
        ),
      ),
      body: Obx(
        (() => Container(
              child: _selectedIndex == 0 ? NewsView() : FollowingView(),
            )),
      ),
    );
  }
}

class NewsView extends StatelessWidget {
  const NewsView({Key? key}) : super(key: key);

  static RxString text = "Testing".obs;

  @override
  Widget build(BuildContext context) {
    notificationController.getNotification();
    return Obx(() {
      if (notificationController.newsList.value == 0 &&
          notificationController.fixtureList.value == 0) {
        return Center(child: Text("No news at this time"));
      } else {
        return ListView.builder(
            shrinkWrap: true,
            itemCount: notificationController.newsList.value.length,
            itemBuilder: (context, index) {
              return Padding(
                padding: EdgeInsets.symmetric(horizontal: 10, vertical: 10),
                child: Card(
                  child: ListTile(
                    title: Text(
                      notificationController.newsList.value[index].title,
                      style: Theme.of(context).textTheme.headline2,
                    ),
                    subtitle: Text(
                      notificationController
                                  .newsList.value[index].description.length >
                              100
                          ? notificationController
                                  .newsList.value[index].description
                                  .substring(0, 100) +
                              "..."
                          : notificationController
                              .newsList.value[index].description,
                      style: Theme.of(context).textTheme.headline3,
                    ),
                  ),
                ),
              );
            });
      }
    });
  }
}

class FollowingView extends StatelessWidget {
  const FollowingView({Key? key}) : super(key: key);

  static var distance;

  @override
  Widget build(BuildContext context) {
    userGetController.getUserInfo();
    return Obx(
      () => ListView.builder(
        shrinkWrap: true,
        itemCount: userGetController.userInfo.value[0].favoriteTeams.length,
        itemBuilder: (context, index) {
          return Padding(
            padding: EdgeInsets.only(top: 10, left: 20, right: 20),
            child: InkWell(
              onTap: () {
                var id = userGetController
                    .userInfo.value[0].favoriteTeams[index].teamUserId;
                print(id);
                var data = {
                  "clubName": userGetController
                      .userInfo.value[0].favoriteTeams[index].clubName,
                  "clubImage": userGetController
                      .userInfo.value[0].favoriteTeams[index].image.imgUrl,
                  "clubSubtitle": distance,
                  "clubId": userGetController
                      .userInfo.value[0].favoriteTeams[index].teamId,
                  "isFollowing": true
                };
                servicesController.getAllServices(id);
                Get.toNamed("/club", arguments: data);
              },
              child: Container(
                alignment: Alignment.centerLeft,
                height: 110,
                width: double.infinity,
                decoration: BoxDecoration(
                    border: Border.all(color: customLightGrey, width: 2),
                    borderRadius: BorderRadius.circular(15)),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Padding(
                      padding: EdgeInsets.symmetric(horizontal: 10),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            userGetController.userInfo.value[0]
                                .favoriteTeams[index].clubName,
                            style: Theme.of(context).textTheme.headline2,
                          ),
                          FutureBuilder<LatLng?>(
                              future: GetLatLng().getCoords(userGetController
                                      .userInfo
                                      .value[0]
                                      .favoriteTeams[index]
                                      .addressLine1 +
                                  "," +
                                  userGetController.userInfo.value[0]
                                      .favoriteTeams[index].addressLine2 +
                                  "," +
                                  userGetController.userInfo.value[0]
                                      .favoriteTeams[index].townOrCity +
                                  "," +
                                  userGetController.userInfo.value[0]
                                      .favoriteTeams[index].county +
                                  "," +
                                  userGetController.userInfo.value[0]
                                      .favoriteTeams[index].postcode),
                              builder: (context, snapshot) {
                                if (snapshot.connectionState ==
                                    ConnectionState.done) {
                                  if (snapshot.hasData) {
                                    distance = GetLocation()
                                        .calculateDistance(
                                          snapshot.data!.latitude,
                                          snapshot.data!.longitude,
                                        )
                                        .toStringAsFixed(2);
                                    return Text(
                                      distance + " Miles",
                                      style:
                                          Theme.of(context).textTheme.headline3,
                                    );
                                  }

                                  return Text(
                                    "Distance: " + "0" + " miles",
                                    style:
                                        Theme.of(context).textTheme.headline3,
                                  );
                                }
                                return Container(
                                  height: 10,
                                  width: 10,
                                  child: CircularProgressIndicator(
                                    strokeWidth: 2,
                                  ),
                                );
                              }),
                          TextButton.icon(
                            style: TextButton.styleFrom(
                              primary: Colors.white,
                              backgroundColor: customPurple,
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(20),
                              ),
                            ),
                            onPressed: () {
                              // userGetController.userInfo.value.removeAt(index);

                              followingController.unfollowClub(
                                  userGetController.userInfo.value[0]
                                      .favoriteTeams[index].teamId,
                                  index);
                            },
                            icon: Image.asset(
                              CustomImage().follow,
                              height: 20,
                              width: 20,
                            ),
                            label: Text(
                              "Following",
                              style: Theme.of(context)
                                  .textTheme
                                  .headline3!
                                  .copyWith(color: Colors.white),
                            ),
                          ),
                        ],
                      ),
                    ),
                    Padding(
                      padding: EdgeInsets.only(right: 20),
                      child: CircleAvatar(
                        backgroundImage: NetworkImage(
                          userGetController.userInfo.value[0]
                              .favoriteTeams[index].image.imgUrl,
                        ),
                        radius: 40,
                      ),
                    ),
                  ],
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}
