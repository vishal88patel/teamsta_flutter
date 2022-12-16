import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:teamsta/constants/controllers.dart';

import '../../constants/colors.dart';

class ClubNews extends StatelessWidget {
  const ClubNews({Key? key}) : super(key: key);

  addZero(int number) {
    if (number < 10) {
      return "0$number";
    } else {
      return number.toString();
    }
  }

  @override
  Widget build(BuildContext context) {
    if (servicesController.newsList.value.length == 0) {
      return Center(
        child: Text(
          "No News at this time",
          style: Theme.of(context).textTheme.headline2,
        ),
      );
    }
    return ListView.builder(
      itemCount: servicesController.newsList.value.length,
      itemBuilder: (BuildContext context, int index) {
        DateTime ukDate = servicesController.newsList.value[index].createdAt;
        return NewsCard(
          title: servicesController.newsList.value[index].title,
          date:
              "Published - ${addZero(ukDate.day)}/${addZero(ukDate.month)}/${ukDate.year}",
          description: servicesController.newsList.value[index].description,
          image: servicesController.newsList.value[index].image!.imgUrl != null
              ? servicesController.newsList.value[index].image!.imgUrl
              : "",
          url: servicesController.newsList.value[index].url,
        );
      },
    );
  }
}

class NewsCard extends StatelessWidget {
  const NewsCard({
    Key? key,
    required this.title,
    required this.description,
    required this.date,
    required this.image,
    required this.url,
  }) : super(key: key);

  final String title;
  final String date;
  final String description;
  final String image;
  final String url;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(vertical: 10, horizontal: 20),
      child: InkWell(
        onTap: () {
          var data = {
            "title": title,
            "description": description,
            'image': image,
            'url': url,
          };
          Get.toNamed("/clubNews", arguments: data);
        },
        child: Container(
          padding: EdgeInsets.all(10),
          alignment: Alignment.centerLeft,
          height: 80,
          width: double.infinity,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(15),
            border: Border.all(color: customLightGrey, width: 2),
          ),
          child: ListTile(
            contentPadding: EdgeInsets.all(0),
            dense: false,
            minVerticalPadding: 0,
            isThreeLine: true,
            title: Text(
              title,
              style: Theme.of(context).textTheme.headline2,
            ),
            subtitle: Text(
              date,
              style: Theme.of(context).textTheme.headline3,
            ),
          ),
        ),
      ),
    );
  }
}
