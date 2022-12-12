import 'dart:io';
import 'dart:ui';

import 'package:file_picker/file_picker.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_native_image/flutter_native_image.dart';
import 'package:flutter_toggle_tab/flutter_toggle_tab.dart';
import 'package:get/get.dart';
import 'package:teamsta/constants/colors.dart';
import 'package:teamsta/constants/constraints.dart';
import 'package:teamsta/constants/controllers.dart';
import 'package:teamsta/screens/organisation/widgets/widgets.dart';

import '../../constants/strings.dart';

class ResultsForm extends StatelessWidget {
  const ResultsForm({Key? key}) : super(key: key);

  static RxInt _selectedIndex = 0.obs;

  static TextEditingController _homeScoreController = TextEditingController();
  static TextEditingController _opponentScoreController =
      TextEditingController();
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

  checkHome(int isHome) {
    if (isHome == 0) {
      return "Home";
    } else {
      return "Away";
    }
  }

  checkResult(String result) {
    switch (result) {
      case 'Win':
        _selectedIndex = 0.obs;
        break;
      case 'Draw':
        _selectedIndex = 1.obs;
        break;
      default:
        _selectedIndex = 2.obs;
    }
  }

  setupControllers() {
    _fixtureOpponentController.text = Get.arguments['vs'];
    _fixtureDescriptionController.text = Get.arguments['description'];
    // date and time
    _fixtureDateController.text = Get.arguments['date'];
    _fixtureTimeController.text = Get.arguments['time'];
    // home switch
    if (Get.arguments['isHome'] == 0) {
      homeOrAway.value = false;
    } else {
      homeOrAway.value = true;
    }
    // address
    _addressLineOne.text = Get.arguments['addressLineOne'];
    _addressLineTwo.text = Get.arguments['addressLineTwo'];
    _townCity.text = Get.arguments['townCity'];
    _county.text = Get.arguments['county'];
    _postCode.text = Get.arguments['postCode'];
  }

  @override
  Widget build(BuildContext context) {
    setupControllers();
    checkResult(Get.arguments['result']);
    return Scaffold(
      appBar: AppBar(
        title: Text("Results Form"),
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
          padding: EdgeInsets.symmetric(horizontal: 20),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Padding(
                padding: EdgeInsets.symmetric(vertical: 20),
                child: Container(
                  padding: EdgeInsets.all(20),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10),
                    color: formFieldLightGrey,
                  ),
                  height: 100,
                  width: double.infinity,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        "${checkHome(Get.arguments['isHome'])} - Vs ${Get.arguments['vs']}",
                        style: Theme.of(context).textTheme.headline2,
                      ),
                      Text(
                          "${Get.arguments['date']} - ${Get.arguments['time']}",
                          style: Theme.of(context).textTheme.headline3),
                    ],
                  ),
                ),
              ),
              Text(
                "Select the result",
                style: Theme.of(context).textTheme.headline3,
              ),
              Obx(
                () => FlutterToggleTab(
                  labels: ["Win", "Draw", "Loss"],
                  selectedLabelIndex: (index) {
                    _selectedIndex.value = index;
                  },
                  selectedTextStyle: Theme.of(context)
                      .textTheme
                      .headline3!
                      .copyWith(color: Colors.white),
                  borderRadius: 15,
                  unSelectedTextStyle: Theme.of(context).textTheme.headline3!,
                  selectedIndex: _selectedIndex.value,
                  height: 40,
                  width: 90,
                  begin: Alignment.center,
                  selectedBackgroundColors: [ _selectedIndex.value==0?Colors.green: _selectedIndex.value==1?customPurple:Colors.red],
                ),
              ),
              Padding(
                padding: EdgeInsets.symmetric(vertical: 30),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      "Enter your score",
                      style: Theme.of(context).textTheme.headline3,
                    ),
                    Container(
                      width: mobileWidth / 4,
                      child: TextFormField(
                        controller: _homeScoreController,
                        textAlign: TextAlign.center,
                        keyboardType: TextInputType.number,
                        decoration: InputDecoration(
                          hintText: Get.arguments['homeScore'].toString(),
                          fillColor: formFieldLightGrey,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              Padding(
                padding: EdgeInsets.only(bottom: 30),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      "Enter your opponent's score",
                      style: Theme.of(context).textTheme.headline3,
                    ),
                    Container(
                      width: mobileWidth / 4,
                      child: TextFormField(
                        controller: _opponentScoreController,
                        textAlign: TextAlign.center,
                        keyboardType: TextInputType.number,
                        decoration: InputDecoration(
                          hintText: Get.arguments['opponentScore'].toString(),
                          fillColor: formFieldLightGrey,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              TextFormWithTopText(
                text: "Enter the team you will be facing",
                controller: _fixtureOpponentController,
                hintText: "",
                keyboard: TextInputAction.next,
                caps: TextCapitalization.sentences,
              ),
              LargeTextBox(
                hintText: "Fixture Description",
                mainHint: "",
                controller: _fixtureDescriptionController,
              ),
              DateTimeWidget(
                  dateController: _fixtureDateController,
                  timeController: _fixtureTimeController),
              FixtureSwitcher(),
              Obx(
                () => Visibility(
                  visible: homeOrAway == true,
                  child: TextFormWithTopText(
                    text: "Fixture Address line 1",
                    controller: _addressLineOne,
                    keyboard: TextInputAction.next,
                    caps: TextCapitalization.words,
                  ),
                ),
              ),
              Obx(() => Visibility(
                    visible: homeOrAway == true,
                    child: TextFormWithTopText(
                      text: "Address line 2",
                      controller: _addressLineTwo,
                      keyboard: TextInputAction.next,
                      caps: TextCapitalization.words,
                    ),
                  )),
              Obx(() => Visibility(
                    visible: homeOrAway == true,
                    child: TextFormWithTopText(
                      text: "Town/City",
                      controller: _townCity,
                      keyboard: TextInputAction.next,
                      caps: TextCapitalization.words,
                    ),
                  )),
              Obx(() => Visibility(
                    visible: homeOrAway == true,
                    child: TextFormWithTopText(
                      text: "County",
                      controller: _county,
                      keyboard: TextInputAction.next,
                      caps: TextCapitalization.words,
                    ),
                  )),
              Obx(
                () => Visibility(
                  visible: homeOrAway == true,
                  child: TextFormWithTopText(
                    text: "Postcode",
                    controller: _postCode,
                    keyboard: TextInputAction.next,
                    caps: TextCapitalization.words,
                  ),
                ),
              ),
              CustomResultsGridView(),
              Padding(
                padding: EdgeInsets.symmetric(vertical: 30),
                child: ElevatedButton(
                  onPressed: () {
                    String _result;
                    switch (_selectedIndex.value) {
                      case 0:
                        _result = "Win";
                        break;
                      case 1:
                        _result = "Draw";
                        break;
                      default:
                        _result = "Loss";
                    }
                    resultController.editResult(
                        id: Get.arguments["id"],
                        description: Get.arguments["description"],
                        vs: Get.arguments["vs"],
                        date: Get.arguments['date'],
                        time: Get.arguments['time'],
                        result: _result,
                        homeScore: _homeScoreController.text,
                        awayScore: _opponentScoreController.text,
                        editFile: imageFile);
                  },
                  child: Obx(
                    () => Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text('update'),
                        resultController.isLoading.value == true
                            ? Transform.scale(
                                scale: 0.5,
                                child: CircularProgressIndicator(
                                  color: Colors.white,
                                ))
                            : Container()
                      ],
                    ),
                  ),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}

class CustomResultsGridView extends StatefulWidget {
  const CustomResultsGridView({
    Key? key,
  }) : super(key: key);

  @override
  State<CustomResultsGridView> createState() => _CustomResultsGridViewState();
}

class _CustomResultsGridViewState extends State<CustomResultsGridView> {
  imageFromGallery() async {
    FilePickerResult? result = await FilePicker.platform.pickFiles(
      type: FileType.image,
      allowCompression: true,
      allowMultiple: true,
    );

    if (result != null) {
       var newFile = [];
      for (var i = 0; i < result.files.length; i++) {
        if (result.files[i].size > 627000) {
          File compressedFile = await FlutterNativeImage.compressImage(
            result.files[i].path!,
            quality:quality,
            percentage: percentage,
          );
          newFile.add(compressedFile);
        } else {
          newFile.add(File(result.files[i].path!));
        }
      }
      setState(() {
        for (var file in result.files) {
          imageFile.add(File(file.path!));
        }
      });
    }
  }

  hidden() {
    if (imageFile.length == 0) {
      return false.obs;
    } else {
      return true.obs;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Padding(
          padding: EdgeInsets.symmetric(vertical: 10),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                "Result Image",
                style: Theme.of(context).textTheme.headline3,
              ),
              IconButton(
                onPressed: () {
                  if (imageFile.length > 9) {
                    Get.snackbar("Limit Reached",
                        "9 images is the limit for each result");
                  } else {
                    imageFromGallery();
                  }
                },
                icon: Icon(
                  Icons.add,
                  color: customPurple,
                ),
              ),
            ],
          ),
        ),
        Obx(
          () => Visibility(
            visible: hidden().value,
            child: Padding(
              padding: EdgeInsets.symmetric(vertical: 10),
              child: GridView.builder(
                  gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 3,
                      crossAxisSpacing: 10,
                      mainAxisSpacing: 10),
                  shrinkWrap: true,
                  itemCount: imageFile.length,
                  itemBuilder: (context, index) {
                    return InkWell(
                      onTap: () {
                        //TODO: Allow the user to see a large image
                      },
                      child: Stack(
                        children: [
                          Container(
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(15),
                              image: DecorationImage(
                                image: Image.file(imageFile[index]).image,
                                fit: BoxFit.cover,
                              ),
                            ),
                          ),
                          Positioned(
                            right: -2,
                            top: -2,
                            child: InkWell(
                              onTap: () {
                                setState(() {
                                  imageFile.removeAt(index);
                                });
                              },
                              child: CircleAvatar(
                                radius: 15,
                                backgroundColor: Colors.white,
                                child: Icon(
                                  Icons.close,
                                  color: customOrange,
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                    );
                  }),
            ),
          ),
        ),
        Padding(
          padding: const EdgeInsets.symmetric(vertical: 30),
          child: GridView.builder(
            shrinkWrap: true,
            physics: NeverScrollableScrollPhysics(),
            itemCount: resultController
                .resultsInfo.value[Get.arguments["imageIndex"]].images.length,
            gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 3,
              crossAxisSpacing: 10,
              mainAxisSpacing: 10,
            ),
            itemBuilder: (context, index) {
              return InkWell(
                onTap: () {
                  //TODO: Allow the user to see a large image
                  Get.dialog(
                    barrierColor: Colors.transparent,
                    ClipRect(
                      child: BackdropFilter(
                        filter: ImageFilter.blur(sigmaX: 5, sigmaY: 5),
                        child: Scaffold(
                          backgroundColor: Colors.white.withOpacity(0.3),
                          body: InkWell(
                            onTap: () {
                              Get.back();
                            },
                            child: Container(
                              decoration: BoxDecoration(
                                image: DecorationImage(
                                    image: NetworkImage(
                                      resultController
                                          .resultsInfo
                                          .value[Get.arguments["imageIndex"]]
                                          .images[index]
                                          .imgUrl,
                                    ),
                                    fit: BoxFit.contain),
                              ),
                            ),
                          ),
                        ),
                      ),
                    ),
                  );
                },
                child: Stack(
                  children: [
                    Container(
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(15),
                          image: DecorationImage(
                              image: NetworkImage(resultController
                                  .resultsInfo
                                  .value[Get.arguments['imageIndex']]
                                  .images[index]
                                  .imgUrl),
                              fit: BoxFit.cover)),
                    ),
                    Positioned(
                      right: -2,
                      top: -2,
                      child: InkWell(
                        onTap: () {
                          var id = resultController
                              .resultsInfo
                              .value[Get.arguments['imageIndex']]
                              .images[index]
                              .id;
                          resultController.deleteResultImage(id).then((_) {
                            resultController.resultsInfo
                                .value[Get.arguments['imageIndex']].images
                                .removeAt(index)
                                .obs;
                            setState(() {
                              resultController.resultsInfo.refresh();
                            });
                          });
                        },
                        child: CircleAvatar(
                          radius: 15,
                          backgroundColor: Colors.white,
                          child: Icon(
                            Icons.close,
                            color: customOrange,
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              );
            },
          ),
        ),
      ],
    );
  }
}
