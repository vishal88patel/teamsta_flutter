import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:teamsta/constants/export_constants.dart';

class More extends StatelessWidget {
  const More({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("More"),
      ),
      body: Padding(
        padding: EdgeInsets.symmetric(vertical: 20, horizontal: 10),
        child: Center(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              CustomSettingsCards(
                title:
                    "${userGetController.userInfo.value[0].firstName} ${userGetController.userInfo.value[0].lastName}",
                subtitle: userGetController.userInfo.value[0].email,
                isSubtitle: true,
                function: () {
                  var data = {
                    "name": userGetController.userInfo.value[0].firstName,
                    "surname": userGetController.userInfo.value[0].lastName,
                    "email": userGetController.userInfo.value[0].email,
                    "id": userGetController.userInfo.value[0].appUser.id,
                    "image": userGetController.userInfo.value[0].appUser.imgUrl,
                    "image_id": userGetController.userInfo.value[0].appUser.id,
                  };
                  Get.toNamed("/settings", arguments: data);
                },
              ),
              CustomSettingsCards(
                title: "My Services",
                subtitle: "",
                isSubtitle: false,
                function: () {
                  Get.toNamed("/userService");
                },
              ),
              CustomSettingsCards(
                title: "Terms and Conditions",
                subtitle: "",
                isSubtitle: false,
                function: () {
                  var data = {
                    "isMore": true,
                  };

                  Get.toNamed("/terms", arguments: data);
                },
              ),
              CustomSettingsCards(
                title: "Privacy Policy",
                subtitle: "",
                isSubtitle: false,
                function: () {
                  var data = {
                    "isMore": true,
                  };
                  Get.toNamed("/privacy", arguments: data);
                },
              ),
              CustomSettingsCards(
                title: "Delete Account",
                subtitle: "",
                isSubtitle: false,
                function: () {
                  Get.defaultDialog(
                    title: "Delete Account",
                    titleStyle: Theme.of(context).textTheme.headline2,
                    cancel: ElevatedButton(
                        onPressed: () {
                          Get.back();
                        },
                        child: Text("Cancel")),
                    confirm: ElevatedButton(
                        style: ElevatedButton.styleFrom(primary: customOrange),
                        onPressed: () {
                          controller.deleteUser();
                        },
                        child: Text("Delete")),
                    middleText:
                        "Deleting your account is permanent and cannot be undone. Are you sure you want to delete your account?",
                    middleTextStyle: Theme.of(context).textTheme.headline3,
                  );
                },
              ),
              Spacer(),
              ElevatedButton(
                  onPressed: () {
                    controller.logout();
                  },
                  child: Text("Logout"))
            ],
          ),
        ),
      ),
    );
  }
}

class CustomSettingsCards extends StatelessWidget {
  const CustomSettingsCards({
    Key? key,
    required this.title,
    required this.subtitle,
    required this.isSubtitle,
    required this.function,
  }) : super(key: key);

  final String title;
  final String subtitle;
  final bool isSubtitle;
  final VoidCallback function;

  @override
  Widget build(BuildContext context) {
    return Container(
        alignment: Alignment.bottomLeft,
        decoration: BoxDecoration(
          border: Border(
            bottom: BorderSide(
              color: customLightGrey,
              width: 2,
            ),
          ),
        ),
        height: 80,
        width: double.infinity,
        child: ListTile(
          onTap: function,
          title: Text(
            title,
            style: Theme.of(context).textTheme.headline2,
          ),
          subtitle: isSubtitle
              ? Text(
                  subtitle,
                  style: Theme.of(context).textTheme.headline3,
                )
              : null,
        ));
  }
}
