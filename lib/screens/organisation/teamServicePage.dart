import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:maps_launcher/maps_launcher.dart';

import 'package:teamsta/constants/export_constants.dart';
import 'package:teamsta/screens/page_exports.dart';

class TeamServicePage extends StatelessWidget {
  const TeamServicePage({Key? key}) : super(key: key);

  address() {
    String fullAddress = Get.arguments["addressLineOne"] +
        ", " +
        Get.arguments["addressLineTwo"] +
        ", " +
        Get.arguments["townOrCity"] +
        ", " +
        Get.arguments["county"];

    String addressAfter = fullAddress.length > 35
        ? fullAddress.substring(0, 35) + "..."
        : fullAddress;

    return addressAfter;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Services"),
      ),
      body: Padding(
        padding: EdgeInsets.symmetric(vertical: 10, horizontal: 20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            Text(
              Get.arguments['title'],
              style:
                  Theme.of(context).textTheme.headline1!.copyWith(fontSize: 25),
            ),
            Padding(
              padding: EdgeInsets.only(top: 10),
              child: Text(
                ''' ${Get.arguments['description']}
                ''',
                maxLines: 10,
                style: Theme.of(context).textTheme.headline3,
              ),
            ),
            Padding(
              padding: EdgeInsets.symmetric(vertical: 5),
              child: Container(
                height: 100,
                decoration: (BoxDecoration(
                  borderRadius: BorderRadius.circular(10),
                  border: Border.all(color: customLightGrey, width: 2),
                )),
                child: ListTile(
                  onTap: () {
                    MapsLauncher.launchQuery(address());
                  },
                  contentPadding: EdgeInsets.all(10),
                  title: Text(
                    // limit the text to 10

                    address(),
                    style: Theme.of(context).textTheme.headline2,
                  ),
                  subtitle: Text(
                    Get.arguments['postcode'],
                    style: Theme.of(context).textTheme.headline3,
                  ),
                  trailing: Image.asset(
                    CustomImage().pinIcon,
                    height: 25,
                  ),
                ),
              ),
            ),
            CustomServiceCard(
                title1: "Sport/Activity",
                title2: "Sex",
                subtitle1: Get.arguments['sportOrActivity'],
                subtitle2: Get.arguments["sex"]),
            CustomServiceCard(
              title1: "Age Group",
              title2: "Ability Level",
              subtitle1: Get.arguments['age'].toString(),
              subtitle2: Get.arguments['ability'],
            ),
            CustomServiceCard(
              title1: "Available",
              title2: "When",
              subtitle1: Get.arguments['available'],
              subtitle2: Get.arguments['when'],
            ),
            Padding(
              padding: EdgeInsets.symmetric(vertical: 20),
              child: ElevatedButton(
                onPressed: () {
                  //TODO: message still to do
                  
                },
                child: Text(
                  "Message",
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
