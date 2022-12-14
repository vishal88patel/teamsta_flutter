import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:teamsta/constants/export_constants.dart';
import 'package:teamsta/controllers/privacy_terms.dart';


class PrivacyPolicy extends StatelessWidget {
  const PrivacyPolicy({Key? key}) : super(key: key);

  //TODO: add teh prpicy policy text here

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: InkWell(
            onTap: () {
              Get.back();
            },
            child: Icon(
              CupertinoIcons.chevron_back,
              color: primaryWhite,
              size: 30,
            )),
        backgroundColor:
            Get.arguments["isMore"] == true ? customOrange : Colors.white,
        automaticallyImplyLeading:
            Get.arguments["isMore"] == true ? true : false,
        title:
            Get.arguments['isMore'] == true ? Text("Privacy Policy") : Text(""),
      ),
      body: Center(
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 20, vertical: 20),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              GetX<PrivacyTermsController>(
                init: PrivacyTermsController(),
                builder: (data) {
                  if (data.privacyLoading.value) {
                    return Container(
                      alignment: Alignment.bottomCenter,
                      height: mobileHight / 2.5,
                      child: CircularProgressIndicator(color: customPurple,)
                    );
                  } else {
                    return SingleChildScrollView(
                      child: Text(
                        privacy.toString(),
                        style: Theme.of(context).textTheme.headline3,
                      ),
                    );
                  }
                },
              ),
              Spacer(),
              ElevatedButton(
                onPressed: () {
                  Get.back();
                },
                child: Get.arguments['isMore'] == true
                    ? Text('Back')
                    : Text('Agree And Continue'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
