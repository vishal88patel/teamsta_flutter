import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:teamsta/constants/export_constants.dart';
import 'package:teamsta/widgets/widgets.dart';

import '../../../constants/string_constants.dart';

class Setup2 extends StatefulWidget {
  @override
  State<Setup2> createState() => _Setup2State();
}

class _Setup2State extends State<Setup2> {
  // const Setup2({Key? key}) : super(key: key);

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
        title: Text("Setup"),
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
                fillColour: formFieldLightGrey,
                caps: TextCapitalization.none,
              ),
              Text(
                "Enter a name of your contact number EG: Main Office",
                style: Theme.of(context).textTheme.headline3,
              ),
              CustomFormField(
                controller: _contactName,
                cKeyBoardType: TextInputType.text,
                cInputAction: TextInputAction.done,
                hintText: "",
                fillColour: formFieldLightGrey,
                caps: TextCapitalization.sentences,
              ),
              Padding(
                padding: EdgeInsets.symmetric(vertical: 20),
                child: ElevatedButton(
                    onPressed: () {
                      if (_contactNumber.text.isEmpty) {
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
                            "Please enter the contact number",
                            colorText: Colors.white);
                      }else if (_contactNumber.text.length != 10) {
                        Get.snackbar(StringConstants.ERROR,
                            "Please insure there are 10 digits",
                            colorText: Colors.white);
                        // Get.snackbar(
                        //     "Invalid contact number", "Please insure there are 10 digits");
                      } else if (_contactName.text.isEmpty) {
                        Get.snackbar(StringConstants.ERROR,
                            "Please enter the contact name",
                            colorText: Colors.white);
                      } else {
                        controller.userPhoneInfo[_contactName.text] =
                            _contactNumber.text;
                        clearControllers();
                        FocusManager.instance.primaryFocus?.unfocus();
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
                      itemCount: controller.userPhoneInfo.length,
                      itemBuilder: (context, index) {
                        if (controller.userPhoneInfo.length == 0) {
                          return Spacer();
                        } else
                          return Dismissible(
                            background: Container(
                              alignment: Alignment.centerRight,
                                padding: EdgeInsets.only(right: 12),
                                child: Icon(Icons.delete,color: primaryWhite,size: 26,), color: Colors.red),
                            onDismissed: (_) {
                              print("Before: " + index.toString());
                              if (controller.userPhoneInfo.length > 0) {
                                var newKey = controller.userPhoneInfo.keys
                                    .toList()[index];
                                controller.userPhoneInfo.remove(newKey);
                                controller.userPhoneInfo.refresh();
                              }
                            },
                            //! don't change this!!!!!!
                            key: UniqueKey(),
                            child: ListTile(
                              // shape: Border(bottom: BorderSide(color: Colors.grey)),
                              title: Text(
                                controller.userPhoneInfo.keys.toList()[index],
                                style: Theme.of(context)
                                    .textTheme
                                    .headline3!
                                    .copyWith(
                                      fontWeight: FontWeight.bold,
                                    ),
                              ),
                              subtitle: Text(
                                controller.userPhoneInfo.values.toList()[index],
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
                    onPressed: () => Get.toNamed('/setup3'),
                    child: Text("Next")),
              )
            ],
          ),
        ),
      ),
    );
  }
}
