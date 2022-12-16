import 'package:flutter/material.dart';
import 'package:flutter_toggle_tab/flutter_toggle_tab.dart';
import 'package:get/get.dart';
import 'package:teamsta/constants/export_constants.dart';
import 'package:teamsta/representation/organisationScreens/widgets/TeamFixtures.dart';
import 'package:teamsta/representation/organisationScreens/widgets/TeamResults.dart';

class OrgHomePage extends StatelessWidget {
  const OrgHomePage({Key? key}) : super(key: key);

  static RxInt _selectedIndex = 0.obs;

  _screens() {
    switch (_selectedIndex.value) {
      case 0:
        return TeamFixturesList();
      default:
        return TeamResultsList();
    }
  }

  @override
  Widget build(BuildContext context) {
    //-----vishal----///

    userGetController.getUserInfo();
    teamController.getTeam();

    //-----vishal----///

    // servicesController.teamUserServices();
    print(accessToken);
    return Scaffold(
      appBar: AppBar(
        title: Text("Fixtures"),
        bottom: PreferredSize(
          preferredSize: Size.fromHeight(100),
          child: Padding(
            padding: EdgeInsets.symmetric(horizontal: 10, vertical: 30),
            child: Obx(
              () => FlutterToggleTab(
                isScroll: false,
                labels: ["Fixtures", "Results"],
                borderRadius: 10,
                unSelectedBackgroundColors: [Colors.white.withOpacity(.3)],
                selectedBackgroundColors: [customPurple],
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
          ),
        ),
      ),
      body: Padding(
        padding: EdgeInsets.symmetric(
          horizontal: 10,
          vertical: 30,
        ),
        child: Column(
          children: [
            Obx(
              () => _screens(),
            ),
            ElevatedButton(
              onPressed: () {
                Get.toNamed("/fixtureCreate");
              },
              child: Text("Add Fixture"),
            )
          ],
        ),
      ),
    );
  }
}

