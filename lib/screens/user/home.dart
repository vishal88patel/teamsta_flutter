import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:teamsta/constants/export_constants.dart';
import 'package:teamsta/controllers/getTeamInfoController.dart';
import 'package:teamsta/global/lists/category_list.dart';

import 'package:teamsta/widgets/appBottomNav.dart';
import 'package:teamsta/widgets/getLatLng.dart';
import 'package:teamsta/widgets/getLocation.dart';

import '../../widgets/widgets.dart';

TextEditingController homeSearchController = TextEditingController();

class HomePage extends StatelessWidget {
  const HomePage({Key? key}) : super(key: key);

  static RxBool isVisible = true.obs;
  static RxString _selectedCategory = "All categories".obs;
/*
if (_selectedCategory.value != "All categories") {
                  for (var teamInfo in teamGetController.teamInfo.value) {
                    if (teamInfo.category == _selectedCategory.value) {
                      teamGetController.queryTeamInfo.value.add(teamInfo);
                    }
                  }
                }
 */


  @override
  Widget build(BuildContext context) {
    userGetController.getUserInfo();
    return Scaffold(
      appBar: AppBar(
        title: Text("Home"),
        bottom: PreferredSize(
          preferredSize: Size.fromHeight(100),
          child: CustomBottomSearch(
            callData: () => teamGetController.getTeamInfo(),
            selectedCategory: _selectedCategory,
            itemCount: searchCategories.length,
            searchCategories: searchCategories,
            controller: homeSearchController,
            isVisible: isVisible,
            function: () {
              teamGetController.queryTeamInfo.value.clear();
              if (_selectedCategory.value != "All categories") {
                if (homeSearchController.text.isNotEmpty) {
                  for (var teamInfo in teamGetController.teamInfo.value) {
                    if (teamInfo.clubName
                        .toLowerCase()
                        .contains(homeSearchController.text.toLowerCase())) {
                      teamGetController.queryTeamInfo.value.add(teamInfo);
                    }
                  }
                } else {
                  for (var teamInfo in teamGetController.teamInfo.value) {
                    if (teamInfo.category.contains(_selectedCategory.value)) {
                      teamGetController.queryTeamInfo.value.add(teamInfo);
                    }
                  }
                }
              }
            },
            onChange: (value) {
              teamGetController.queryTeamInfo.value.clear();
              if (homeSearchController.text.isEmpty) {
                isVisible.value = true;
              } else {
                isVisible.value = false;
                for (var teamInfo in teamGetController.teamInfo.value) {
                  if (teamInfo.clubName
                      .toLowerCase()
                      .contains(value.toLowerCase())) {
                    teamGetController.queryTeamInfo.value.add(teamInfo);
                  }
                }
              }
            },
          ),
        ),
      ),
      body: Padding(
        padding: EdgeInsets.symmetric(horizontal: 10, vertical: 24),
        child: GetX<GetTeamInfoController>(
          init: teamGetController,
          builder: (controller) {
            if (controller.isLoading.value) {
              return Center(
                child: CircularProgressIndicator(color: customPurple),
              );
            } else if (controller.teamInfo.value.isEmpty) {
              return Center(
                child: Text(
                  "No Data To Show",
                  style: Theme.of(context).textTheme.headline2,
                ),
              );
            }
            if (_selectedCategory.value != "All categories" &&
                teamGetController.queryTeamInfo.value.length == 0) {
              return Center(
                child: Text(
                  "No results found",
                  style: Theme.of(context).textTheme.headline2,
                ),
              );
            }
            if (homeSearchController.text.isNotEmpty &&
                controller.queryTeamInfo.value.isEmpty) {
              return Center(
                child: Text(
                  "No results found",
                  style: Theme.of(context).textTheme.headline2,
                ),
              );
            }
            return ListView.builder(
              shrinkWrap: true,
              itemCount: (controller.queryTeamInfo.value.length > 0)
                  ? controller.queryTeamInfo.value.length
                  : controller.teamInfo.value.length,
              itemBuilder: (BuildContext context, int index) {
                var teamInfo = (controller.queryTeamInfo.value.length > 0)
                    ? controller.queryTeamInfo.value[index]
                    : controller.teamInfo.value[index];
                return FutureBuilder<LatLng?>(
                    future: GetLatLng().getCoords(teamInfo.addressLine1 +
                        ',' +
                        teamInfo.addressLine2 +
                        ',' +
                        teamInfo.town +
                        ',' +
                        teamInfo.county +
                        "," +
                        teamInfo.postcode),
                    builder: (context, snapshot) {
                      if (snapshot.connectionState == ConnectionState.done) {
                        if (snapshot.hasData) {
                          return CustomCard(
                              id: teamInfo.userId,
                              title: teamInfo.clubName,
                              subTitle:
                                  "${GetLocation().calculateDistance(snapshot.data!.latitude, snapshot.data!.longitude)} Miles - ${teamInfo.category}",
                              image: teamInfo.imgUrl ??
                                  "https://www.createanet.co.uk/wp-content/uploads/2015/12/logo-createanet-globe.png",
                              clubId: teamInfo.id);
                        }
                      }
                      return LinearProgressIndicator(
                        minHeight: 1.1,
                      );
                    });
              },
            );
          },
        ),
      ),
    );
  }
}
