import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'package:teamsta/widgets/google_maps.dart';

import '../../constants/export_constants.dart';

class ResultsPage extends StatelessWidget {
  const ResultsPage({
    Key? key,
  }) : super(key: key);

  resultsColor() {
    String? result = Get.arguments['result'];
    if (result == "Win") {
      return Colors.green;
    } else if (result == "Loss") {
      return Colors.red;
    } else {
      return customPurple;
    }
  }

  fullAddress() {
    var value = servicesController.resultsList.value[Get.arguments['index']];
    var fullAddress = value.addressLine1 +
        "," +
        value.addressLine2 +
        "," +
        value.townOrCity +
        "," +
        value.county +
        "," +
        value.postcode;
    return fullAddress;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Result"),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.only(bottom: 20),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                height: 200,
                child: MapSample(location: fullAddress()),
              ),
              Padding(
                padding: EdgeInsets.only(top: 10, left: 20, right: 20),
                child: Row(
                  children: [
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          Get.arguments['title'].toString(),
                          style: Theme.of(context).textTheme.headline2,
                        ),
                        Text(
                          "${Get.arguments['date']} - ${Get.arguments['time']}",
                          style: Theme.of(context).textTheme.headline3,
                        ),
                      ],
                    ),
                    Spacer(),
                    Column(
                      children: [
                        Text(
                          Get.arguments['amount'].toString(),
                          style:
                              Theme.of(context).textTheme.headline2!.copyWith(
                                    color: resultsColor(),
                                  ),
                        ),
                        Text(
                          Get.arguments['result'].toString(),
                          style:
                              Theme.of(context).textTheme.headline2!.copyWith(
                                    color: resultsColor(),
                                  ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
              Padding(
                padding: EdgeInsets.symmetric(vertical: 10, horizontal: 20),
                child: Text(
                  '''${Get.arguments['description']}
      ''',
                  style: Theme.of(context).textTheme.headline3,
                ),
              ),
              GridView.builder(
                gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 3,
                    crossAxisSpacing: 10,
                    mainAxisSpacing: 10),
                shrinkWrap: true,
                itemCount: servicesController
                    .resultsList.value[Get.arguments['index']].images.length,
                padding: EdgeInsets.symmetric(horizontal: 20),
                itemBuilder: (context, index) {
                  return InkWell(
                    onTap: () {
                      var data = {
                        "image": servicesController.resultsList
                            .value[Get.arguments["index"]].images[index].imgUrl
                      };
                      Get.dialog(CustomDialog(image: data["image"].toString()));
                    },
                    child: Container(
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(15),
                          image: DecorationImage(
                              image: NetworkImage(
                                  "${servicesController.resultsList.value[Get.arguments["index"]].images[index].imgUrl}"),
                              fit: BoxFit.cover)),
                    ),
                  );
                },
              )
            ],
          ),
        ),
      ),
    );
  }
}

class CustomDialog extends StatelessWidget {
  const CustomDialog({Key? key, required this.image}) : super(key: key);

  final String image;

  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      child: BackdropFilter(
        filter: ImageFilter.blur(sigmaX: 3, sigmaY: 3),
        child: Scaffold(
          backgroundColor: Colors.white.withOpacity(.5),
          body: InkWell(
            onTap: (() => Get.back()),
            child: Container(
              decoration: BoxDecoration(
                image: DecorationImage(
                    image: NetworkImage(image), fit: BoxFit.contain),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
