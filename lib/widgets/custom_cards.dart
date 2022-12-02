import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../constants/controllers.dart';

class CustomCard extends StatelessWidget {
  const CustomCard({
    Key? key,
    required this.title,
    required this.subTitle,
    required this.image,
    required this.id,
    required this.clubId,
  }) : super(key: key);

  final String title;
  final String subTitle;
  final String image;
  final int id;
  final int clubId;

  checkFollowing() {
    List<int> newList = [];
    for (int i = 0;
        i < userGetController.userInfo.value[0].favoriteTeams.length;
        i++) {
      newList.add(userGetController.userInfo.value[0].favoriteTeams[i].teamId);
    }
    if (newList.contains(clubId)) {
      return true;
    } else {
      return false;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(vertical: 3),
      child: InkWell(
        onTap: () {
          var data = {
            "clubName": title,
            "clubImage": image,
            "clubSubTitle": subTitle,
            "clubId": clubId,
            "isFollowing": checkFollowing(),
          };
          servicesController.getAllServices(id);
          Get.toNamed("/club", arguments: data);
        },
        child: Container(
          padding: EdgeInsets.symmetric(horizontal: 20, vertical: 10),
          height: 100,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(10),
            color: Colors.white,
            boxShadow: [
              BoxShadow(
                color: Colors.black.withOpacity(.1),
                spreadRadius: 1,
                blurRadius: 20,
                offset: Offset(0, 10),
              ),
            ],
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    title,
                    style: Theme.of(context).textTheme.headline2,
                    strutStyle: StrutStyle(forceStrutHeight: true, height: 1),
                  ),
                  Text(
                    subTitle,
                    style: Theme.of(context).textTheme.headline3,
                    strutStyle: StrutStyle(forceStrutHeight: true, height: 1.5),
                  )
                ],
              ),
              CircleAvatar(
                backgroundImage: NetworkImage(image),
                backgroundColor: Colors.white,
                radius: 35,
              )
            ],
          ),
        ),
      ),
    );
  }
}

// custom Cards for find page.
class CustomFindCard extends StatelessWidget {
  const CustomFindCard({
    Key? key,
    required this.title,
    required this.subTitle,
    required this.secondSubTitle,
  }) : super(key: key);

  final String title;
  final String subTitle;
  final String secondSubTitle;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(vertical: 3),
      child: InkWell(
        onTap: () {
          var data = {
            "title": title,
            "sport": secondSubTitle,
          };
          Get.toNamed("/services", parameters: data);
        },
        child: Container(
          padding: EdgeInsets.symmetric(horizontal: 20, vertical: 10),
          height: 100,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(10),
            color: Colors.white,
            boxShadow: [
              BoxShadow(
                color: Colors.black.withOpacity(.1),
                spreadRadius: 1,
                blurRadius: 20,
                offset: Offset(0, 10),
              ),
            ],
          ),
          child: ListTile(
            title: Text(
              title,
              style: Theme.of(context).textTheme.headline2,
            ),
            subtitle: Text(
              "$subTitle\n$secondSubTitle",
              style: Theme.of(context).textTheme.headline3,
            ),
          ),
        ),
      ),
    );
  }
}
