import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:teamsta/constants/export_constants.dart';

class ClubFixtures extends StatelessWidget {
  const ClubFixtures({Key? key}) : super(key: key);

  homeORAway(int homeOrAway) {
    if (homeOrAway == 0) {
      return "Home";
    } else {
      return "Away";
    }
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
        padding: EdgeInsets.symmetric(horizontal: 20, vertical: 20),
        child: Obx(() {
          if (servicesController.isLoading.value == true) {
            return Center(
                child: CircularProgressIndicator(
              color: customPurple,
            ));
          }
          if (servicesController.fixturesList.value.length == 0) {
            return Center(
                child: Text(
              "No Fixtures",
              style: Theme.of(context).textTheme.headline2,
            ));
          } else {
            return ListView.builder(
              itemCount: servicesController.fixturesList.value.length,
              itemBuilder: (context, index) {
                return FixturesCards(
                  date: servicesController.fixturesList.value[index].date,
                  time: servicesController.fixturesList.value[index].time,
                  location: homeORAway(
                      servicesController.fixturesList.value[index].isHome),
                  against: servicesController.fixturesList.value[index].vs,
                  index: index,
                  description:
                      servicesController.fixturesList.value[index].description,
                  images: []
                );
              },
            );
          }
        }));
  }
}

class FixturesCards extends StatelessWidget {
  const FixturesCards(
      {Key? key,
      required this.date,
      required this.time,
      required this.location,
      required this.against,
      required this.index,
      required this.description,
      required this.images})
      : super(key: key);

  final String date;
  final String time;
  final String location;
  final String against;
  final int index;
  final String description;
  final List images;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(vertical: 5),
      child: InkWell(
        onTap: () {
          var data = {
            "location": location,
            "against": against,
            "time": time,
            "date": date,
            'id': index,
            "description": description,
          };

          Get.toNamed("/fixtures", arguments: data);
        },
        child: Container(
          height: 80,
          width: double.infinity,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(15),
            border: Border.all(
              color: customLightGrey,
              width: 2,
            ),
          ),
          child: ListTile(
            title: Text(
              "$location - VS $against",
              style: Theme.of(context).textTheme.headline3!.copyWith(
                    fontWeight: FontWeight.bold,
                  ),
            ),
            subtitle: Text(
              "$date - $time",
              style: Theme.of(context).textTheme.headline3,
            ),
          ),
        ),
      ),
    );
  }
}
