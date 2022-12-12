import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_toggle_tab/flutter_toggle_tab.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:teamsta/constants/export_constants.dart';

class ResultDialog extends StatelessWidget {
  const ResultDialog({
    Key? key,
    required this.index,
  }) : super(key: key);

  static RxInt _selectedIndex = 0.obs;
  final int index;

  _result() {
    switch (_selectedIndex.value) {
      case 0:
        return "Win";
      case 1:
        return "Draw";
      default:
        return "Loss";
    }
  }

  homeOrAway(int result) {
    if (result == 0) {
      return "Home";
    } else if (result == 1) {
      return "Away";
    } else
      return "something else";
  }

  static TextEditingController _homeScoreController = TextEditingController();
  static TextEditingController _opponentScoreController =
      TextEditingController();

  clearControllers() {
    _homeScoreController.clear();
    _opponentScoreController.clear();
  }

  @override
  Widget build(BuildContext context) {
    print("index $index");
    return Scaffold(
      appBar:AppBar(
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
      body: Padding(
        padding: EdgeInsets.symmetric(horizontal: 20, vertical: 20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              padding: EdgeInsets.all(10),
              height: 85,
              width: double.infinity,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(15),
                border: Border.all(color: customLightGrey, width: 2),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                      "${homeOrAway(Get.arguments['homeOrAway'])} - Vs ${Get.arguments['opponent']}",
                      style: Theme.of(context).textTheme.headline2),
                  Text(
                    "${Get.arguments['date']} - ${Get.arguments['time']}",
                    style: Theme.of(context).textTheme.headline3,
                  ),
                ],
              ),
            ),
            Padding(
              padding: EdgeInsets.only(top: 10, bottom: 10),
              child: Text(
                "Select the Result",
                style: Theme.of(context).textTheme.headline2,
              ),
            ),
            Obx(
              () => FlutterToggleTab(
                isScroll: false,
                labels: ["Win", "Draw", "Lose"],
                borderRadius: 15,
                unSelectedBackgroundColors: [formFieldLightGrey],
                selectedBackgroundColors: [ _selectedIndex.value==0?Colors.green: _selectedIndex.value==1?customPurple:Colors.red],
                unSelectedTextStyle: Theme.of(context).textTheme.headline3!,
                selectedIndex: _selectedIndex.value,
                selectedLabelIndex: (index) {
                  _selectedIndex.value = index;
                },
                height: 40,
                width: 90,
                begin: Alignment.center,
                selectedTextStyle: Theme.of(context)
                    .textTheme
                    .headline3!
                    .copyWith(color: Colors.white),
              ),
            ),
            Padding(
              padding: EdgeInsets.only(top: 20, bottom: 10),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    "Enter your Score",
                    style: Theme.of(context).textTheme.headline3,
                  ),
                  Container(
                    width: mobileWidth / 4,
                    child: TextFormField(
                      controller: _homeScoreController,
                      textAlign: TextAlign.center,
                      keyboardType: TextInputType.number,
                      decoration: InputDecoration(
                        fillColor: formFieldLightGrey,
                      ),
                    ),
                  )
                ],
              ),
            ),
            Padding(
              padding: EdgeInsets.only(top: 20, bottom: 10),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    "Enter your Opponent's Score",
                    style: Theme.of(context).textTheme.headline3,
                  ),
                  Container(
                    width: mobileWidth / 4,
                    child: TextFormField(
                      controller: _opponentScoreController,
                      textAlign: TextAlign.center,
                      keyboardType: TextInputType.number,
                      decoration: InputDecoration(
                        fillColor: formFieldLightGrey,
                      ),
                    ),
                  )
                ],
              ),
            ),
            Padding(
              padding: EdgeInsets.symmetric(vertical: 20),
              child: ElevatedButton(
                onPressed: () async {
                  try {
                    await resultController
                        .createResult(
                      id: Get.arguments['fixtureId'],
                      awayScore: int.parse(_opponentScoreController.text),
                      homeScore: int.parse(_homeScoreController.text),
                      result: _result(),
                    )
                        .whenComplete(() {
                      clearControllers();
                      fixtureController.fixtureInfo.value
                          .removeAt(Get.arguments['listIndex']);
                      fixtureController.fixtureInfo.refresh();
                      Get.back();
                    });
                  } catch (e) {
                    Get.snackbar("Error", e.toString());
                  }
                },
                child: Text("Save"),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
