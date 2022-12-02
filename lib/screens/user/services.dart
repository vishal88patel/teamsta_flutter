import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:maps_launcher/maps_launcher.dart';
import 'package:teamsta/constants/export_constants.dart';

class ServicesPage extends StatelessWidget {
  const ServicesPage({
    Key? key,
  }) : super(key: key);

  shortAddress() {
    var singleLine = servicesController.teamInfoList.value[0].addressLine1 +
        "," +
        servicesController.teamInfoList.value[0].addressLine2 +
        "," +
        servicesController.teamInfoList.value[0].town +
        "," +
        servicesController.teamInfoList.value[0].county;
    return singleLine;
  }

  fullAddress() {
    var fullAddress = servicesController.teamInfoList.value[0].addressLine1 +
        "," +
        servicesController.teamInfoList.value[0].addressLine2 +
        "," +
        servicesController.teamInfoList.value[0].town +
        "," +
        servicesController.teamInfoList.value[0].county +
        "," +
        servicesController.teamInfoList.value[0].postcode;
    return fullAddress;
  }

  userAddress() {
    var singleLine = Get.arguments["address_line_1"] +
        "," +
        Get.arguments['address_line_2'] +
        "," +
        Get.arguments['city_or_town'] +
        "," +
        Get.arguments['county'];

    return singleLine;
  }

  userFullAddress() {
    var fullAddress = Get.arguments['address_line_1'] +
        "," +
        Get.arguments['address_line_2'] +
        "," +
        Get.arguments['city_or_town'] +
        "," +
        Get.arguments['county'] +
        "," +
        Get.arguments['postcode'];
    return fullAddress;
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
            children: [
              Text(
                Get.arguments["title"].toString(),
                style: Theme.of(context)
                    .textTheme
                    .headline1!
                    .copyWith(fontSize: 25),
              ),
              Padding(
                padding: EdgeInsets.only(top: 10),
                child: Text(
                  '''
${Get.arguments["description"]}

''',
                  maxLines: 10,
                  style: Theme.of(context).textTheme.headline3,
                ),
              ),
              Padding(
                padding: EdgeInsets.symmetric(vertical: 5),
                child: Container(
                  height: 110,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(15),
                    border: Border.all(color: customLightGrey, width: 2),
                  ),
                  child: ListTile(
                    onTap: () {
                      MapsLauncher.launchQuery(
                        Get.arguments['isUser'] != null
                            ? userFullAddress()
                            : fullAddress(),
                      );
                    },
                    contentPadding: EdgeInsets.all(10),
                    title: Text(
                      Get.arguments['isUser'] != null
                          ? userAddress()
                          : shortAddress(),
                      style: Theme.of(context).textTheme.headline2,
                    ),
                    subtitle: Text(
                      Get.arguments['isUser'] != null
                          ? Get.arguments['postcode']
                          : servicesController.teamInfoList.value[0].postcode,
                      style: Theme.of(context)
                          .textTheme
                          .headline2!
                          .copyWith(color: customOrange),
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
                subtitle1: Get.arguments["sport"].toString(),
                subtitle2: Get.arguments['sex'].toString(),
              ),
              CustomServiceCard(
                title1: "Age Group",
                title2: "Ability Level",
                subtitle1: Get.arguments['age'].toString(),
                subtitle2: Get.arguments['ability'].toString(),
              ),
              CustomServiceCard(
                title1: "Available",
                title2: "When",
                subtitle1: Get.arguments['available'].toString() + "'s",
                subtitle2: Get.arguments['when'].toString(),
              ),
              Visibility(
                  visible: Get.arguments['isUser'] != null ? true : false,
                  child: Padding(
                    padding: EdgeInsets.only(
                      top: 30,
                    ),
                    child: ElevatedButton(
                      onPressed: () {
                        print(Get.arguments['id']);
                      },
                      child: Text("Visit Club Profile"),
                    ),
                  )),
              Padding(
                padding: EdgeInsets.symmetric(vertical: 20),
                child: ElevatedButton(
                  onPressed: () {
                    //TODO: message club one to one
                  },
                  child: Text("Message"),
                ),
              ),
            ],
          ),
        ));
  }
}

class CustomServiceCard extends StatelessWidget {
  const CustomServiceCard({
    Key? key,
    this.subtitle1,
    this.subtitle2,
    this.title1,
    this.title2,
  }) : super(key: key);

  final String? title1;
  final String? title2;
  final String? subtitle1;
  final String? subtitle2;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(bottom: 5),
      child: Container(
        height: 80,
        decoration: BoxDecoration(
          border: Border.all(color: customLightGrey, width: 2),
          borderRadius: BorderRadius.circular(15),
        ),
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 10),
          child: Row(
            children: [
              Container(
                width: mobileWidth / 3,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      title1!,
                      style: Theme.of(context).textTheme.headline2,
                    ),
                    Text(
                      subtitle1!,
                      style: Theme.of(context)
                          .textTheme
                          .headline2!
                          .copyWith(color: customOrange),
                    )
                  ],
                ),
              ),
              const SizedBox(width: 50),
              Container(
                width: mobileWidth / 3,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      title2!,
                      style: Theme.of(context).textTheme.headline2,
                    ),
                    Text(
                      subtitle2!,
                      style: Theme.of(context)
                          .textTheme
                          .headline2!
                          .copyWith(color: customOrange),
                    )
                  ],
                ),
              ),
              Spacer(),
            ],
          ),
        ),
      ),
    );
  }
}
