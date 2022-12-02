import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:maps_launcher/maps_launcher.dart';
import 'package:teamsta/constants/export_constants.dart';

class ClubAbout extends StatelessWidget {
  const ClubAbout({Key? key}) : super(key: key);

  headlineAddress() {
    var value = servicesController.teamInfoList.value[0];
    var fullAddress = value.addressLine1 +
        "," +
        value.addressLine2 +
        "," +
        value.town +
        "," +
        value.county;
    return fullAddress;
  }

  fullAddress() {
    var value = servicesController.teamInfoList.value[0];
    var fullAddress = value.addressLine1 +
        "," +
        value.addressLine2 +
        "," +
        value.town +
        "," +
        value.county +
        "," +
        value.postcode;
    return fullAddress;
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 20, vertical: 10),
      child: Column(
        children: [
          Text(
            '''${servicesController.teamInfoList.value[0].description}
''',
            style: Theme.of(context).textTheme.headline3,
          ),
          Padding(
            padding: EdgeInsets.symmetric(vertical: 10),
            child: Card(
              child: ListTile(
                onTap: () {
                  MapsLauncher.launchQuery(fullAddress());
                },
                title: Text(
                  headlineAddress(),
                  style: Theme.of(context).textTheme.headline2,
                ),
                subtitle: Text(
                  servicesController.teamInfoList.value[0].postcode,
                  style: Theme.of(context).textTheme.headline3,
                ),
                trailing: Icon(Icons.location_on, color: customOrange),
              ),
            ),
          ),
          GridView.builder(
            gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 3, crossAxisSpacing: 10, mainAxisSpacing: 10),
            shrinkWrap: true,
            itemCount:
                servicesController.teamInfoList.value[0].profileImages.length,
            padding: EdgeInsets.symmetric(horizontal: 20),
            itemBuilder: (context, index) {
              print("image not working" +
                  servicesController
                      .teamInfoList.value[0].profileImages[index].imgUrl
                      .toString());
              return InkWell(
                onTap: () {
                  Get.dialog(
                barrierColor: Colors.transparent,
                    
                    AboutDialog(
                      image: imageBaseWithout +
                          servicesController
                              .teamInfoList.value[0].profileImages[index].imgUrl
                              .toString()));
                },
                child: Container(
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(15),
                      image: DecorationImage(
                          image: NetworkImage(servicesController.teamInfoList
                              .value[0].profileImages[index].imgUrl),
                          fit: BoxFit.cover)),
                ),
              );
            },
          )
        ],
      ),
    );
  }
}

class AboutDialog extends StatelessWidget {
  const AboutDialog({Key? key, required this.image}) : super(key: key);

  final String image;

  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      child: BackdropFilter(
        filter: ImageFilter.blur(sigmaX: 3, sigmaY: 3),
        child: Scaffold(
          backgroundColor: Colors.white.withOpacity(.5),
          body: InkWell(
            onTap: (() => Get.back()),
            child: Container(
              decoration: BoxDecoration(
                image: DecorationImage(
                    image: NetworkImage(image), fit: BoxFit.contain),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
