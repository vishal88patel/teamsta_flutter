import 'dart:io';
import 'dart:ui';

import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:flutter_native_image/flutter_native_image.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:teamsta/constants/export_constants.dart';
import 'package:teamsta/global/lists/category_list.dart';
import 'package:teamsta/widgets/widgets.dart';

class EditProfile extends StatefulWidget {
  const EditProfile({Key? key}) : super(key: key);

  @override
  State<EditProfile> createState() => _EditProfileState();
}

class _EditProfileState extends State<EditProfile> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  ImagePicker _imagePicker = ImagePicker();

  String? dropDownValue;

  imageFromGallery() async {
    FilePickerResult? result =
        await FilePicker.platform.pickFiles(type: FileType.image);
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
          controller.imageFile = File(file.path!);
        }
        ;
      });
    }
  }

  // get the image from Camera
  imageFromCamera() async {
    var pickedFile = await _imagePicker.pickImage(
      source: ImageSource.camera,
      maxWidth: 100,
    );
    if (pickedFile != null) {
      setState(() {
        controller.imageFile = File(pickedFile.path);
      });
    }
  }

  @override
  void initState() {
    super.initState();
    controller.companyNameController.text =
        userGetController.teamInfo.value[0].team.clubName;
    controller.companyDescriptionController.text =
        userGetController.teamInfo.value[0].team.description;
    dropDownValue = userGetController.teamInfo.value[0].team.category;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text(
            'Profile',
          ),
        ),
        body: Center(
          child: Padding(
            padding: EdgeInsets.symmetric(horizontal: 20),
            child: SingleChildScrollView(
              child: Form(
                key: _formKey,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
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
                                            child: Text("Upload from Gallery")),
                                        Padding(
                                          padding: EdgeInsets.symmetric(
                                              vertical: 15),
                                          child: ElevatedButton(
                                              onPressed: () {
                                                imageFromCamera();
                                                Get.back();
                                              },
                                              child:
                                                  Text("Upload from Camera")),
                                        ),
                                        ElevatedButton(
                                            onPressed: () => Get.back(),
                                            child: Text("Cancel")),
                                      ]),
                                ),
                              ),
                            ),
                          ),
                        );
                      },
                      child: controller.imageFile != null
                          ? CircleAvatar(
                              backgroundColor: Colors.white,
                              radius: 65,
                              backgroundImage:
                                  Image.file(controller.imageFile!).image,
                            )
                          : CircleAvatar(
                              radius: 65,
                              backgroundColor: customOrange,
                              backgroundImage: NetworkImage(
                                  userGetController.teamInfo.value[0].image),
                            ),
                    ),
                    Padding(
                      padding: EdgeInsets.symmetric(vertical: 15),
                      child: Text("Upload your Team/Organisation logo",
                          style: Theme.of(context).textTheme.headline3),
                    ),
                    Padding(
                      padding: EdgeInsets.only(top: 20),
                      child: Text(
                        "Team/Organisation Name",
                        style: Theme.of(context)
                            .textTheme
                            .headline3!
                            .copyWith(fontWeight: FontWeight.bold),
                      ),
                    ),
                    CustomFormField(
                      controller: controller.companyNameController,
                      cKeyBoardType: TextInputType.text,
                      cInputAction: TextInputAction.next,
                      hintText: "",
                      caps: TextCapitalization.sentences,
                      fillColour: customLightGrey,
                    ),
                    Padding(
                      padding: EdgeInsets.only(top: 5, bottom: 5),
                      child: Text(
                        "Team/Organisation Description",
                        style: Theme.of(context)
                            .textTheme
                            .headline3!
                            .copyWith(fontWeight: FontWeight.bold),
                      ),
                    ),
                    CustomFormField(
                      controller: controller.companyDescriptionController,
                      cKeyBoardType: TextInputType.text,
                      cInputAction: TextInputAction.next,
                      hintText: "",
                      caps: TextCapitalization.sentences,
                      fillColour: customLightGrey,
                    ),
                    Padding(
                      padding: EdgeInsets.symmetric(vertical: 5),
                      child: Text(
                        "What sport is your Team/Organisation in?",
                        style: Theme.of(context)
                            .textTheme
                            .headline3!
                            .copyWith(fontWeight: FontWeight.bold),
                      ),
                    ),
                    Container(
                      padding: EdgeInsets.only(),
                      decoration: BoxDecoration(
                          color: customLightGrey,
                          borderRadius: BorderRadius.circular(10)),
                      alignment: Alignment.center,
                      height: 45,
                      width: double.infinity,
                      child: DropdownButton(
                          elevation: 0,
                          iconSize: 0,
                          alignment: Alignment.center,
                          isExpanded: true,
                          underline: Container(),
                          style: Theme.of(context).textTheme.headline3,
                          value: dropDownValue,
                          borderRadius: BorderRadius.circular(10),
                          items: categories
                              .map<DropdownMenuItem<String>>((String value) {
                            return DropdownMenuItem<String>(
                              value: value,
                              child: Text(
                                value,
                                textAlign: TextAlign.center,
                              ),
                              alignment: Alignment.center,
                            );
                          }).toList(),
                          hint: Center(
                            child: Text(
                              dropDownValue!,
                              style: Theme.of(context).textTheme.headline3,
                            ),
                          ),
                          onChanged: (String? newValue) {
                            setState(() {
                              dropDownValue = newValue;
                              controller.companySportController.text =
                                  newValue!;
                            });
                          }),
                    ),
                    SizedBox(height: 80),
                    ElevatedButton(
                      onPressed: () {
                        if (controller.companyNameController.text.isEmpty) {
                          Get.snackbar(
                            '',
                            '',
                            titleText: Text(
                              "Incomplete Form",
                              textAlign: TextAlign.center,
                              style: Theme.of(context).textTheme.headline2,
                            ),
                            messageText: Text(
                              "Team/Organisation name is required",
                              textAlign: TextAlign.center,
                              style: Theme.of(context).textTheme.headline3,
                            ),
                          );
                        } else if (controller
                            .companyDescriptionController.text.isEmpty) {
                          Get.snackbar(
                            '',
                            '',
                            titleText: Text(
                              "Incomplete Form",
                              textAlign: TextAlign.center,
                              style: Theme.of(context).textTheme.headline2,
                            ),
                            messageText: Text(
                              "Team/Organisation description is required",
                              textAlign: TextAlign.center,
                              style: Theme.of(context).textTheme.headline3,
                            ),
                          );
                        } else if (dropDownValue == null) {
                          Get.snackbar(
                            '',
                            '',
                            titleText: Text(
                              "Incomplete Form",
                              textAlign: TextAlign.center,
                              style: Theme.of(context).textTheme.headline2,
                            ),
                            messageText: Text(
                              "Team/Organisation sport is required",
                              textAlign: TextAlign.center,
                              style: Theme.of(context).textTheme.headline3,
                            ),
                          );
                        } else {
                         
                          controller.teamUpdate(Get.arguments["id"]);
                        }
                      },
                      child: Text(
                        "Update",
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ));
  }
}
