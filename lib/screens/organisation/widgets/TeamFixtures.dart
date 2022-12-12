import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:teamsta/constants/export_constants.dart';
import 'package:teamsta/screens/organisation/widgets/fixture_form.dart';
import 'package:teamsta/screens/organisation/widgets/result_dialog.dart';

class TeamFixturesList extends StatelessWidget {
  const TeamFixturesList({Key? key}) : super(key: key);

  checkHome(int value) {
    if (value == 0) {
      return "Home";
    } else if (value == 1) {
      return "Away";
    } else
      return "something else";
  }

  @override
  Widget build(BuildContext context) {
    // vishal-----//

    fixtureController.getFixtures();
    // vishal-----//

    return Expanded(
      child: Obx(
        (() {
          if (fixtureController.fixtureInfo.value.length == 0) {
            return Center(
              child: Text(
                "No Fixtures",
                style: Theme.of(context).textTheme.headline2,
              ),
            );
          }
          return ListView.builder(
              shrinkWrap: true,
              itemCount: fixtureController.fixtureInfo.value.length,
              itemBuilder: (context, index) {
                return Dismissible(
                  background: Container(
                    color: Colors.red,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        Icon(
                          Icons.delete,
                          color: Colors.white,
                          size: 35,
                        ),
                        SizedBox(width: 8,)
                      ],
                    ),
                  ),
                  onDismissed: (_) {
                    if (fixtureController.fixtureInfo.value.length > 0) {
                      fixtureController.deleteFixture(
                          fixtureController.fixtureInfo.value[index].id!);
                      fixtureController.fixtureInfo.value.removeAt(index);
                    }
                  },
                  key: UniqueKey(),
                  child: Container(
                    padding: EdgeInsets.all(10),
                    height: 130,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(15),
                      border: Border.all(color: customLightGrey, width: 2),
                    ),
                    child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          // word
                          Text(
                            "${checkHome(fixtureController.fixtureInfo.value[index].isHome)} - ${fixtureController.fixtureInfo.value[index].vs}",
                            style: Theme.of(context).textTheme.headline2,
                          ),
                          //word
                          Text(
                              "${fixtureController.fixtureInfo.value[index].date} - ${fixtureController.fixtureInfo.value[index].time}",
                              style: Theme.of(context).textTheme.headline3!),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.start,
                            children: [
                              TextButton.icon(
                                style: TextButton.styleFrom(
                                  maximumSize: Size.fromHeight(36),
                                  padding: EdgeInsets.all(0),
                                ),
                                onPressed: () {
                                  Get.to(FixtureCreateForm(comeFromEdit: true),
                                      arguments: {
                                        "opponent": fixtureController
                                            .fixtureInfo.value[index].vs,
                                        "date": fixtureController
                                            .fixtureInfo.value[index].date,
                                        "time": fixtureController
                                            .fixtureInfo.value[index].time,
                                        "addressLine1": fixtureController
                                            .fixtureInfo
                                            .value[index]
                                            .addressLine1,
                                        "addressLIne2": fixtureController
                                            .fixtureInfo
                                            .value[index]
                                            .addressLine2,
                                        "town_or_city": fixtureController
                                            .fixtureInfo.value[index].town,
                                        "postcode": fixtureController
                                            .fixtureInfo.value[index].postcode,
                                        'county': fixtureController
                                            .fixtureInfo.value[index].county,
                                        "isHome": fixtureController
                                            .fixtureInfo.value[index].isHome,
                                        "description": fixtureController
                                            .fixtureInfo
                                            .value[index]
                                            .description,
                                        "fixtureId": fixtureController
                                            .fixtureInfo.value[index].id,
                                        "card_index": index,
                                      });
                                },
                                icon: Icon(
                                  Icons.edit,
                                  size: 20,
                                  color: customPurple,
                                ),
                                label: Text(
                                  "Edit",
                                  style: Theme.of(context).textTheme.headline3,
                                ),
                              ),
                              Spacer(),
                              TextButton.icon(
                                style: TextButton.styleFrom(
                                  maximumSize: Size.fromHeight(36),
                                  padding: EdgeInsets.all(0),
                                ),
                                onPressed: () {
                                  Get.to(
                                    ResultDialog(
                                      index: index,
                                    ),
                                    arguments: {
                                      "fixtureId": fixtureController
                                          .fixtureInfo.value[index].id,
                                      "homeOrAway": fixtureController
                                          .fixtureInfo.value[index].isHome,
                                      "opponent": fixtureController
                                          .fixtureInfo.value[index].vs,
                                      "date": fixtureController
                                          .fixtureInfo.value[index].date,
                                      "time": fixtureController
                                          .fixtureInfo.value[index].time,
                                      "addressLine1": fixtureController
                                          .fixtureInfo
                                          .value[index]
                                          .addressLine1,
                                      "addressLIne2": fixtureController
                                          .fixtureInfo
                                          .value[index]
                                          .addressLine2,
                                      "town_or_city": fixtureController
                                          .fixtureInfo.value[index].town,
                                      "postcode": fixtureController
                                          .fixtureInfo.value[index].postcode,
                                      'county': fixtureController
                                          .fixtureInfo.value[index].county,
                                      "imageUrl": fixtureController
                                          .fixtureInfo.value[index].images,
                                      "description": fixtureController
                                          .fixtureInfo.value[index].description,
                                      "listIndex": index,
                                    },
                                  );
                                },
                                icon: Icon(
                                  Icons.add,
                                  color: customPurple,
                                  size: 20,
                                ),
                                label: Text(
                                  "Add Result",
                                  style: Theme.of(context).textTheme.headline3,
                                ),
                              ),
                              Spacer()
                            ],
                          )
                        ]),
                  ),
                );
              },);
        }),
      ),
    );
  }
}
