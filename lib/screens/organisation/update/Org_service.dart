import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:teamsta/constants/export_constants.dart';
import 'package:teamsta/widgets/serviceAdd.dart';

class TeamServicesCreate extends StatelessWidget {
  const TeamServicesCreate({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    if (servicesController.servicesList.value.isEmpty) {
      servicesController.userServicesApi();
    }
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
                Get.dialog(
                    barrierColor: Colors.transparent,
                    AddService(
                      isTeam: true.obs,
                    ));
              },
            ),
          ),
        ]),
      ),
    );
  }
}
