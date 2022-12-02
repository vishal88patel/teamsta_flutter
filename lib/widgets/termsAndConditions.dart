import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:teamsta/constants/export_constants.dart';
import 'package:teamsta/controllers/privacy_terms.dart';

class TermsAndConditions extends StatelessWidget {
  const TermsAndConditions({Key? key}) : super(key: key);

  // uses get arguments to get the isMore value from the previous screen
  // if isMore is true, then the appBar will have a back button and the title will be "Terms and Conditions"

  @override
  Widget build(BuildContext context) {
    print(Get.arguments["isMore"]);
    return Scaffold(
      appBar: AppBar(
        backgroundColor:
            Get.arguments["isMore"] == true ? customOrange : Colors.white,
        automaticallyImplyLeading:
            Get.arguments["isMore"] == true ? true : false,
        title: Get.arguments["isMore"] == true
            ? Text("Terms and Conditions")
            : Text(""),
      ),
      body: Center(
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 20, vertical: 20),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              GetX<PrivacyTermsController>(
                init: PrivacyTermsController(),
                builder: (data) {
                  if (data.teamLoading.value) {
                    return Container(
                      alignment: Alignment.bottomCenter,
                      height: mobileHight / 2.5,
                      child: CircularProgressIndicator(color: customPurple),
                    );
                  } else {
                    return SingleChildScrollView(
                      child: Text(
                        terms.toString(),
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
