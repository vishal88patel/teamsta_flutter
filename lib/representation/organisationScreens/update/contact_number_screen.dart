import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:teamsta/constants/export_constants.dart';
import 'package:teamsta/models/teamModel.dart';
import 'package:teamsta/widgets/widgets.dart';

import '../../../constants/string_constants.dart';

class ContactNumbers extends StatefulWidget {
  @override
  State<ContactNumbers> createState() => _ContactNumbersState();
}

class _ContactNumbersState extends State<ContactNumbers> {
  // const ContactNumbers({Key? key}) : super(key: key);

  TextEditingController _contactNumber = TextEditingController();
  TextEditingController _contactName = TextEditingController();

  clearControllers() {
    _contactName.clear();
    _contactNumber.clear();
  }

  // see if the mobile number starts with 07
  isValidMobileNumber(TextEditingController mobileNumber) {
    if (mobileNumber.text.isEmpty) {
      Get.snackbar("No contact number", "Please enter a contact number to add");
    }
    if (mobileNumber.text.length != 10) {
      Get.snackbar(
          "Invalid contact number", "Please insure there are 10 digits");
    }
    if (mobileNumber.text.startsWith('07')) {
      // remove the 0 and append the country code
      mobileNumber.text = '+44' + mobileNumber.text.substring(1);
      _contactNumber = mobileNumber;
    }
    return Get.snackbar('Badly formatted', 'Please correct the mobile number');
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Contact Numbers"),
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
                  "Contact Numbers",
                  style: Theme.of(context).textTheme.headline2!.copyWith(
                        fontWeight: FontWeight.w900,
                      ),
                ),
              ),
              Text(
                "Enter your contact number",
                style: Theme.of(context).textTheme.headline3,
              ),
              CustomFormField(
                controller: _contactNumber,
                cKeyBoardType: TextInputType.number,
                cInputAction: TextInputAction.next,
                hintText: "",
                caps: TextCapitalization.none,
                fillColour: formFieldLightGrey,
              ),
              Text(
                "Enter a name of your contact number",
                style: Theme.of(context).textTheme.headline3,
              ),
              CustomFormField(
                controller: _contactName,
                cKeyBoardType: TextInputType.text,
                cInputAction: TextInputAction.done,
                // hintText: "EG: Main Office",
                hintText: "",
                caps: TextCapitalization.sentences,
                fillColour: formFieldLightGrey,
              ),
              Padding(
                padding: EdgeInsets.symmetric(vertical: 20),
                child: ElevatedButton(
                    onPressed: () {
                      FocusManager.instance.primaryFocus?.unfocus();
                      if (_contactName.text.isEmpty ||
                          _contactNumber.text.isEmpty) {
                        // Get.snackbar(
                        //   '',
                        //   '',
                        //   titleText: Text(
                        //     "Form Error",
                        //     textAlign: TextAlign.center,
                        //     style: Theme.of(context)
                        //         .textTheme
                        //         .headline2!
                        //         .copyWith(color: Colors.white),
                        //   ),
                        //   messageText: Text(
                        //     "Please enter the contact details",
                        //     textAlign: TextAlign.center,
                        //     style: Theme.of(context)
                        //         .textTheme
                        //         .headline3!
                        //         .copyWith(color: Colors.white),
                        //   ),
                        // );
                        Get.snackbar(StringConstants.ERROR,
                            "Please Enter contact details",
                            colorText: Colors.white);
                      } else {
                        controller.updateContactNumbers(
                            _contactName.text, _contactNumber.text);
                        controller.userPhoneInfo.addAll(
                          {
                            _contactName.text: _contactNumber.text,
                          },
                        );
                        teamController.phoneList.value.add(
                          Contacts.fromJson(
                            {
                              'name': _contactName.text,
                              'number': _contactNumber.text
                            },
                          ),
                        );

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
                      shrinkWrap: true,
                      itemCount: teamController.phoneList.value.length,
                      itemBuilder: (context, index) {
                        if (teamController.phoneList.value.length == 0) {
                          return Center(
                            child: Text("Add Contact numbers"),
                          );
                        } else
                          return Dismissible(
                            background: Container(
                              color: Colors.red,
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.end,
                                children: [Icon(Icons.delete,color: Colors.white,),SizedBox(width: 12,)],
                              ),
                            ),
                            onDismissed: (_) {
                              var id = teamController.phoneList.value[index].id;
                              if (teamController.phoneList.value.length > 0) {
                                if (id != null) {
                                  teamController
                                      .deleteContactNumber(id)
                                      .then((_) {
                                    teamController.phoneList.value
                                        .removeAt(index);
                                  });
                                } else {
                                  teamController.phoneList.value
                                      .removeAt(index);
                                }
                              }
                            },
                            key: UniqueKey(),
                            child: ListTile(
                              // shape: Border(bottom: BorderSide(color: Colors.grey)),
                              title: Text(
                                teamController.phoneList.value[index].name,
                                style: Theme.of(context)
                                    .textTheme
                                    .headline3!
                                    .copyWith(
                                      fontWeight: FontWeight.bold,
                                    ),
                              ),
                              subtitle: Text(
                                teamController.phoneList.value[index].number,
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
                      //! only using this as the update does not take a list.
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
