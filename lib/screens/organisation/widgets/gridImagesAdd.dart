import 'dart:io';
import 'dart:ui';

import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:flutter_native_image/flutter_native_image.dart';
import 'package:get/get.dart';

import 'package:teamsta/constants/export_constants.dart';

class ImageAddGrid extends StatefulWidget {
  const ImageAddGrid({Key? key}) : super(key: key);

  @override
  State<ImageAddGrid> createState() => _ImageAddGridState();
}

class _ImageAddGridState extends State<ImageAddGrid> {
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
            quality: quality,
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

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Padding(
          padding: EdgeInsets.symmetric(vertical: 5),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                "Fixture Images",
                style: Theme.of(context).textTheme.headline3,
              ),
              IconButton(
                onPressed: () {
                  if (imageFile.length > 9) {
                    Get.snackbar(
                        'Limit Reached', '9 image is the limit for each ');
                  } else {
                    imageFromGallery();
                  }
                },
                icon: Icon(
                  Icons.add,
                  color: customPurple,
                ),
              )
            ],
          ),
        ),
        GridView.builder(
          gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 3,
            crossAxisSpacing: 10,
            mainAxisSpacing: 10,
          ),
          itemCount: imageFile.length,
          shrinkWrap: true,
          physics: const NeverScrollableScrollPhysics(),
          itemBuilder: (context, index) {
            return InkWell(
              onTap: () {
                setState(() {
                  imageFile.removeAt(index);
                });
              },
              child: Stack(
                clipBehavior: Clip.none,
                children: [
                  Container(
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(15),
                      image: DecorationImage(
                          image: Image.file(imageFile[index]).image,
                          fit: BoxFit.cover),
                    ),
                  ),
                  Positioned(
                    right: -10,
                    top: -10,
                    child: CircleAvatar(
                      radius: 15,
                      backgroundColor: customOrange.withOpacity(0.5),
                      child: Icon(
                        Icons.close,
                        color: customPurple,
                      ),
                    ),
                  ),
                ],
              ),
            );
          },
        ),
      ],
    );
  }
}

class GridWidget extends StatefulWidget {
  const GridWidget({Key? key}) : super(key: key);

  @override
  State<GridWidget> createState() => _GridWidgetState();
}

class _GridWidgetState extends State<GridWidget> {
  imageFromGallery() async {
    FilePickerResult? result = await FilePicker.platform.pickFiles(
      type: FileType.image,
      allowCompression: true,
      allowMultiple: true,
    );
    if (result != null) {
      var newFile = [];
      for (var i = 0; i < result.files.length; i++) {
        print("File size: ${result.files[i].size}");
        if (result.files[i].size > 627000) {
          File compressedFile = await FlutterNativeImage.compressImage(
            result.files[i].path!,
            quality: quality,
            percentage: percentage,
          );
          print("New File Size: ${compressedFile.lengthSync()}");
          newFile.add(compressedFile);
        } else {
          newFile.add(File(result.files[i].path!));
        }
      }
      setState(
        () {
          for (var file in newFile) {
            imageFile.add(File(file.path!));
          }
        },
      );
    }
  }

// The hidden widget depending on if the file image has anything in it or not.
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
                "Fixture Image",
                style: Theme.of(context).textTheme.headline3,
              ),
              IconButton(
                  onPressed: () {
                    if (imageFile.length > 9) {
                      Get.snackbar(
                          'Limit Reached', '9 image is the limit for each ');
                    } else {
                      imageFromGallery();
                    }
                  },
                  icon: Icon(Icons.add))
            ],
          ),
        ),
        Obx(
          () => Visibility(
            visible: hidden().value,
            child: Padding(
              padding: EdgeInsets.symmetric(vertical: 10),
              child: GridView.builder(
                physics: const NeverScrollableScrollPhysics(),
                shrinkWrap: true,
                itemCount: imageFile.length,
                gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 3,
                    crossAxisSpacing: 10,
                    mainAxisSpacing: 10),
                itemBuilder: (context, index) {
                  return InkWell(
                    onTap: () {
                      Get.dialog(
                        ClipRect(
                          child: BackdropFilter(
                            filter: ImageFilter.blur(sigmaX: 5, sigmaY: 5),
                            child: Scaffold(
                              backgroundColor: Colors.white.withOpacity(.5),
                              body: InkWell(
                                onTap: () => Get.back(),
                                child: Container(
                                  decoration: BoxDecoration(
                                    image: DecorationImage(
                                      image: Image.file(imageFile[index]).image,
                                      fit: BoxFit.contain,
                                    ),
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
                              setState(
                                () {
                                  imageFile.removeAt(index);
                                },
                              );
                            },
                            child: CircleAvatar(
                              radius: 15,
                              backgroundColor: Colors.white,
                              child: Icon(
                                Icons.close,
                                color: Colors.red,
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
          ),
        ),
        Obx(
          () => Padding(
            padding: const EdgeInsets.symmetric(vertical: 30),
            child: GridView.builder(
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              itemCount: fixtureController
                  .fixtureInfo.value[Get.arguments['card_index']].images.length,
              gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 3,
                crossAxisSpacing: 10,
                mainAxisSpacing: 10,
              ),
              itemBuilder: (context, index) {
                return InkWell(
                  onTap: () {
                    Get.dialog(
                      ClipRect(
                        child: BackdropFilter(
                          filter: ImageFilter.blur(sigmaX: 5, sigmaY: 5),
                          child: Scaffold(
                            backgroundColor: Colors.white.withOpacity(.5),
                            body: InkWell(
                              onTap: () => Get.back(),
                              child: Container(
                                decoration: BoxDecoration(
                                  image: DecorationImage(
                                    image: NetworkImage(fixtureController
                                        .fixtureInfo
                                        .value[Get.arguments['card_index']]
                                        .images[index]
                                        .imgUrl!),
                                    fit: BoxFit.contain,
                                  ),
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
                                image: NetworkImage(fixtureController
                                    .fixtureInfo
                                    .value[Get.arguments['card_index']]
                                    .images[index]
                                    .imgUrl!),
                                fit: BoxFit.cover)),
                      ),
                      Positioned(
                        right: -2,
                        top: -2,
                        child: InkWell(
                          onTap: () {
                            var id = fixtureController
                                .fixtureInfo
                                .value[Get.arguments["card_index"]]
                                .images[index]
                                .id;
                            fixtureController.deleteFixtureImage(id!).then((_) {
                              fixtureController.fixtureInfo
                                  .value[Get.arguments['card_index']].images
                                  .removeAt(index)
                                  .obs;
                              fixtureController.fixtureInfo.refresh();
                            });
                          },
                          child: CircleAvatar(
                            radius: 15,
                            backgroundColor: Colors.white,
                            child: Icon(
                              Icons.close_outlined,
                              color: customOrange,
                            ),
                          ),
                        ),
                      )
                    ],
                  ),
                );
              },
            ),
          ),
        ),
      ],
    );
  }
}
