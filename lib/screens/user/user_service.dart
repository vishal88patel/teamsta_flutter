import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:teamsta/constants/export_constants.dart';
import 'package:teamsta/widgets/serviceAdd.dart';

class UserService extends StatelessWidget {
  const UserService({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    servicesController.userServicesApi();
    return Scaffold(
      appBar: AppBar(
        title: Text("My Service"),
      ),
      body: Padding(
        padding: EdgeInsets.symmetric(horizontal: 20, vertical: 20),
        child: Obx(
          () {
            if (servicesController.servicesList.value.length == 0) {
              return Center(
                child: Text(
                  "You have no services as yet",
                  style: Theme.of(context).textTheme.headline2,
                ),
              );
            }

            return ListView.builder(
                itemCount: servicesController.servicesList.value.length,
                shrinkWrap: true,
                itemBuilder: (context, index) {
                  return Dismissible(
                    key: UniqueKey(),
                    onDismissed: (_) {
                      if (servicesController.servicesList.value.length > 0) {
                        servicesController.deleteService(
                            servicesController.servicesList.value[index].id);
                        servicesController.servicesList.value.removeAt(index);
                      }
                    },
                    background: Container(
                      color: Colors.red,
                      child: Icon(
                        Icons.delete,
                        size: 40,
                        color: Colors.white,
                      ),
                    ),
                    child: CustomServiceUserCared(
                      title: servicesController.servicesList.value[index].title,
                      subtitle: servicesController
                          .servicesList.value[index].description,
                      function: () {
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
                    ),
                  );
                });
          },
        ),
      ),
      bottomNavigationBar: Padding(
        padding: EdgeInsets.symmetric(horizontal: 20, vertical: 20),
        child: ElevatedButton(
          onPressed: () {
            homeOrAway.value = true;
            Get.dialog(
                barrierColor: Colors.transparent,
                AddService(isTeam: false.obs));
          },
          child: Text(
            "Create Service",
          ),
        ),
      ),
    );
  }
}

class CustomServiceUserCared extends StatelessWidget {
  const CustomServiceUserCared({
    Key? key,
    required this.title,
    required this.subtitle,
    required this.function,
  }) : super(key: key);

  final String title;
  final String subtitle;
  final VoidCallback function;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(
        vertical: 5,
      ),
      child: Container(
        height: 80,
        width: double.infinity,
        decoration: BoxDecoration(
          border: Border.all(color: customLightGrey, width: 2),
          borderRadius: BorderRadius.circular(15),
        ),
        child: Center(
          child: ListTile(
            onTap: function,
            title: Text(
              title,
              style: Theme.of(context).textTheme.headline2,
            ),
            subtitle: Text(
              subtitle,
              style: Theme.of(context).textTheme.headline3,
            ),
          ),
        ),
      ),
    );
  }
}
