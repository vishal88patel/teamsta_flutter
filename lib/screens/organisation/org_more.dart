import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:teamsta/constants/export_constants.dart';
import 'package:teamsta/screens/organisation/update/address.dart';
import 'package:teamsta/screens/organisation/update/contact_emails.dart';
import 'package:teamsta/screens/organisation/update/contact_number.dart';
import 'package:teamsta/screens/organisation/update/contact_websites.dart';
import 'package:teamsta/screens/organisation/update/member.dart';
import 'package:teamsta/screens/organisation/update/profile.dart';
import 'package:teamsta/screens/organisation/update/Org_service.dart';

class TeamMore extends StatelessWidget {
  const TeamMore({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    // vishal-----//

    teamGetController.getTeamInfo();
    userGetController.getUserInfo();

    // vishal-----//

    return Scaffold(
      appBar: AppBar(
        title: Text("More"),
      ),
      body: Padding(
        padding: EdgeInsets.symmetric(vertical: 20, horizontal: 10),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text("Team/Organisation information",
                  style: Theme.of(context).textTheme.headline3!),
              Divider(),
              CustomMoreCard(
                  title: "Profile",
                  subtitle: "",
                  isSubtitle: false,
                  function: () {
                    // print(
                    // userGetController.userInfo.value[0].appUser.appUserId);
                    var data = {
                      "id": userGetController.teamInfo.value[0].team.id
                    };
                    Get.to(EditProfile(), arguments: data);
                  }),
              CustomMoreCard(
                  title: "Contact Number",
                  subtitle: "",
                  isSubtitle: false,
                  function: () {
                    Get.to(ContactNumbers());
                    ;
                  }),
              CustomMoreCard(
                  title: "Contact Email Contacts",
                  subtitle: "",
                  isSubtitle: false,
                  function: () {
                    Get.to(ContactEmail());
                  }),
              CustomMoreCard(
                  title: "Websites",
                  subtitle: "",
                  isSubtitle: false,
                  function: () {
                    Get.to(ContactWebsites());
                  }),
              CustomMoreCard(
                  title: "Address",
                  subtitle: "",
                  isSubtitle: false,
                  function: () {
                    var data = {
                      "addressLine1":
                          userGetController.teamInfo.value[0].team.addressLine1,
                      "addressLine2":
                          userGetController.teamInfo.value[0].team.addressLine2,
                      "town_or_city":
                          userGetController.teamInfo.value[0].team.townOrCity,
                      "county": userGetController.teamInfo.value[0].team.county,
                      "postcode":
                          userGetController.teamInfo.value[0].team.postcode,
                    };
                    // Get.to(AddressSetup(), arguments: data);
                  }),
              CustomMoreCard(
                  title: "Team Members",
                  subtitle: "",
                  isSubtitle: false,
                  function: () {
                    // Get.to(Members());
                  }),
              CustomMoreCard(
                  title: "Services",
                  subtitle: "",
                  isSubtitle: false,
                  function: () {
                    Get.to(TeamServicesCreate());
                  }),
              CustomMoreCard(
                  title: userGetController.teamInfo.value[0].firstName,
                  subtitle: userGetController.teamInfo.value[0].email,
                  // title: "Joe Doe",
                  // subtitle: "john@doe.com",
                  isSubtitle: true,
                  function: () {
                    var imageUrl = userGetController
                            .teamInfo.value[0].team.profileImage.isEmpty
                        ? ""
                        : userGetController
                            .teamInfo.value[0].team.profileImage[0].image;
                    var imageId = userGetController
                            .teamInfo.value[0].team.profileImage.isEmpty
                        ? ""
                        : userGetController
                            .teamInfo.value[0].team.profileImage[0].id;

                    var data = {
                      "name": userGetController.teamInfo.value[0].firstName,
                      "surname": userGetController.teamInfo.value[0].lastName,
                      "email": userGetController.teamInfo.value[0].email,
                      "id": userGetController.teamInfo.value[0].team.id,
                      "image": imageUrl,
                      "image_id": imageId,
                      'isTeam': true,
                      "user_image":
                          userGetController.teamInfo.value[0].user_image
                    };
                    // Get.toNamed("/settings", arguments: data);
                    // print(userGetController.teamInfo.value[0].team.id);
                  }),



              Divider(),
              CustomMoreCard(
                  title: "Terms And Conditions",
                  subtitle: "subtitle",
                  isSubtitle: false,
                  function: () {
                    var data = {
                      "isMore": true,
                    };
                    // Get.toNamed("/terms", arguments: data);
                  }),
              CustomMoreCard(
                  title: "Privacy Policy",
                  subtitle: "subtitle",
                  isSubtitle: false,
                  function: () {
                    var data = {
                      "isMore": true,
                    };
                    // Get.toNamed("/privacy", arguments: data);
                  }),
              CustomMoreCard(
                  title: "Delete Account",
                  subtitle: "subtitle",
                  isSubtitle: false,
                  function: () {
                    Get.dialog(
                      barrierColor: Colors.transparent,
                      Center(
                        child: Container(
                          height: 300,
                          width: 300,
                          decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(15),
                          ),
                          child: Padding(
                            padding: EdgeInsets.all(5),
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Spacer(),
                                Text(
                                  "Are you sure you want to delete your account?",
                                  style: Theme.of(context).textTheme.headline3!,
                                  textAlign: TextAlign.center,
                                ),
                                Spacer(),
                                Padding(
                                  padding: EdgeInsets.symmetric(vertical: 20),
                                  child: Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceEvenly,
                                    children: [
                                      Container(
                                        width: 100,
                                        child: ElevatedButton(
                                            onPressed: () {
                                              Get.back();
                                            },
                                            child: Text("Cancel")),
                                      ),
                                      Container(
                                        width: 100,
                                        child: ElevatedButton(
                                            style: ElevatedButton.styleFrom(
                                                primary: Colors.red),
                                            onPressed: () {
                                              controller.deleteUser();
                                              boxTeamMember.erase();
                                              boxAccessToken.erase();
                                              Get.offAllNamed("/login");
                                            },
                                            child: Text("Delete")),
                                      )
                                    ],
                                  ),
                                )
                              ],
                            ),
                          ),
                        ),
                      ),
                    );
                  }),
              ElevatedButton(
                onPressed: () {
                  // controller.logout();
                },
                child: Text("Logout"),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class CustomMoreCard extends StatelessWidget {
  const CustomMoreCard({
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
