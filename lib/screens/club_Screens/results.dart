import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:teamsta/constants/export_constants.dart';

class ClubResults extends StatelessWidget {
  const ClubResults({Key? key}) : super(key: key);

  checkHome(int homeOrAway) {
    if (homeOrAway == 0) {
      return "Home";
    } else {
      return "Away";
    }
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(vertical: 10),
      child: Obx(
        () {
          if (servicesController.resultsList.value.length == 0) {
            return Center(
                child: Text(
              "No Results",
              style: Theme.of(context).textTheme.headline2,
            ));
          } else {
            return ListView.builder(
                itemCount: servicesController.resultsList.value.length,
                shrinkWrap: true,
                itemBuilder: (context, index) {
                  return CustomResultsCard(
                    title:
                        "${checkHome(servicesController.resultsList.value[index].isHome)} -VS ${servicesController.resultsList.value[index].vs}",
                    date: servicesController.resultsList.value[index].date,
                    time: servicesController.resultsList.value[index].time,
                    amount:
                        "${servicesController.resultsList.value[index].homeScore} - ${servicesController.resultsList.value[index].awayScore} ",
                    result: servicesController.resultsList.value[index].result,
                    index: index,
                    description:
                        servicesController.resultsList.value[index].description,
                  );
                });
          }
        },
      ),
    );
  }
}

class CustomResultsCard extends StatelessWidget {
  const CustomResultsCard({
    Key? key,
    required this.title,
    required this.date,
    required this.time,
    required this.amount,
    required this.result,
    required this.index,
    required this.description,
  }) : super(key: key);

  final String title;
  final String date;
  final String time;
  final String amount;
  final String result;
  final int index;
  final String description;

  resultColour() {
    if (result == "Win") {
      return Colors.green;
    } else if (result == "Loss") {
      return Colors.red;
    } else
      return customPurple;
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(vertical: 5, horizontal: 20),
      child: InkWell(
        onTap: () {
          var data = {
            'title': title,
            'date': date,
            'time': time,
            'amount': amount,
            'result': result,
            'index': index,
            'description': description,
          };
          Get.toNamed("/results", arguments: data);
        },
        child: Container(
          padding: EdgeInsets.all(10),
          width: double.infinity,
          height: 100,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(15),
            border: Border.all(color: customLightGrey, width: 2),
          ),
          child: ListTile(
            contentPadding: EdgeInsets.all(0),
            dense: false,
            minVerticalPadding: 0,
            isThreeLine: true,
            title: Text(
              title,
              style: Theme.of(context)
                  .textTheme
                  .headline3!
                  .copyWith(fontWeight: FontWeight.bold),
            ),
            subtitle: Text("$date - $time",
                style: Theme.of(context).textTheme.headline3),
            trailing: Container(
              height: 100,
              width: 100,
              child: Column(
                children: [
                  Text(
                    amount,
                    style: Theme.of(context).textTheme.headline3!.copyWith(
                        fontWeight: FontWeight.bold,
                        fontSize: 17,
                        color: resultColour()),
                  ),
                  Text(
                    result,
                    style: Theme.of(context).textTheme.headline3!.copyWith(
                        fontWeight: FontWeight.bold,
                        fontSize: 17,
                        color: resultColour()),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
