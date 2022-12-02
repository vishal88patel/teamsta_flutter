import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:teamsta/constants/boxes.dart';
import 'package:teamsta/constants/colors.dart';
import 'package:teamsta/constants/controllers.dart';
import 'package:teamsta/constants/images.dart';

import '../../constants/strings.dart';

class PendingPage extends StatefulWidget {
  const PendingPage({Key? key}) : super(key: key);

  @override
  State<PendingPage> createState() => _PendingPageState();
}

class _PendingPageState extends State<PendingPage> {
  @override
  void initState() {
    super.initState();
    userGetController.teamPending();
    checkAgain();
  }

// checks the database every 30 seconds then breaks when pending is true.
  checkAgain() {
    switch (pending.value) {
      case false:
        Future.delayed(
                Duration(seconds: 30), () => userGetController.teamPending())
            .then((value) => checkAgain());
        break;
      case true:
        null;
        break;
      default:
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: customOrange,
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            Spacer(),
            Container(
              height: 120,
              width: 120,
              decoration: BoxDecoration(
                image: DecorationImage(
                  image: CustomImage.thumbsUpIcon,
                ),
              ),
            ),
            Padding(
              padding: EdgeInsets.only(top: 40),
              child: Text(
                "Your profile is now complete",
                style: Theme.of(context).textTheme.headline5,
              ),
            ),
            Text(
              "Pending Approval",
              style: Theme.of(context).textTheme.headline4,
            ),
            Text(
              '''
Thank you for applying for an account at
Teamsta. Your account is currently pending
approval by the app administrator.
''',
              style:
                  Theme.of(context).textTheme.headline5!.copyWith(fontSize: 15),
              textAlign: TextAlign.center,
              strutStyle: StrutStyle(height: 1.3, forceStrutHeight: true),
            ),
            Spacer(),
            InkWell(
              onTap: () {
                Get.offAllNamed("/login");
                //controller.logout();
              },
              child: Text(
                "Logout",
                style: Theme.of(context)
                    .textTheme
                    .headline5!
                    .copyWith(fontSize: 16),
                strutStyle: StrutStyle(
                  height: 1.3,
                  forceStrutHeight: true,
                ),
              ),
            ),
            Padding(
              padding: EdgeInsets.only(top: 10, bottom: 45),
              child: InkWell(
                child: Text(
                  "Change your mind? Delete your data",
                  style: Theme.of(context)
                      .textTheme
                      .headline5!
                      .copyWith(fontSize: 16),
                ),
                onTap: () {
                  Get.offAllNamed("/login");
                  /*controller.deleteUser().then((_) {
                    Get.offAllNamed("/login");
                  });*/
                },
              ),
            )
          ],
        ),
      ),
    );
  }
}
