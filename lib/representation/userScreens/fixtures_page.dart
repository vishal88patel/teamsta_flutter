import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:teamsta/constants/export_constants.dart';
import 'package:teamsta/widgets/google_maps.dart';

class FixturesPage extends StatelessWidget {
  const FixturesPage({Key? key}) : super(key: key);

  fullAddress() {
    var value = servicesController.fixturesList.value[Get.arguments['id']];
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
    return Scaffold(
      appBar: AppBar(
        title: Text("Fixtures"),
      ),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
                height: 200,
                width: double.infinity,
                child: MapSample(
                  location: fullAddress(),
                )),
            Padding(
              padding: EdgeInsets.only(top: 20, left: 20, right: 20, bottom: 5),
              child: Text(
                "${Get.arguments["location"]} - VS ${Get.arguments["against"]}",
                style: Theme.of(context).textTheme.headline2,
              ),
            ),
            Padding(
              padding: EdgeInsets.only(bottom: 20, left: 20),
              child: Text(
                "${Get.arguments["date"]} - ${Get.arguments["time"]}",
                style: Theme.of(context).textTheme.headline3,
              ),
            ),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 20),
              child: Text(
                '''${Get.arguments["description"]}
      ''',
                style: Theme.of(context).textTheme.headline3,
              ),
            ),
            GridView.builder(
              gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 3, crossAxisSpacing: 10, mainAxisSpacing: 10),
              shrinkWrap: true,
              itemCount: servicesController
                  .fixturesList.value[Get.arguments['id']].images.length,
              padding: EdgeInsets.symmetric(horizontal: 20),
              itemBuilder: (context, index) {
                return InkWell(
                  onTap: () {
                    var data = {
                      "image": servicesController.fixturesList
                          .value[Get.arguments["id"]].images[index].imgUrl!
                    };
                    Get.dialog(
                barrierColor: Colors.transparent,
                      
                      FixtureDialog(image: data["image"].toString()));
                  },
                  child: Container(
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(15),
                        image: DecorationImage(
                            image: NetworkImage(
                              "${servicesController.fixturesList.value[Get.arguments["id"]].images[index].imgUrl}",
                            ),
                            fit: BoxFit.cover)),
                  ),
                );
              },
            )
          ],
        ),
      ),
    );
  }
}

class FixtureDialog extends StatelessWidget {
  const FixtureDialog({Key? key, required this.image}) : super(key: key);

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
