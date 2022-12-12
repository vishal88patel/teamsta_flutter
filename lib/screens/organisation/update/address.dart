import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'package:teamsta/constants/export_constants.dart';
import 'package:teamsta/widgets/widgets.dart';

class AddressSetup extends StatefulWidget {
  @override
  State<AddressSetup> createState() => _AddressSetupState();
}

setControllers() {
  controller.companyAddressLine1Controller.text = Get.arguments['addressLine1'];
  controller.companyAddressLine2Controller.text = Get.arguments['addressLine2'];
  controller.companyTownCity.text = Get.arguments['town_or_city'];
  controller.companyCounty.text = Get.arguments['county'];
  controller.companyPostCode.text = Get.arguments['postcode'];
}

class _AddressSetupState extends State<AddressSetup> {
  @override
  Widget build(BuildContext context) {
    setControllers();
    return Scaffold(
      appBar: AppBar(
        title: Text("Address"),
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
                  hintText: "",
                  caps: TextCapitalization.words,
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
                  caps: TextCapitalization.words,
                  fillColour: formFieldLightGrey,
                ),
                Padding(
                  padding: EdgeInsets.symmetric(vertical: 10),
                  child: Center(
                      child: Text(
                    "This address will also be your home fixture address",
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
                        controller.teamUpdate(boxID.read("id"));
                      },
                      child: Text("Update")),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
