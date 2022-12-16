import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:teamsta/constants/controllers.dart';

import '../../constants/colors.dart';

class ClubServices extends StatelessWidget {
  const ClubServices({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    print(servicesController.servicesList.value.length);
    if (servicesController.servicesList.value.length == 0) {
      return Center(
        child: Text(
          "No Services at this time",
          style: Theme.of(context).textTheme.headline2,
        ),
      );
    } else
      return ListView.builder(
        itemCount: servicesController.servicesList.value.length,
        shrinkWrap: true,
        itemBuilder: (BuildContext context, int index) {
          return CustomClubServiceCard(
              function: () {
                var data = {
                  'title': servicesController.servicesList.value[index].title,
                  'description':
                      servicesController.servicesList.value[index].description,
                  // 'address': servicesController.servicesList.value[index].,
                  'ability':
                      servicesController.servicesList.value[index].ability,
                  'sport': servicesController
                      .servicesList.value[index].sport_or_activity,
                  'sex': servicesController.servicesList.value[index].sex,
                  'age': servicesController.servicesList.value[index].age,
                  'available': servicesController
                      .servicesList.value[index].repeating_day,
                  'when': servicesController.servicesList.value[index].date,
                };
                Get.toNamed("/services", arguments: data);
              },
              service: servicesController.servicesList.value[index].title);
        },
      );
  }
}

class CustomClubServiceCard extends StatelessWidget {
  const CustomClubServiceCard({
    Key? key,
    required this.service,
    required this.function,
  }) : super(key: key);

  final String service;
  final VoidCallback function;

  @override
  Widget build(BuildContext context) {
    return Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
        child: InkWell(
          onTap: function,
          child: Container(
            padding: EdgeInsets.all(10),
            alignment: Alignment.centerLeft,
            height: 80,
            width: double.infinity,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(15),
              border: Border.all(color: customLightGrey, width: 2),
            ),
            child: Text(
              service,
              style: Theme.of(context).textTheme.headline2,
            ),
          ),
        ));
  }
}
