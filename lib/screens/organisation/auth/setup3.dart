import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../constants/colors.dart';
import '../../../constants/controllers.dart';
import '../../../constants/string_constants.dart';
import '../../../widgets/custom_form_field.dart';

// ignore: must_be_immutable
class Setup3 extends StatelessWidget {
// const Setup3({Key? key}) : super(key: key);

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
                fillColour: formFieldLightGrey,
                caps: TextCapitalization.none,
                validate: (value) {
                  //TODO: set a number validation to this
                },
              ),
              Text(
                "Enter a name of your contact email (E.G.Main Office)",
                style: Theme.of(context).textTheme.headline3,
              ),
              CustomFormField(
                controller: _contactName,
                cKeyBoardType: TextInputType.text,
                cInputAction: TextInputAction.done,
                hintText: "",
                caps: TextCapitalization.sentences,
                fillColour: formFieldLightGrey,
              ),
              Padding(
                padding: EdgeInsets.symmetric(vertical: 20),
                child: ElevatedButton(
                    onPressed: () {
                      if (_contactEmail.text.trim().isEmpty) {
                        Get.snackbar(
                            StringConstants.ERROR, "Please Enter Email",
                            colorText: Colors.white);
                      } else if (!GetUtils.isEmail(_contactEmail.text)) {
                        Get.snackbar(
                            StringConstants.ERROR, "Please Enter Valid Email",
                            colorText: Colors.white);
                      } else if (_contactName.text.isEmpty) {
                        Get.snackbar(StringConstants.ERROR,
                            "Please enter the contact name",
                            colorText: Colors.white);
                      } else {
                        controller.userEmailInfo[_contactName.text] =
                            _contactEmail.text.trim();
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
                      itemCount: controller.userEmailInfo.length,
                      itemBuilder: (context, index) {
                        if (controller.userEmailInfo.length == 0) {
                          return Spacer();
                        } else
                          return Dismissible(
                            background: Container(
                                alignment: Alignment.centerRight,
                                padding: EdgeInsets.only(right: 12),
                                child: Icon(Icons.delete,color: primaryWhite,size: 26,), color: Colors.red),
                            onDismissed: (_) {
                              if (controller.userEmailInfo.length > 0) {
                                var newKey = controller.userEmailInfo.keys
                                    .toList()[index];
                                controller.userEmailInfo.remove(newKey);
                                controller.userPhoneInfo.refresh();
                              }
                            },
                            //! don't change this!!!!!!
                            key: UniqueKey(),
                            child: ListTile(
                              // shape: Border(bottom: BorderSide(color: Colors.grey)),
                              title: Text(
                                controller.userEmailInfo.keys.toList()[index],
                                style: Theme.of(context)
                                    .textTheme
                                    .headline3!
                                    .copyWith(
                                      fontWeight: FontWeight.bold,
                                    ),
                              ),
                              subtitle: Text(
                                controller.userEmailInfo.values.toList()[index],
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
                    onPressed: () => Get.toNamed('/setup4'),
                    child: Text("Next")),
              )
            ],
          ),
        ),
      ),
    );
  }
}
