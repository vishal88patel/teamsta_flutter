import 'dart:io';
import 'dart:ui';

import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:flutter_native_image/flutter_native_image.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:teamsta/constants/export_constants.dart';
import 'package:teamsta/global/lists/category_list.dart';
import 'package:teamsta/screens/organisation/widgets/fixturesLargeTextBox.dart';
import 'package:teamsta/widgets/widgets.dart';

import '../../../constants/string_constants.dart';

class SetupPage extends StatefulWidget {
  const SetupPage({Key? key}) : super(key: key);

  @override
  State<SetupPage> createState() => _SetupPageState();
}

class _SetupPageState extends State<SetupPage> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  ImagePicker _imagePicker = ImagePicker();

  String? dropDownValue;

  @override
  void initState() {
    super.initState();
    controller.nameController =
        TextEditingController(text: Get.parameters['name']);
    controller.emailController =
        TextEditingController(text: Get.parameters['email']);
    controller.passwordController =
        TextEditingController(text: Get.parameters['password']);
    controller.surnameController =
        TextEditingController(text: Get.parameters['surname']);
  }

// get the images from gallery
  imageFromGallery() async {
    FilePickerResult? result = await FilePicker.platform
        .pickFiles(type: FileType.image, allowCompression: true);
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
        for (var file in newFile) {
          controller.imageFile = File(file.path!);
        }
        ;
      });
    }
  }

  // get the image from Camera
  imageFromCamera() async {
    var pickedFile = await _imagePicker.pickImage(
        source: ImageSource.camera, maxWidth: 300, imageQuality: 90);
    if (pickedFile != null) {
      setState(() {
        controller.imageFile = File(pickedFile.path);
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text(
            'Setup',
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
                    SizedBox(height: 45),
                    Text(
                      "Create your Team/Organisation Profile",
                      style: Theme.of(context)
                          .textTheme
                          .headline2!
                          .copyWith(fontWeight: FontWeight.w900),
                    ),
                    Padding(
                      padding: EdgeInsets.symmetric(vertical: 15),
                      child: Text(
                        "Upload your Team/Organisation logo",
                        style: Theme.of(context)
                            .textTheme
                            .headline3!
                            .copyWith(fontWeight: FontWeight.w600),
                      ),
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
                                            style:
                                                TextStyle(color: Colors.black),
                                          ),
                                        ),
                                        Padding(
                                          padding: EdgeInsets.symmetric(
                                              vertical: 15),
                                          child: ElevatedButton(
                                            onPressed: () {
                                              imageFromCamera();
                                              Get.back();
                                            },
                                            style: ElevatedButton.styleFrom(
                                              primary: Colors.white,
                                            ),
                                            child: Text(
                                              "Upload from Camera",
                                              style: TextStyle(
                                                  color: Colors.black),
                                            ),
                                          ),
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
                              child: Icon(Icons.image_outlined,
                                  color: Colors.white, size: 50),
                            ),
                    ),
                    Padding(
                      padding: EdgeInsets.only(top: 20),
                      child: Text(
                        "Team/Organisation Name",
                        style: Theme.of(context)
                            .textTheme
                            .headline3!
                            .copyWith(fontWeight: FontWeight.w600),
                      ),
                    ),
                    CustomFormField(
                      controller: controller.companyNameController,
                      cKeyBoardType: TextInputType.text,
                      cInputAction: TextInputAction.next,
                      hintText: "",
                      fillColour: formFieldLightGrey,
                      caps: TextCapitalization.sentences,
                    ),
                    LargeTextBox(
                        hintStyle: Theme.of(context)
                            .textTheme
                            .headline3!
                            .copyWith(fontWeight: FontWeight.w600),
                        isCenter: CrossAxisAlignment.center,
                        controller: controller.companyDescriptionController,
                        hintText: "Team/Organisation Description"),

                    // CustomFormField(
                    //   controller: controller.companyDescriptionController,
                    //   cKeyBoardType: TextInputType.text,
                    //   cInputAction: TextInputAction.next,
                    //   hintText: "",
                    //   fillColour: customLightGrey,
                    //   caps: TextCapitalization.sentences,
                    // ),
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
                        if (controller.imageFile == null) {
                          // Get.snackbar('Form Error', 'Club image is required');
                          Get.snackbar(
                              StringConstants.ERROR, "Club image is required",
                              colorText: Colors.white);
                        } else if (controller
                            .companyNameController.text.isEmpty) {
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
                        } else
                          Get.toNamed("/setup2");
                      },
                      child: Text(
                        "Next",
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
