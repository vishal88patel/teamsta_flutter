import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:teamsta/constants/export_constants.dart';

import '../results_form_screen.dart';

class TeamResultsList extends StatelessWidget {
  const TeamResultsList({Key? key}) : super(key: key);

  // change the color of the text with the result.
  resultColor(result) {
    if (result == "Win") {
      return Colors.green;
    } else if (result == "Draw") {
      return customPurple;
    } else {
      return Colors.red;
    }
  }

  String checkHome(int value) {
    switch (value) {
      case 0:
        return "Home";
      case 1:
        return "Away";
      default:
        return "N/A";
    }
  }

  @override
  Widget build(BuildContext context) {
    // vishal-----//

    resultController.getResult();
    // vishal-----//

    return Expanded(
      child: Obx(
        (() {
          if (resultController.resultsInfo.value.length == 0) {
            return Center(
              child: Text(
                "No Results",
                style: Theme.of(context).textTheme.headline2,
              ),
            );
          }
          return ListView.builder(
              shrinkWrap: true,
              itemCount: resultController.resultsInfo.value.length,
              itemBuilder: (context, index) {
                return Dismissible(
                  background: Container(
                    color: Colors.red,
                    child: Center(
                        child: Icon(
                      Icons.delete,
                      color: Colors.white,
                      size: 50,
                    )),
                  ),
                  onDismissed: (_) {
                    try {
                      var id = resultController.resultsInfo.value[index].id;
                      resultController.deleteResult(id).then((_) {
                        if (resultController.resultsInfo.value.length > 0) {
                          resultController.resultsInfo.value.removeAt(index);
                        }
                      });
                    } catch (e) {
                      Get.snackbar('Error', e.toString());
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
                    child: Row(
                      children: [
                        Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              // word
                              Text(
                                "${checkHome(resultController.resultsInfo.value[index].isHome)} - ${resultController.resultsInfo.value[index].vs}",
                                style: Theme.of(context).textTheme.headline2,
                              ),
                              //word
                              Text(
                                  "${resultController.resultsInfo.value[index].date} - ${resultController.resultsInfo.value[index].time}",
                                  style:
                                      Theme.of(context).textTheme.headline3!),
                              TextButton.icon(
                                style: TextButton.styleFrom(
                                  maximumSize: Size.fromHeight(36),
                                  padding: EdgeInsets.all(0),
                                ),
                                onPressed: () {
                                  var data = {
                                    "isHome": resultController
                                        .resultsInfo.value[index].isHome,
                                    "vs": resultController
                                        .resultsInfo.value[index].vs,
                                    "date": resultController
                                        .resultsInfo.value[index].date,
                                    "time": resultController
                                        .resultsInfo.value[index].time,
                                    "result": resultController
                                        .resultsInfo.value[index].result,
                                    "homeScore": resultController
                                        .resultsInfo.value[index].homeScore,
                                    "opponentScore": resultController
                                        .resultsInfo.value[index].awayScore,
                                    'description': resultController
                                        .resultsInfo.value[index].description,
                                    "imageIndex": index,
                                    "addressLineOne": resultController
                                        .resultsInfo.value[index].addressLine1,
                                    "addressLineTwo": resultController
                                        .resultsInfo.value[index].addressLine2,
                                    "townCity": resultController
                                        .resultsInfo.value[index].townOrCity,
                                    "county": resultController
                                        .resultsInfo.value[index].county,
                                    "postCode": resultController
                                        .resultsInfo.value[index].postcode,
                                    "id": resultController
                                        .resultsInfo.value[index].id,
                                   
                                  };
                                  Get.to(ResultsForm(), arguments: data);
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
                            ]),
                        Spacer(),
                        Column(
                          children: [
                            Text(
                              "${resultController.resultsInfo.value[index].homeScore} - ${resultController.resultsInfo.value[index].awayScore}",
                              style: Theme.of(context)
                                  .textTheme
                                  .headline2!
                                  .copyWith(
                                      color: resultColor(resultController
                                          .resultsInfo.value[index].result)),
                            ),
                            Text(
                              resultController.resultsInfo.value[index].result,
                              // "${controller.teamFixtures[index]['result']}",
                              style: Theme.of(context)
                                  .textTheme
                                  .headline2!
                                  .copyWith(
                                      color: resultColor(resultController
                                          .resultsInfo.value[index].result)),
                            )
                          ],
                        ),
                        Container(
                          width: 30,
                        )
                      ],
                    ),
                  ),
                );
              });
        }),
      ),
    );
  }
}
