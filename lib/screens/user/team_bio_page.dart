import 'package:flutter/material.dart';
import 'package:get/get.dart';

class TeamBioPage extends StatelessWidget {
  const TeamBioPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Team Bio'),
      ),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              height: 200,
              width: double.infinity,
              decoration: BoxDecoration(
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withOpacity(0.5),
                    blurRadius: 10,
                    spreadRadius: 5,
                  ),
                ],
                image: DecorationImage(
                  image: NetworkImage(
                    Get.arguments["image"],
                  ),
                  fit: BoxFit.cover,
                ),
              ),
            ),
            Padding(
              padding: EdgeInsets.only(top: 20, left: 20),
              child: Text(
                Get.arguments["name"],
                style: Theme.of(context).textTheme.headline2,
              ),
            ),
            Padding(
              padding: EdgeInsets.only(bottom: 20, left: 20),
              child: Text(
                Get.arguments["position"],
                style: Theme.of(context).textTheme.headline3,
              ),
            ),
            // about me text
            Padding(
              padding: EdgeInsets.only(left: 20),
              child: Text(
                '''${Get.arguments['bio']}
      ''',
                style: Theme.of(context).textTheme.headline3,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
