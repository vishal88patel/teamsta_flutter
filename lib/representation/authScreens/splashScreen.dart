import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:teamsta/constants/prefrence_box.dart';
import 'package:teamsta/constants/colors.dart';
import 'package:teamsta/constants/images.dart';
import 'package:teamsta/widgets/getLocation.dart';

class SplashPage extends StatefulWidget {
  @override
  _SplashPageState createState() => _SplashPageState();
}

class _SplashPageState extends State<SplashPage> {
  @override
  void initState() {
    GetLocation().getLocation();
    super.initState();
    /*if (boxPending.read('pending') == true) {
      Future.delayed(Duration(seconds: 3), () {
        Get.offNamed('/pending');
      });
    } else*/ if (boxAccessToken.read('accessToken') != null) {
      Future.delayed(Duration(seconds: 3), () {
        Get.offNamed('/nav');
      });
    } else {
      Future.delayed(Duration(seconds: 3), () {
        Get.offNamed('/login');
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      color: customOrange,
      child: Padding(
        padding: EdgeInsets.symmetric(horizontal: 40),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Container(
              height: 100,
              width: double.infinity,
              decoration: BoxDecoration(
                  image: DecorationImage(
                image: CustomImage.splashLogo,
                fit: BoxFit.contain,
              )),
            ),
          ],
        ),
      ),
    );
  }
}
