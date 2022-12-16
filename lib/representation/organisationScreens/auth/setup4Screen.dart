import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';

import '../../../constants/colors.dart';
import '../../../constants/controllers.dart';
import '../../../constants/string_constants.dart';
import '../../../widgets/custom_form_field.dart';

// ignore: must_be_immutable
class Setup4 extends StatelessWidget {
  // const Setup4({Key? key}) : super(key: key);
  TextEditingController _contactWebAddress = TextEditingController();
  TextEditingController _contactWebName = TextEditingController();

  clearControllers() {
    _contactWebName.clear();
    _contactWebAddress.clear();
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
                  "Team/Organisation Website",
                  style: Theme.of(context).textTheme.headline2!.copyWith(
                        fontWeight: FontWeight.w900,
                      ),
                ),
              ),
              Text(
                "Enter your website",
                style: Theme.of(context).textTheme.headline3,
              ),
              CustomFormField(
                controller: _contactWebAddress,
                cKeyBoardType: TextInputType.text,
                cInputAction: TextInputAction.next,
                hintText: "",
                fillColour: formFieldLightGrey,
                caps: TextCapitalization.none,
                validate: (value) {
                  //TODO: set a number validation to this
                },
              ),
              Text(
                "Enter a name of your Website (E.G.Main site)",
                style: Theme.of(context).textTheme.headline3,
              ),
              CustomFormField(
                controller: _contactWebName,
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


                      if (_contactWebAddress.text.trim().isEmpty) {
                        Get.snackbar(
                            StringConstants.ERROR, "Please enter the web address",
                            colorText: Colors.white);
                      }  else if (_contactWebName.text.trim().isEmpty) {
                        Get.snackbar(StringConstants.ERROR,
                            "Please enter the website name",
                            colorText: Colors.white);
                      } else {
                        controller.userWebsiteInfo[_contactWebName.text] =
                            _contactWebAddress.text;
                        FocusManager.instance.primaryFocus?.unfocus();
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
                      itemCount: controller.userWebsiteInfo.length,
                      itemBuilder: (context, index) {
                        if (controller.userWebsiteInfo.length == 0) {
                          return Spacer();
                        } else
                          return Dismissible(
                            background: Container(
                                alignment: Alignment.centerRight,
                                padding: EdgeInsets.only(right: 12),
                                child: Icon(Icons.delete,color: primaryWhite,size: 26,), color: Colors.red),

                            onDismissed: (_) {
                              print("Before: " + index.toString());
                              if (controller.userWebsiteInfo.length > 0) {
                                var newKey = controller.userWebsiteInfo.keys
                                    .toList()[index];
                                controller.userWebsiteInfo.remove(newKey);
                                controller.userWebsiteInfo.refresh();
                              }
                            },
                            //! don't change this!!!!!!
                            key: UniqueKey(),
                            child: ListTile(
                              // shape: Border(bottom: BorderSide(color: Colors.grey)),
                              title: Text(
                                controller.userWebsiteInfo.keys.toList()[index],
                                style: Theme.of(context)
                                    .textTheme
                                    .headline3!
                                    .copyWith(
                                      fontWeight: FontWeight.bold,
                                    ),
                              ),
                              subtitle: Text(
                                controller.userWebsiteInfo.values
                                    .toList()[index],
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
                    onPressed: () => Get.toNamed('/setup5'),
                    child: Text("Next")),
              )
            ],
          ),
        ),
      ),
    );
  }
}
