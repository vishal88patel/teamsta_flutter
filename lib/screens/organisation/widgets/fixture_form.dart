import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:teamsta/constants/export_constants.dart';
import 'package:teamsta/screens/organisation/widgets/widgets.dart';
import 'dart:io';

import '../../../constants/string_constants.dart';

class FixtureCreateForm extends StatefulWidget {
  const FixtureCreateForm({
    Key? key,
    required this.comeFromEdit,
  }) : super(key: key);
  // see if the team is coming from edit or create
  final bool comeFromEdit;

  static TextEditingController _fixtureOpponentController =
      TextEditingController();
  static TextEditingController _fixtureDescriptionController =
      TextEditingController();
  static TextEditingController _fixtureDateController = TextEditingController();
  static TextEditingController _fixtureTimeController = TextEditingController();
  static TextEditingController _addressLineOne = TextEditingController();
  static TextEditingController _addressLineTwo = TextEditingController();
  static TextEditingController _townCity = TextEditingController();
  static TextEditingController _county = TextEditingController();
  static TextEditingController _postCode = TextEditingController();

  @override
  State<FixtureCreateForm> createState() => _FixtureCreateFormState();
}

class _FixtureCreateFormState extends State<FixtureCreateForm> {
  String setLocation() {
    if (homeOrAway == false) {
      return "Home";
    } else
      return "Away";
  }

  checkIsHome() {
    if (homeOrAway.value == 0) {
      return false;
    } else
      return true;
  }


  clearControllers() {
    FixtureCreateForm._fixtureOpponentController.clear();
    FixtureCreateForm._fixtureDescriptionController.clear();
    FixtureCreateForm._fixtureDateController.clear();
    FixtureCreateForm._fixtureTimeController.clear();
    FixtureCreateForm._addressLineOne.clear();
    FixtureCreateForm._addressLineTwo.clear();
    FixtureCreateForm._townCity.clear();
    FixtureCreateForm._county.clear();
    FixtureCreateForm._postCode.clear();
    imageFile = [];
  }

  setupControllers() {
    FixtureCreateForm._fixtureOpponentController.text = Get.arguments["opponent"];
    FixtureCreateForm._fixtureDescriptionController.text = Get.arguments["description"];
    FixtureCreateForm._fixtureDateController.text = Get.arguments["date"];
    FixtureCreateForm._fixtureTimeController.text = Get.arguments["time"];
    FixtureCreateForm._addressLineOne.text = Get.arguments["addressLine1"];
    FixtureCreateForm._addressLineTwo.text = Get.arguments["addressLine2"] != null
        ? Get.arguments["addressLine2"]
        : "";
    FixtureCreateForm._townCity.text = Get.arguments["town_or_city"];
    FixtureCreateForm._county.text = Get.arguments["county"];
    FixtureCreateForm._postCode.text = Get.arguments["postcode"];
    if (Get.arguments['isHome'] == 0) {
      homeOrAway.value = false;
    } else {
      homeOrAway.value = true;
    }
  }
  @override
  void initState() {

    super.initState();
  }
  @override
  void dispose() {
    clearControllers();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    widget.comeFromEdit ? setupControllers() : null;
    imageFile = [];
    fixtureController.isLoading = false.obs;
    return Scaffold(
      appBar: AppBar(
        title: Text("Fixtures"),
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
      body: SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 20, vertical: 20),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              TextFormWithTopText(
                text: "Enter the team you will be facing",
                controller: FixtureCreateForm._fixtureOpponentController,
                keyboard: TextInputAction.next,
                caps: TextCapitalization.sentences,
              ),
              LargeTextBox(
                hintText: "Fixture Description",
                controller: FixtureCreateForm._fixtureDescriptionController,
              ),
              DateTimeWidget(
                  dateController: FixtureCreateForm._fixtureDateController,
                  timeController: FixtureCreateForm._fixtureTimeController),
              FixtureSwitcher(),
              Obx(
                () => Visibility(
                  visible: homeOrAway == true,
                  child: TextFormWithTopText(
                    text: "Fixture Address line 1",
                    controller: FixtureCreateForm._addressLineOne,
                    keyboard: TextInputAction.next,
                    caps: TextCapitalization.words,
                  ),
                ),
              ),
              Obx(() => Visibility(
                    visible: homeOrAway == true,
                    child: TextFormWithTopText(
                      text: "Address line 2",
                      controller: FixtureCreateForm._addressLineTwo,
                      keyboard: TextInputAction.next,
                      caps: TextCapitalization.words,
                    ),
                  )),
              Obx(() => Visibility(
                    visible: homeOrAway == true,
                    child: TextFormWithTopText(
                      text: "Town/City",
                      controller: FixtureCreateForm._townCity,
                      keyboard: TextInputAction.next,
                      caps: TextCapitalization.words,
                    ),
                  )),
              Obx(() => Visibility(
                    visible: homeOrAway == true,
                    child: TextFormWithTopText(
                      text: "County",
                      controller: FixtureCreateForm._county,
                      keyboard: TextInputAction.next,
                      caps: TextCapitalization.words,
                    ),
                  )),
              Obx(
                () => Visibility(
                  visible: homeOrAway == true,
                  child: TextFormWithTopText(
                    text: "Postcode",
                    controller: FixtureCreateForm._postCode,
                    keyboard: TextInputAction.next,
                    caps: TextCapitalization.words,
                  ),
                ),
              ),
              widget.comeFromEdit ? GridWidget() : ImageAddGrid(),
              Padding(
                padding: EdgeInsets.symmetric(vertical: 10),
                child: ElevatedButton(
                  onPressed: () async {

                    if ( FixtureCreateForm._fixtureOpponentController.text.trim().isEmpty) {
                      Get.snackbar(StringConstants.ERROR,
                          "Please enter the team you will be facing",
                          colorText: Colors.white);
                    } else if (FixtureCreateForm._fixtureDescriptionController.text.trim().isEmpty) {
                      Get.snackbar(StringConstants.ERROR,
                          "Please enter Fixure Description",
                          colorText: Colors.white);
                    }  else if (FixtureCreateForm._fixtureDateController.text.trim().isEmpty) {
                      Get.snackbar(StringConstants.ERROR,
                          "Please enter Date",
                          colorText: Colors.white);
                    }  else if (FixtureCreateForm._fixtureTimeController.text.trim().isEmpty) {
                      Get.snackbar(StringConstants.ERROR,
                          "Please enter Time",
                          colorText: Colors.white);
                    }
                    else if ( widget.comeFromEdit!=true && imageFile.isEmpty) {
                      Get.snackbar(StringConstants.ERROR,
                          "Please enter Fixture Images",
                          colorText: Colors.white);
                    }
                    else {
                      if (widget.comeFromEdit == true) {
                        print(Get.arguments["fixtureId"]);
                        await fixtureController.editFixture(
                          vs: FixtureCreateForm._fixtureOpponentController.text,
                          date: FixtureCreateForm._fixtureDateController.text,
                          time: FixtureCreateForm._fixtureTimeController.text,
                          addressLine1: FixtureCreateForm._addressLineOne.text,
                          addressLine2: FixtureCreateForm._addressLineTwo.text,
                          town: FixtureCreateForm._townCity.text,
                          county: FixtureCreateForm._county.text,
                          postCode: FixtureCreateForm._postCode.text,
                          description: FixtureCreateForm._fixtureDescriptionController.text,
                          isHome: Get.arguments['isHome'],
                          id: Get.arguments['fixtureId'],
                          editFile: List<File>.from(imageFile),
                        );

                        Get.back();
                      } else {
                        // if the fixture is away it will grab the controllers set by the user

                        var _address_line_1 = FixtureCreateForm._addressLineOne.text;
                        var _address_line_2 = FixtureCreateForm._addressLineTwo.text;
                        var _town_or_city = FixtureCreateForm._townCity.text;
                        var _countyName = FixtureCreateForm._county.text;
                        var _postcode = FixtureCreateForm._postCode.text;
                        if (homeOrAway == false) {
                          // if the fixture is home it will grab the address from the boxes
                          _address_line_1 = boxHomeAddress.read("address_line_1");
                          _address_line_2 =
                          boxHomeAddress.read("address_line_2") != null
                              ? boxHomeAddress.read('address_line_2')
                              : "";
                          _town_or_city = boxHomeAddress.read("town_or_city");
                          _countyName = boxHomeAddress.read("county");
                          _postcode = boxHomeAddress.read("post_code");
                        }
                        // we then send the data to the fixture create controller
                        await fixtureController.fixtureCreate(
                          vs: FixtureCreateForm._fixtureOpponentController.text,
                          date: FixtureCreateForm._fixtureDateController.text,
                          time: FixtureCreateForm._fixtureTimeController.text,
                          addressLine1: _address_line_1,
                          addressLine2: _address_line_2,
                          town: _town_or_city,
                          county: _countyName,
                          postCode: _postcode,
                          description: FixtureCreateForm._fixtureDescriptionController.text,
                          isHome: homeOrAway.value ? "1" : "0",
                          imageFile: imageFile != null ? imageFile : null,
                        );

                        Get.back();
                      }
                    }


                  },
                  child: Obx(
                    (() => Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text(widget.comeFromEdit ? "Update" : "Save"),
                            fixtureController.isLoading.value == true
                                ? Transform.scale(
                                    scale: 0.5,
                                    child: CircularProgressIndicator(
                                      color: Colors.white,
                                    ))
                                : Container(),
                          ],
                        )),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
