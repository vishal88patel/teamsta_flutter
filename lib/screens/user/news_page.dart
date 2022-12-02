import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:teamsta/constants/colors.dart';
import 'package:url_launcher/url_launcher.dart';

class NewsPage extends StatelessWidget {
  const NewsPage({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("News"),
      ),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              height: Get.arguments['image'] == '' ? 1 : 300,
              width: double.infinity,
              child: Get.arguments['image'] == ''
                  ? null
                  : Image.network(Get.arguments['image'],
                      loadingBuilder: (context, child, loadingProgress) {
                      if (loadingProgress == null) {
                        return child;
                      }
                      return const Center(
                        child: CircularProgressIndicator(
                          color: customPurple,
                        ),
                      );
                    }, errorBuilder: (context, error, stackTrace) {
                      return const Center(
                        child: Text('Error loading image'),
                      );
                    }, fit: BoxFit.fitHeight),
            ),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 20, vertical: 20),
              child: Text(
                Get.arguments["title"],
                style: Theme.of(context).textTheme.headline2,
              ),
            ),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 20),
              child: Text(
                '''${Get.arguments["description"]}
      ''',
                style: Theme.of(context).textTheme.headline3,
              ),
            ),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 20),
              child: ElevatedButton(
                onPressed: () {
                  //TODO: this will no longer be http but will come from the server as http
                  launchUrl(Uri.parse("https://" + Get.arguments["url"]));
                },
                child: Text("More Info"),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
