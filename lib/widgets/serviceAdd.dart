import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:teamsta/constants/export_constants.dart';
import 'package:teamsta/global/services_list.dart';
import 'package:teamsta/screens/organisation/widgets/dateTimeFields.dart';
import 'package:teamsta/screens/organisation/widgets/fixture_switcher.dart';
import 'package:teamsta/screens/organisation/widgets/fixturesLargeTextBox.dart';
import 'package:teamsta/screens/organisation/widgets/textFormWithTopText.dart';

class AddService extends StatefulWidget {
  const AddService({
    Key? key,
    required this.isTeam,
  }) : super(key: key);

  final RxBool isTeam;

  @override
  State<AddService> createState() => _AddServiceState();
}

class _AddServiceState extends State<AddService> {
  static String? dropDownValue;
  static String? dateDropDownValue;

  TextEditingController age1 = TextEditingController();
  TextEditingController age2 = TextEditingController();

  setControllers() {
    if (Get.arguments!=null && Get.arguments['userEdit'] == true) {
      servicesController.titleController.text = Get.arguments['title'];
      servicesController.descriptionController.text =
          Get.arguments['description'];
      servicesController.address_line_1.text = Get.arguments['address_line_1'];
      servicesController.address_line_2.text = Get.arguments['address_line_2'];
      servicesController.town_or_city.text = Get.arguments['city_or_town'];
      servicesController.county.text = Get.arguments['county'];
      servicesController.postcode.text = Get.arguments['postcode'];
      servicesController.dateController.text = Get.arguments['when'];
      age1.text = Get.arguments['age1'];
      age2.text = Get.arguments['age2'];
      dropDownValue = Get.arguments['sport'];
      servicesController.abilityController.text = Get.arguments['ability'];
      servicesController.sexController.text = Get.arguments['sex'];
      dateDropDownValue = Get.arguments['available'];
      servicesController.timeController.text = Get.arguments['time'];
      // homeOrAway = Get.arguments['homeOrAway'];
    }
  }

  @override
  Widget build(BuildContext context) {
    print(widget.isTeam.value);
    print(homeOrAway.value);

    setControllers();

    return Scaffold(
      appBar: AppBar(
        title: Text("My Services"),
        leading: InkWell(
            onTap: () {
              Get.back();
            },
            child: Icon(
              CupertinoIcons.chevron_back,
              color: primaryWhite,
              size: 30,
            )),
        actions: [
          Padding(
            padding: EdgeInsets.all(10),
            child: Text(Get.arguments!=null?Get.arguments['id'].toString():""),
          )
        ],
      ),
      body: Padding(
        padding: EdgeInsets.symmetric(
          vertical: 30,
          horizontal: 10,
        ),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Padding(
                padding: EdgeInsets.symmetric(vertical: 5),
                child: TextFormWithTopText(
                  controller: servicesController.titleController,
                  text: "Service Title",
                  keyboard: TextInputAction.next,
                  caps: TextCapitalization.sentences,
                ),
              ),
              LargeTextBox(
                  controller: servicesController.descriptionController,
                  hintText: "Service Description"),
              Padding(
                padding: EdgeInsets.symmetric(vertical: 5),
                child: Text(
                  "Sport/Activity",
                  style: Theme.of(context).textTheme.headline3,
                ),
              ),
              Padding(
                  padding: EdgeInsets.symmetric(vertical: 10),
                  child: Container(
                    padding: EdgeInsets.symmetric(horizontal: 10),
                    width: mobileWidth - 40,
                    height: 50,
                    decoration: BoxDecoration(
                        color: formFieldLightGrey,
                        borderRadius: BorderRadius.circular(10)),
                    child: DropdownButton(
                      hint: Text(
                        "Select an option",
                        style: Theme.of(context).textTheme.headline3,
                      ),
                      elevation: 0,
                      iconSize: 0,
                      isExpanded: true,
                      alignment: Alignment.center,
                      style: Theme.of(context).textTheme.headline3,
                      underline: Container(),
                      value: dropDownValue,
                      onChanged: (String? newValue) {
                        setState(() {
                          dropDownValue = newValue;
                          servicesController.sportOrActivityController.text =
                              dropDownValue!;
                        });
                      },
                      items: widget.isTeam.value
                          ? teamServices
                              .map<DropdownMenuItem<String>>((String value) {
                              return DropdownMenuItem<String>(
                                value: value,
                                child: Text(value),
                              );
                            }).toList()
                          : userServices
                              .map<DropdownMenuItem<String>>((String value) {
                              return DropdownMenuItem<String>(
                                value: value,
                                child: Text(value),
                              );
                            }).toList(),
                    ),
                  )),
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 12),
                child: Text(
                  "Age Range",
                  style: Theme.of(context).textTheme.headline3,
                ),
              ),
              Padding(
                padding: EdgeInsets.symmetric(vertical: 10, horizontal: 12),
                child: Container(
                  child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          'From',
                          style: Theme.of(context).textTheme.headline3,
                        ),
                        Container(
                          width: mobileWidth / 4,
                          decoration: BoxDecoration(color: customLightGrey),
                          child: TextFormField(
                            controller: age1,
                            keyboardType: TextInputType.number,
                            decoration: InputDecoration(
                              fillColor: Colors.transparent,
                              border: InputBorder.none,
                            ),
                            style: Theme.of(context).textTheme.headline3,
                          ),
                        ),
                        Text(
                          'to',
                          style: Theme.of(context).textTheme.headline3,
                        ),
                        Container(
                          width: mobileWidth / 4,
                          decoration: BoxDecoration(color: customLightGrey),
                          child: TextFormField(
                            controller: age2,
                            keyboardType: TextInputType.number,
                            decoration: InputDecoration(
                              fillColor: Colors.transparent,
                              border: InputBorder.none,
                            ),
                            style: Theme.of(context).textTheme.headline3,
                          ),
                        )
                      ]),
                ),
              ),
              TextFormWithTopText(
                  controller: servicesController.abilityController,
                  text: "Ability Level",
                  keyboard: TextInputAction.next,
                  caps: TextCapitalization.sentences),
              TextFormWithTopText(
                  controller: servicesController.sexController,
                  text: "Sex",
                  keyboard: TextInputAction.next,
                  caps: TextCapitalization.sentences),
              Text(
                'Repeating day of the week',
                style: Theme.of(context).textTheme.headline3,
              ),
              Padding(
                padding: EdgeInsets.symmetric(vertical: 10),
                child: Container(
                  padding: EdgeInsets.symmetric(horizontal: 10),
                  width: mobileWidth - 40,
                  height: 50,
                  decoration: BoxDecoration(
                      color: customLightGrey,
                      borderRadius: BorderRadius.circular(10)),
                  child: DropdownButton(
                    hint: Text(
                      "Select an option",
                      style: Theme.of(context).textTheme.headline3,
                    ),
                    elevation: 0,
                    iconSize: 0,
                    isExpanded: true,
                    alignment: Alignment.center,
                    style: Theme.of(context).textTheme.headline3,
                    underline: Container(),
                    value: dateDropDownValue,
                    onChanged: (String? newValue) {
                      setState(() {
                        dateDropDownValue = newValue;
                        servicesController.repeatingDayController.text =
                            newValue!;
                      });
                    },
                    items: [
                      "Monday",
                      "Tuesday",
                      "Wednesday",
                      "Thursday",
                      "Friday",
                      "Saturday",
                      "Sunday"
                    ].map<DropdownMenuItem<String>>((String value) {
                      return DropdownMenuItem<String>(
                        value: value,
                        child: Text(value),
                      );
                    }).toList(),
                  ),
                ),
              ),
              Text("Date and Time",
                  style: Theme.of(context).textTheme.headline3),
              Text(
                "Leave blank if not applicable",
                style: Theme.of(context).textTheme.headline3,
              ),
              Padding(
                padding: EdgeInsets.symmetric(vertical: 10),
                child: DateTimeWidget(
                    dateController: servicesController.dateController,
                    timeController: servicesController.timeController),
              ),
              Visibility(
                  visible: widget.isTeam.value, child: FixtureSwitcher()),
              Obx(
                () => Visibility(
                  visible: homeOrAway.value,
                  child: TextFormWithTopText(
                      controller: servicesController.address_line_1,
                      text: "Address Line 1",
                      keyboard: TextInputAction.next,
                      caps: TextCapitalization.sentences),
                ),
              ),
              Obx(
                () => Visibility(
                  visible: homeOrAway.value,
                  child: TextFormWithTopText(
                      controller: servicesController.address_line_2,
                      text: "Address Line 2",
                      keyboard: TextInputAction.next,
                      caps: TextCapitalization.sentences),
                ),
              ),
              Obx(
                () => Visibility(
                  visible: homeOrAway.value,
                  child: TextFormWithTopText(
                      controller: servicesController.town_or_city,
                      text: "Town or City",
                      keyboard: TextInputAction.next,
                      caps: TextCapitalization.sentences),
                ),
              ),
              Obx(
                () => Visibility(
                  visible: homeOrAway.value,
                  child: TextFormWithTopText(
                      controller: servicesController.county,
                      text: "County",
                      keyboard: TextInputAction.next,
                      caps: TextCapitalization.words),
                ),
              ),
              Obx(() => Visibility(
                    visible: homeOrAway.value,
                    child: TextFormWithTopText(
                        controller: servicesController.postcode,
                        text: "Postcode",
                        keyboard: TextInputAction.next,
                        caps: TextCapitalization.sentences),
                  )),
              Padding(
                padding: EdgeInsets.symmetric(vertical: 10),
                child: ElevatedButton(
                  onPressed: () {
                    String age = age1.text + "-" + age2.text;
                    if (Get.arguments== null ||Get.arguments['userEdit'] == false) {
                      servicesController.createService(age).then((_) {
                        age1.clear();
                        age2.clear();
                        servicesController.userServicesApi();
                      });
                    } else {
                      servicesController
                          .updateService(Get.arguments['id'], age)
                          .then((_) {
                        age1.clear();
                        age2.clear();
                        Get.back();
                        servicesController.userServicesApi();
                      });
                    }

                    dropDownValue = null;
                    dateDropDownValue = null;
                  },
                  child: servicesController.isSetLoading.value
                      ? CircularProgressIndicator(color: Colors.white)
                      : Get.arguments != null&& Get.arguments['userEdit']
                          ? Text("Update")
                          : Text("Save"),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
