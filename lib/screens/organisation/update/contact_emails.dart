import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:teamsta/models/teamModel.dart';

import '../../../constants/colors.dart';
import '../../../constants/controllers.dart';
import '../../../widgets/custom_form_field.dart';

// ignore: must_be_immutable
class ContactEmail extends StatefulWidget {
  @override
  State<ContactEmail> createState() => _ContactEmailState();
}

class _ContactEmailState extends State<ContactEmail> {
// const ContactEmail({Key? key}) : super(key: key);
  TextEditingController _contactName = TextEditingController();

  TextEditingController _contactEmail = TextEditingController();

  clearControllers() {
    _contactName.clear();
    _contactEmail.clear();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Email Addresses"),
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
      body: Center(
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 20, vertical: 10),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Center(
                child: Text(
                  "Team/Organisation contact information",
                  style: Theme.of(context).textTheme.headline2!.copyWith(
                        fontWeight: FontWeight.w900,
                      ),
                ),
              ),
              Padding(
                padding: EdgeInsets.only(top: 20),
                child: Text(
                  "Contact Email Address",
                  style: Theme.of(context).textTheme.headline2!.copyWith(
                        fontWeight: FontWeight.w900,
                      ),
                ),
              ),
              Text(
                "Enter your contact email",
                style: Theme.of(context).textTheme.headline3,
              ),
              CustomFormField(
                controller: _contactEmail,
                cKeyBoardType: TextInputType.emailAddress,
                cInputAction: TextInputAction.next,
                hintText: "",
                // hintText: "Email",
                caps: TextCapitalization.none,
                fillColour: customLightGrey,
                validate: (value) {
                  //TODO: set a number validation to this
                },
              ),
              Text(
                "Enter a name of your contact email EG: Main Office",
                style: Theme.of(context).textTheme.headline3,
              ),
              CustomFormField(
                controller: _contactName,
                cKeyBoardType: TextInputType.text,
                cInputAction: TextInputAction.done,
                hintText: "",
                caps: TextCapitalization.sentences,
                fillColour: customLightGrey,
              ),
              Padding(
                padding: EdgeInsets.symmetric(vertical: 20),
                child: ElevatedButton(
                    onPressed: () {
                      FocusManager.instance.primaryFocus?.unfocus();
                      if (_contactName.text.isEmpty ||
                          _contactEmail.text.isEmpty) {
                        Get.snackbar(
                          '',
                          '',
                          titleText: Text(
                            "Form Error",
                            textAlign: TextAlign.center,
                            style: Theme.of(context)
                                .textTheme
                                .headline2!
                                .copyWith(color: Colors.white),
                          ),
                          messageText: Text(
                            "Please enter the contact details",
                            textAlign: TextAlign.center,
                            style: Theme.of(context)
                                .textTheme
                                .headline3!
                                .copyWith(color: Colors.white),
                          ),
                        );
                      } else {
                        controller.updateEmailAddresses(
                            _contactName.text, _contactEmail.text);
                        teamController.emailsList.value.add(Emails.fromJson({
                          "name": _contactName.text,
                          "email": _contactEmail.text,
                        }));
                        clearControllers();
                      }
                    },
                    child: Text("Add")),
              ),
              Divider(
                thickness: 1,
                indent: 10,
                endIndent: 10,
              ),
              Expanded(
                child: Obx(() => ListView.builder(
                      itemCount: teamController.emailsList.value.length,
                      itemBuilder: (context, index) {
                        if (teamController.emailsList.value.length == 0) {
                          return Spacer();
                        } else
                          return Dismissible(
                            background: Container(color: Colors.red),
                            onDismissed: (_) {
                              var id = teamController.phoneList.value[index].id;
                              if (teamController.emailsList.value.length > 0) {
                                if (id != null) {
                                  teamController.deleteEmail(id).then((_) {
                                    teamController.emailsList.value
                                        .removeAt(index);
                                  });
                                }
                              }
                            },
                            key: UniqueKey(),
                            child: ListTile(
                              // shape: Border(bottom: BorderSide(color: Colors.grey)),
                              title: Text(
                                teamController.emailsList.value[index].name,
                                style: Theme.of(context)
                                    .textTheme
                                    .headline3!
                                    .copyWith(
                                      fontWeight: FontWeight.bold,
                                    ),
                              ),
                              subtitle: Text(
                                teamController.emailsList.value[index].email,
                                style: Theme.of(context).textTheme.headline3,
                              ),
                            ),
                          );
                      },
                    )),
              ),
              Padding(
                padding: EdgeInsets.only(bottom: 50, top: 20),
                child: ElevatedButton(
                    onPressed: () {
                      //! The update call only takes in one at a time so done in add
                      // just adding this hear so it feels like it's been updated
                      Future.delayed(Duration(seconds: 2), () => Get.back());
                    },
                    child: Text("Update")),
              )
            ],
          ),
        ),
      ),
    );
  }
}
