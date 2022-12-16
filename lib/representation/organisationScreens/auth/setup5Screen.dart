import 'package:debug_overlay/debug_overlay.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:teamsta/constants/export_constants.dart';
import 'package:teamsta/widgets/widgets.dart';

import '../../../constants/string_constants.dart';

class Setup5 extends StatelessWidget {
  // const Setup5({Key? key}) : super(key: key);

  final checkSize = GlobalKey();

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
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Center(
                  child: Padding(
                    padding: EdgeInsets.only(top: 20),
                    child: Text(
                      'Team/Organisation Address',
                      style: Theme.of(context).textTheme.headline2!.copyWith(
                            fontWeight: FontWeight.w900,
                          ),
                    ),
                  ),
                ),
                Padding(
                  padding: EdgeInsets.only(top: 20),
                  child: Text(
                    "Address line 1",
                    style: Theme.of(context).textTheme.headline3,
                  ),
                ),
                CustomFormField(
                  controller: controller.companyAddressLine1Controller,
                  cKeyBoardType: TextInputType.text,
                  cInputAction: TextInputAction.next,
                  hintText: "",
                  caps: TextCapitalization.words,
                  fillColour: formFieldLightGrey,
                ),
                Text(
                  "Address line 2",
                  style: Theme.of(context).textTheme.headline3,
                ),
                CustomFormField(
                  controller: controller.companyAddressLine2Controller,
                  cKeyBoardType: TextInputType.text,
                  cInputAction: TextInputAction.next,
                  caps: TextCapitalization.words,
                  hintText: "",
                  fillColour: formFieldLightGrey,
                ),
                Text(
                  "Town/City",
                  style: Theme.of(context).textTheme.headline3,
                ),
                CustomFormField(
                  controller: controller.companyTownCity,
                  cKeyBoardType: TextInputType.text,
                  cInputAction: TextInputAction.next,
                  hintText: "",
                  caps: TextCapitalization.words,
                  fillColour: formFieldLightGrey,
                ),
                Text(
                  "County",
                  style: Theme.of(context).textTheme.headline3,
                ),
                CustomFormField(
                  controller: controller.companyCounty,
                  cKeyBoardType: TextInputType.text,
                  cInputAction: TextInputAction.next,
                  hintText: "",
                  caps: TextCapitalization.words,
                  fillColour: formFieldLightGrey,
                ),
                Text(
                  "Postcode",
                  style: Theme.of(context).textTheme.headline3,
                ),
                CustomFormField(
                  controller: controller.companyPostCode,
                  cKeyBoardType: TextInputType.text,
                  cInputAction: TextInputAction.done,
                  hintText: "",
                  caps: TextCapitalization.characters,
                  fillColour: formFieldLightGrey,
                ),
                Padding(
                  padding: EdgeInsets.symmetric(vertical: 10),
                  child: Center(
                      child: Text(
                    "This address will also be your HOME fixture address",
                    style: Theme.of(context).textTheme.headline3,
                  )),
                ),
                SizedBox(height: mobileHight / 8 - 5.5),
                Padding(
                  padding: EdgeInsets.only(
                    bottom: 50,
                  ),
                  child: ElevatedButton(
                    onPressed: () {
                      if (controller.companyAddressLine1Controller.text.trim().isEmpty) {
                        Get.snackbar(StringConstants.ERROR,
                            "Please enter Address Line 1",
                            colorText: Colors.white);
                      } else if (controller.companyAddressLine2Controller.text.trim().isEmpty) {
                        Get.snackbar(StringConstants.ERROR,
                            "Please enter Address Line 2",
                            colorText: Colors.white);
                      }  else if (controller.companyTownCity.text.trim().isEmpty) {
                        Get.snackbar(StringConstants.ERROR,
                            "Please enter Town/City",
                            colorText: Colors.white);
                      }  else if (controller.companyCounty.text.trim().isEmpty) {
                        Get.snackbar(StringConstants.ERROR,
                            "Please enter Country",
                            colorText: Colors.white);
                      }
                      else if (controller.companyCounty.text.trim().isEmpty) {
                        Get.snackbar(StringConstants.ERROR,
                            "Please enter Postalcode",
                            colorText: Colors.white);
                      }
                      else {
                        // Get.offAllNamed('/pending');
                       controller.teamRegistration();
                      }
                    },
                    child: Text("Next"),
                  ),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
