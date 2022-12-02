import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:teamsta/global/services_list.dart';
import 'package:teamsta/screens/organisation/teamServicePage.dart';
import 'package:teamsta/widgets/appBottomNav.dart';
import 'package:teamsta/widgets/getLatLng.dart';

import '../../constants/export_constants.dart';
import '../../widgets/getLocation.dart';

class TeamFind extends StatelessWidget {
  const TeamFind({Key? key}) : super(key: key);

  static RxString _selectedCategory = "All categories".obs;
  static TextEditingController _findController = TextEditingController();

  getService() {
    if (servicesController.teamServices.value.length == 0) {
      servicesController.getService();
    }
  }

  static RxBool isVisible = true.obs;

  @override
  Widget build(BuildContext context) {
    // vishal-----//

    getService();
    // vishal-----//

    return Scaffold(
      appBar: AppBar(
        title: Text("Find a..."),
        bottom: PreferredSize(
          preferredSize: Size.fromHeight(100),
          child: CustomBottomSearch(
            callData: () => servicesController.getService(),
            function: () {
              servicesController.teamQueryServices.value.clear();
              if (_selectedCategory.value != "All categories") {
                if (_findController.text.isNotEmpty) {
                  for (var findInfo in servicesController.teamServices.value) {
                    if (findInfo.title
                        .toLowerCase()
                        .contains(_findController.text.toLowerCase())) {
                      servicesController.teamQueryServices.value.add(findInfo);
                    }
                  }
                } else {
                  for (var findInfo in servicesController.teamServices.value) {
                    if (findInfo.sportOrActivity
                        .contains(_selectedCategory.value)) {
                      servicesController.teamQueryServices.value.add(findInfo);
                    }
                  }
                }
              }
            },
            controller: _findController,
            itemCount: teamServices.length,
            selectedCategory: _selectedCategory,
            searchCategories: teamServices,
            onChange: (value) {
              servicesController.teamQueryServices.value.clear();
              if (_findController.text.isEmpty) {
                isVisible.value = true;
              } else {
                isVisible.value = false;
                for (var findInfo in servicesController.teamServices.value) {
                  if (findInfo.title
                      .toLowerCase()
                      .contains(value.toLowerCase())) {
                    servicesController.teamQueryServices.value.add(findInfo);
                  }
                }
              }
            },
            isVisible: isVisible,
          ),
        ),
      ),
      body: Obx(() {
        if (servicesController.isLoading.value) {
          return Center(
            child: CircularProgressIndicator(
              color: customPurple,
            ),
          );
        } else if (servicesController.teamServices.value.isEmpty) {
          return Center(
              child: Text(
            "No data Available",
            style: Theme.of(context).textTheme.headline2,
          ));
        }
        if (_selectedCategory.value != "All categories" &&
            servicesController.teamQueryServices.value.length == 0) {
          return Center(
            child: Text(
              "No results found",
              style: Theme.of(context).textTheme.headline2,
            ),
          );
        }
        if (_findController.text.isNotEmpty &&
            servicesController.teamQueryServices.value.isEmpty) {
          return Center(
            child: Text(
              "No results found",
              style: Theme.of(context).textTheme.headline2,
            ),
          );
        } else
          return Padding(
            padding: EdgeInsets.symmetric(vertical: 20),
            child: ListView.builder(
              shrinkWrap: true,
              padding: EdgeInsets.symmetric(horizontal: 10, vertical: 20),
              itemCount: (servicesController.teamQueryServices.value.length > 0)
                  ? servicesController.teamQueryServices.value.length
                  : servicesController.teamServices.value.length,
              itemBuilder: (context, index) {
                var teamInfo =
                    (servicesController.teamQueryServices.value.length > 0)
                        ? servicesController.teamQueryServices.value[index]
                        : servicesController.teamServices.value[index];
                return FutureBuilder<LatLng?>(
                    future: GetLatLng().getCoords(teamInfo.addressLine1 +
                        "," +
                        teamInfo.addressLine2 +
                        "," +
                        teamInfo.cityOrTown +
                        "," +
                        teamInfo.county +
                        "," +
                        teamInfo.postcode),
                    builder: (context, snapshot) {
                      if (snapshot.connectionState == ConnectionState.done) {
                        if (snapshot.hasData) {
                          return CustomFindCard(
                            title: teamInfo.title,
                            sport: teamInfo.sportOrActivity,
                            distance:
                                "${GetLocation().calculateDistance(snapshot.data!.latitude, snapshot.data!.longitude)} Miles",
                            onTap: () {
                              var api = teamInfo;
                              var data = {
                                "description": api.description,
                                "title": api.title,
                                "sportOrActivity": api.sportOrActivity,
                                "date": api.date,
                                "time": api.time,
                                "sex": api.sex,
                                "age": api.age,
                                "ability": api.abilityLevel,
                                "available": api.repeatingDay,
                                "when": api.date,
                                "addressLineOne": api.addressLine1,
                                "addressLineTwo": api.addressLine2,
                                "townOrCity": api.cityOrTown,
                                "county": api.county,
                                "postcode": api.postcode,
                                "isUser": false
                              };
                              Get.to(TeamServicePage(), arguments: data);
                            },
                          );
                        }
                      }
                      return Container(
                        // minHeight: 1.1,
                      );
                    });
              },
            ),
          );
      }),
    );
  }
}

class CustomFindCard extends StatelessWidget {
  const CustomFindCard(
      {Key? key,
      required this.title,
      required this.sport,
      required this.distance,
      required this.onTap})
      : super(key: key);

  final String title;
  final String sport;
  final String distance;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return Card(
      child: ListTile(
        onTap: onTap,
        isThreeLine: true,
        title: Text(
          title,
          style: Theme.of(context).textTheme.headline2,
        ),
        subtitle: Text(
          "$distance\n$sport",
          style: Theme.of(context).textTheme.headline3,
        ),
      ),
    );
  }
}
