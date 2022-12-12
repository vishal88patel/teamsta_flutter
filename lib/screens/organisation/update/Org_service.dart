import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:teamsta/constants/export_constants.dart';
import 'package:teamsta/widgets/serviceAdd.dart';

class TeamServicesCreate extends StatelessWidget {
  const TeamServicesCreate({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {

      servicesController.userServicesApi();

    return Scaffold(
      appBar: AppBar(
        title: Text("Services"),
        leading: InkWell(
            onTap: () {
              Get.back();
            },
            child: Icon(
              CupertinoIcons.chevron_back,
              color: primaryWhite,
              size: 30,
            )),
      ),
      body: Padding(
        padding: EdgeInsets.symmetric(
          vertical: 20,
          horizontal: 10,
        ),
        child: Column(children: [
          Obx(() {
            if (servicesController.isLoading.value == true) {
              return Padding(
                padding: EdgeInsets.only(top: mobileHight / 2.5),
                child: Center(
                  child: CircularProgressIndicator(),
                ),
              );
            }
            if (servicesController.servicesList.value.length == 0) {
              return Padding(
                padding: EdgeInsets.only(top: mobileHight / 2.5),
                child: Center(
                  child: Text(
                    "No services at this time",
                    style: Theme.of(context).textTheme.headline2,
                  ),
                ),
              );
            } else {
              return ListView.builder(
                shrinkWrap: true,
                itemCount: servicesController.servicesList.value.length,
                itemBuilder: (context, index) {
                  return Dismissible(
                    key: UniqueKey(),
                    background: Container(
                      color: Colors.red,
                      child: Center(
                        child: Icon(
                          Icons.delete,
                          color: Colors.white,
                          size: 30,
                        ),
                      ),
                    ),
                    onDismissed: (_) {
                      if (servicesController.servicesList.value.length > 0) {
                        servicesController.deleteService(
                            servicesController.servicesList.value[index].id);
                        servicesController.servicesList.value.removeAt(index);
                      }
                    },
                    child: InkWell(
                      onTap: (){
                        var data = {
                          "title": servicesController
                              .servicesList.value[index].title,
                          "description": servicesController
                              .servicesList.value[index].description,
                          "id": servicesController.servicesList.value[index].id,
                          "sport": servicesController
                              .servicesList.value[index].sport_or_activity,
                          "sex":
                          servicesController.servicesList.value[index].sex,
                          "age1": servicesController
                              .servicesList.value[index].age
                              .split("-")[0],
                          "age2": servicesController
                              .servicesList.value[index].age
                              .split("-")[1],
                          "ability": servicesController
                              .servicesList.value[index].ability,
                          "available": servicesController
                              .servicesList.value[index].repeating_day,
                          "when":
                          servicesController.servicesList.value[index].date,
                          "address_line_1": servicesController
                              .servicesList.value[index].addressLineOne,
                          "address_line_2": servicesController
                              .servicesList.value[index].addressLineTwo,
                          "city_or_town": servicesController
                              .servicesList.value[index].city_or_town,
                          "county": servicesController
                              .servicesList.value[index].county,
                          "postcode": servicesController
                              .servicesList.value[index].postcode,
                          "time":
                          servicesController.servicesList.value[index].time,
                          "isUser": true,
                          "userEdit": true
                        };
                        // get to the edit form not the service page.

                        Get.dialog(
                            barrierColor: Colors.transparent,
                            AddService(isTeam: false.obs),
                            arguments: data);
                      },
                      child: Padding(
                        padding: EdgeInsets.symmetric(vertical: 5),
                        child: Card(
                          child: ListTile(
                            title: Text(
                              servicesController.servicesList.value[index].title,
                              style: Theme.of(context).textTheme.headline2,
                            ),
                            subtitle: Text(
                              servicesController
                                  .servicesList.value[index].description,
                              style: Theme.of(context).textTheme.headline3,
                            ),
                          ),
                        ),
                      ),
                    ),
                  );
                },
              );
            }
          }),
          Spacer(),
          Padding(
            padding: EdgeInsets.symmetric(vertical: 10),
            child: ElevatedButton(
              child: Text("Add Service"),
              onPressed: () {

                servicesController.titleController.clear();
                servicesController.descriptionController.clear();

                servicesController.address_line_1.clear();
                servicesController.address_line_2.clear();
                servicesController.town_or_city.clear();
                servicesController.county.clear();
                servicesController.postcode.clear();
                servicesController.dateController.clear();

                servicesController.abilityController.clear();
                servicesController.sexController.clear();
                servicesController.timeController.clear();

                Get.dialog(
                    barrierColor: Colors.transparent,
                    AddService(
                      isTeam: true.obs
                    ));
              },
            ),
          ),
        ]),
      ),
    );
  }
}
