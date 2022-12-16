import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:teamsta/constants/export_constants.dart';

class FixtureSwitcher extends StatelessWidget {
  const FixtureSwitcher({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Obx(() => Row(
          children: [
            Switch(
              value: homeOrAway.value,
              onChanged: (value) {
                homeOrAway.toggle();
              },
              inactiveThumbColor: customOrange,
              activeColor: Colors.grey[300],
              inactiveTrackColor: customOrange.withOpacity(.5),
            ),
            SizedBox(width: 10),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                homeOrAway.value ? Text("Away") : Text("Home"),
                homeOrAway.value ? Text("") : Text("Uses your club address"),
              ],
            )
          ],
        ));
  }
}
