import 'dart:io';
import 'dart:ui';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:teamsta/constants/colors.dart';
import 'package:teamsta/constants/constraints.dart';
import 'package:teamsta/constants/controllers.dart';
import 'package:teamsta/screens/organisation/widgets/fixturesLargeTextBox.dart';
import 'package:teamsta/screens/organisation/widgets/textFormWithTopText.dart';

import '../../constants/string_constants.dart';

class TeamNews extends StatelessWidget {
  const TeamNews({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    //--- vishal---//
    newsController.getNews();
    //--- vishal---//

    return Scaffold(
      appBar: AppBar(
        title: Text("News"),
      ),
      body: Padding(
        padding: EdgeInsets.symmetric(horizontal: 10),
        child: Column(
          children: [
            Obx(
              () {
                var data = newsController;
                if (data.newsInfo.value.length == 0) {
                  return Padding(
                    padding: EdgeInsets.only(top: mobileHight / 3),
                    child: Center(
                      child: Text(
                        "No News",
                        style: Theme.of(context).textTheme.headline2,
                      ),
                    ),
                  );
                }
                return Container(
                  height: MediaQuery.of(context).size.height-200,
                  child: ListView.builder(
                    shrinkWrap: true,
                    itemCount: data.newsInfo.value.length,
                    itemBuilder: (context, index) {
                      if (data.isLoading == true) {
                        return Center(
                          child: CircularProgressIndicator(),
                        );
                      }
                      return InkWell(
                        onTap: () {
                          /*   Get.dialog(
                              barrierColor: Colors.transparent,
                              CustomNewsDialog(comeFromEdit: true),
                              arguments: {
                                "title": data.newsInfo.value[index].title,
                                "description":
                                    data.newsInfo.value[index].description,
                                "id": data.newsInfo.value[index].id,
                                "url": data.newsInfo.value[index].url,
                                "image": data.newsInfo.value[index].image != null
                                    ? data.newsInfo.value[index].image!.imgUrl
                                    : "",
                                "imageId":
                                    data.newsInfo.value[index].image != null
                                        ? data.newsInfo.value[index].image!.id
                                        : "",
                              });*/
                        },
                        child: Dismissible(
                          background: Container(
                            color: Colors.red,
                            child: Icon(
                              Icons.delete,
                              size: 40,
                              color: Colors.white,
                            ),
                          ),
                          key: UniqueKey(),
                          onDismissed: (_) {
                            if (data.newsInfo.value.length > 0) {
                              data.deleteNews(data.newsInfo.value[index].id);
                              data.newsInfo.value.removeAt(index);
                            }
                          },
                          child: Card(
                            child: ListTile(
                              title: Text(
                                data.newsInfo.value[index].title,
                                style: Theme.of(context).textTheme.headline2,
                              ),
                              subtitle: Text(
                                "Published: ${data.newsInfo.value[index].createdAt}",
                                style: Theme.of(context).textTheme.headline3,
                              ),
                            ),
                          ),
                        ),
                      );
                    },
                  ),
                );
              },
            ),
            Spacer(),
            ElevatedButton(
                onPressed: () {
                  Get.dialog(
                      barrierColor: Colors.transparent,
                      CustomNewsDialog(
                        comeFromEdit: false,
                      ));
                },
                child: Text("Create new article"))
          ],
        ),
      ),
    );
  }
}

class CustomNewsDialog extends StatefulWidget {
  const CustomNewsDialog({
    Key? key,
    required this.comeFromEdit,
  }) : super(key: key);

  final bool comeFromEdit;

  @override
  State<CustomNewsDialog> createState() => _CustomNewsDialogState();
}

class _CustomNewsDialogState extends State<CustomNewsDialog> {
  ImagePicker _imagePicker = ImagePicker();
  TextEditingController newsTitle = TextEditingController();
  TextEditingController newsDescription = TextEditingController();
  TextEditingController newsUrl = TextEditingController();
  File? image;

  clearControllers() {
    newsTitle.clear();
    newsDescription.clear();
    newsUrl.clear();
    image = null;
  }

  isEdit() {
    if (widget.comeFromEdit == true) {
      newsTitle.text = Get.arguments["title"];
      newsDescription.text = Get.arguments["description"];
      newsUrl.text = Get.arguments["url"];
    }
  }

  // get the images from gallery
  imageFromGallery() async {
    var pickedFile = await _imagePicker.pickImage(
        source: ImageSource.gallery, maxWidth: 300);
    if (pickedFile != null) {
      setState(() {
        image = File(pickedFile.path);
      });
    }
  }

  // get the image from Camera
  imageFromCamera() async {
    var pickedFile =
        await _imagePicker.pickImage(source: ImageSource.camera, maxWidth: 300);
    if (pickedFile != null) {
      setState(() {
        image = File(pickedFile.path);
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    isEdit();
    return Scaffold(
      appBar: AppBar(
        title: Text("News"),
        leading: InkWell(
            onTap: () {
              Get.back();
              clearControllers();
            },
            child: Icon(
              CupertinoIcons.chevron_back,
              color: primaryWhite,
              size: 30,
            )),
      ),
      body: Padding(
        padding: EdgeInsets.symmetric(horizontal: 20, vertical: 30),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            TextFormWithTopText(
                controller: newsTitle,
                caps: TextCapitalization.sentences,
                text: "News Title",
                keyboard: TextInputAction.next),
            LargeTextBox(controller: newsDescription, hintText: "Description"),
            TextFormWithTopText(
                controller: newsUrl,
                text: "Add a URL to your article (Optional)",
                caps: TextCapitalization.none,
                keyboard: TextInputAction.next),
            Text(
              "Add an image to your article",
              style: Theme.of(context).textTheme.headline3,
            ),
            InkWell(
              onTap: () {
                Get.dialog(
                  barrierColor: Colors.transparent,
                  ClipRRect(
                    child: BackdropFilter(
                      filter: ImageFilter.blur(sigmaX: 3, sigmaY: 3),
                      child: Scaffold(
                        backgroundColor: Colors.white.withOpacity(.3),
                        body: Padding(
                          padding: EdgeInsets.all(20),
                          child: Column(
                              mainAxisAlignment: MainAxisAlignment.end,
                              children: [
                                ElevatedButton(
                                    onPressed: () {
                                      imageFromGallery();
                                      Get.back();
                                    },
                                    style: ElevatedButton.styleFrom(
                                      primary: Colors.white,
                                    ),
                                    child: Text(
                                      "Upload from Gallery",
                                      style: TextStyle(color: Colors.black),
                                    )),
                                Padding(
                                  padding: EdgeInsets.symmetric(vertical: 15),
                                  child: ElevatedButton(
                                      onPressed: () {
                                        imageFromCamera();
                                        Get.back();
                                      },
                                      style: ElevatedButton.styleFrom(
                                        primary: Colors.white,
                                      ),
                                      child: Text("Upload from Camera",
                                          style:
                                              TextStyle(color: Colors.black))),
                                ),
                                ElevatedButton(
                                    onPressed: () => Get.back(),
                                    style: ElevatedButton.styleFrom(
                                      primary: Colors.white,
                                    ),
                                    child: Text("Cancel",
                                        style: TextStyle(color: Colors.black))),
                              ]),
                        ),
                      ),
                    ),
                  ),
                );
              },
              child: widget.comeFromEdit
                  ? Get.arguments['image'] != ""
                      ? Padding(
                          padding: EdgeInsets.symmetric(vertical: 10),
                          child: Container(
                            height: 150,
                            width: double.infinity,
                            decoration: BoxDecoration(
                              image: DecorationImage(
                                image: image != null
                                    ? Image.file(image!).image
                                    : NetworkImage(
                                        Get.arguments['image'],
                                      ),
                                fit: BoxFit.contain,
                              ),
                            ),
                          ),
                        )
                      : Container(
                          height: 200,
                          width: double.infinity,
                          color: customLightGrey,
                          child: Icon(
                            Icons.camera_alt,
                            size: 70,
                            color: customPurple,
                          ))
                  : image != null
                      ? Padding(
                          padding: EdgeInsets.symmetric(vertical: 20),
                          child: Container(
                            height: 150,
                            width: double.infinity,
                            decoration: BoxDecoration(
                              image: DecorationImage(
                                  image: Image.file(image!).image,
                                  fit: BoxFit.contain),
                            ),
                          ),
                        )
                      //TODO: add a way to add a new imae to this

                      : Container(
                          height: 200,
                          width: double.infinity,
                          color: customLightGrey,
                          child: Icon(
                            Icons.camera_alt,
                            size: 70,
                            color: customPurple,
                          ),
                        ),
            ),
            Spacer(),
            ElevatedButton(
                onPressed: () async {
                  if (newsTitle.text.trim().isEmpty) {
                    Get.snackbar(
                        StringConstants.ERROR, "Please enter News Title",
                        colorText: Colors.white);
                  } else if (newsDescription.text.trim().isEmpty) {
                    Get.snackbar(
                        StringConstants.ERROR, "Please enter Description",
                        colorText: Colors.white);
                  } else if (image == null) {
                    Get.snackbar(StringConstants.ERROR, "Please Select Image",
                        colorText: Colors.white);
                  } else {
                    if (widget.comeFromEdit == true) {
                      if (Get.arguments['image'] != "") {
                        //! with image
                        await newsController.updateNews(
                          id: Get.arguments['id'],
                          title: newsTitle.text,
                          description: newsDescription.text,
                          uploadUrl: newsUrl.text,
                          image: image,
                          imageID: Get.arguments['imageId'],
                          wasImage: true,
                        );
                      } else {
                        await newsController.updateNews(
                          //! without image
                          id: Get.arguments["id"],
                          description: newsDescription.text,
                          title: newsTitle.text,
                          uploadUrl: newsUrl.text,
                          image: image,
                          imageID: Get.arguments['imageId'],
                          wasImage: false,
                        );
                      }
                      //add the delete image then add snd the new image to the database.

                      clearControllers();
                      Get.back();
                    } else {
                      await newsController.setNews(newsTitle.text,
                          newsDescription.text, newsUrl.text, image!.path);
                      clearControllers();
                      Get.back();
                    }
                  }
                },
                child: Text(widget.comeFromEdit ? "Update" : "Save"))
          ],
        ),
      ),
    );
  }
}
