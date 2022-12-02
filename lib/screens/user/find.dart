import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:teamsta/constants/export_constants.dart';
import 'package:teamsta/global/services_list.dart';
import 'package:teamsta/widgets/appBottomNav.dart';
import 'package:teamsta/widgets/getLatLng.dart';
import 'package:teamsta/widgets/getLocation.dart';

import '../../global/lists/category_list.dart';

TextEditingController _searchControllerFind = TextEditingController();

class FindPage extends StatelessWidget {
  const FindPage({Key? key}) : super(key: key);

  static RxString _selectedCategory = "All categories".obs;
  static RxBool isVisible = true.obs;

  @override
  Widget build(BuildContext context) {
    if (servicesController.userServices.value.isEmpty) {
      servicesController.getService();
    }
    return Scaffold(
      appBar: AppBar(
        title: Text("Find a..."),
        bottom: PreferredSize(
          preferredSize: Size.fromHeight(100),
          child: CustomBottomSearch(
           callData: ()=> servicesController.getService(),
            function: () {
              servicesController.userQueryServices.value.clear();
              if (_selectedCategory.value != "All categories") {
                if (_searchControllerFind.text.isNotEmpty) {
                  for (var findInfo in servicesController.userServices.value) {
                    if (findInfo.title
                        .toLowerCase()
                        .contains(_searchControllerFind.text.toLowerCase())) {
                      servicesController.userQueryServices.value.add(findInfo);
                    }
                  }
                } else {
                  for (var findInfo in servicesController.userServices.value) {
                    if (findInfo.sportOrActivity
                        .contains(_selectedCategory.value)) {
                      servicesController.userQueryServices.value.add(findInfo);
                    }
                  }
                }
              }
            },
            controller: _searchControllerFind,
            itemCount: teamServices.length,
            searchCategories: searchCategories,
            selectedCategory: _selectedCategory,
            onChange: (value) {
              servicesController.userQueryServices.value.clear();
              if (_searchControllerFind.text.isEmpty) {
                isVisible.value = true;
              } else {
                isVisible.value = false;
                for (var findInfo in servicesController.userServices.value) {
                  if (findInfo.title
                      .toLowerCase()
                      .contains(_searchControllerFind.text.toLowerCase())) {
                    servicesController.userQueryServices.value.add(findInfo);
                  }
                }
              }
            },
            isVisible: isVisible,
          ),
        ),
      ),
      body: Obx(
        () {
          if (servicesController.isLoading.value) {
            return Center(
              child: CircularProgressIndicator(
                color: customPurple,
              ),
            );
          } else if (servicesController.userServices.value.isEmpty) {
            return Center(
              child: Text(
                "Nothing to show at this time",
                style: Theme.of(context).textTheme.headline2,
              ),
            );
          }
          if (_selectedCategory.value != "All categories" &&
              servicesController.userQueryServices.value.isEmpty) {
            return Center(
              child: Text(
                "No results found",
                style: Theme.of(context).textTheme.headline2,
              ),
            );
          }
          {}
          if (_searchControllerFind.text.isNotEmpty &&
              servicesController.userQueryServices.value.isEmpty) {
            return Center(
              child: Text(
                "No results found",
                style: Theme.of(context).textTheme.headline2,
              ),
            );
          } else
            return Obx(
              () {
                return ListView.builder(
                  itemCount:
                      (servicesController.userQueryServices.value.isEmpty)
                          ? servicesController.userServices.value.length
                          : servicesController.userQueryServices.value.length,
                  itemBuilder: (context, index) {
                    var userInfo =
                        (servicesController.userQueryServices.value.isEmpty)
                            ? servicesController.userServices.value[index]
                            : servicesController.userQueryServices.value[index];
                    return Padding(
                      padding: const EdgeInsets.symmetric(
                          vertical: 10, horizontal: 20),
                      child: Card(
                        child: ListTile(
                          isThreeLine: true,
                          title: Text(
                            userInfo.title,
                            style: Theme.of(context).textTheme.headline2,
                          ),
                          subtitle: FutureBuilder<LatLng?>(
                              future: GetLatLng().getCoords(
                                userInfo.address_line_1 +
                                    "," +
                                    userInfo.address_line_2 +
                                    "," +
                                    userInfo.town_or_city +
                                    "," +
                                    userInfo.county +
                                    "," +
                                    userInfo.postCode,
                              ),
                              builder: (context, snapshot) {
                                if (snapshot.connectionState ==
                                    ConnectionState.done) {
                                  return Text(
                                    "${GetLocation().calculateDistance(snapshot.data!.latitude, snapshot.data!.longitude)} Miles \n${userInfo.sportOrActivity}",
                                    style:
                                        Theme.of(context).textTheme.headline3,
                                  );
                                }
                                return LinearProgressIndicator(
                                  minHeight: 1.1,
                                );
                              }),
                          onTap: () {
                            var service = userInfo;
                            var data = {
                              "sport": service.sportOrActivity,
                              "sex": service.sex,
                              "age": service.age,
                              "ability": service.abilityLevel,
                              "available": service.repeatingDay,
                              "when": service.date,
                              "title": service.title,
                              "description": service.description,
                              "address_line_1": service.address_line_1,
                              "address_line_2": service.address_line_2,
                              "city_or_town": service.town_or_city,
                              "county": service.county,
                              "postcode": service.postCode,
                              "isUser": true,
                              "id": service.userId,
                              //TODO: add the team info here to get the club page working.
                              // servicesPage
                              //custom_cards.dart
                              //find.dart
                              
                            };
                            Get.toNamed("/services", arguments: data);
                          },
                        ),
                      ),
                    );
                  },
                );
              },
            );
        },
      ),
    );
  }
}
