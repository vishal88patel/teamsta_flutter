import 'dart:io';
import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:teamsta/constants/export_constants.dart';
import 'package:teamsta/widgets/custom_form_field.dart';
import 'package:unicons/unicons.dart';

class SettingsPage extends StatefulWidget {
  const SettingsPage({Key? key}) : super(key: key);

  static TextEditingController reController = TextEditingController();

  @override
  State<SettingsPage> createState() => _SettingsPageState();
}

class _SettingsPageState extends State<SettingsPage> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  ImagePicker _imagePicker = ImagePicker();

  // check if the user is replacing an image or not
  bool isImage = false;

  double sideBySide() {
    double result = mobileWidth / 2 - 25;
    return result;
  }

  // email Validation
  emailValidation(String value) {
    if (value.isEmpty || !GetUtils.isEmail(value)) {
      return "Please enter a valid Email Address";
    }
  }

  // password validation
  passwordValidation(String value) {
    if (value.isEmpty) {
      return null;
    }
    if (value.length < 6) {
      return "Password length needs to exceed 6 characters";
    }
    if (!value.contains(RegExp(r'[A-Z]'))) {
      return "Password must contain at least one capital letter";
    }
    if (!value.contains(RegExp(r'[0-9]'))) {
      return "Password must contain at least one number";
    }
    if (!value.contains(RegExp(r'[!@#$%^&*()£,.?":{}|<>]'))) {
      return "Password must contain at least one special character";
    }
  }

  @override
  void initState() {
    super.initState();
    controller.nameController.text = Get.arguments['name'];
    controller.surnameController.text = Get.arguments['surname'];
    controller.emailController.text = Get.arguments['email'];
    if (Get.arguments['isTeam'] == true) {
      Get.arguments['image'] = Get.arguments["user_image"];
    }
  }

  // get the images from gallery
  imageFromGallery() async {
    var pickedImage = await _imagePicker.pickImage(
        source: ImageSource.gallery, maxWidth: 300);
    if (pickedImage != null) {
      setState(() {
        singleImage = File(pickedImage.path);
      });
    }
  }

  // get the image from Camera
  imageFromCamera() async {
    var pickedFile = await _imagePicker.pickImage(
      source: ImageSource.camera,
      maxHeight: 200,
    );
    if (pickedFile != null) {
      setState(() {
        singleImage = File(pickedFile.path);
      });
    }
  }

  clearControllers() {
    controller.nameController.clear();
    controller.surnameController.clear();
    controller.emailController.clear();
    controller.passwordController.clear();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Account"),
      ),
      body: Padding(
        padding: EdgeInsets.symmetric(horizontal: 20),
        child: Form(
          key: _formKey,
          autovalidateMode: AutovalidateMode.always,
          child: Column(
            children: [
              const SizedBox(height: 50),

              // if not, use the default image
              Get.arguments["image"] != ""
                  ? InkWell(
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
                                              isImage = true;
                                              Get.back();
                                            },
                                            child: Text("Upload from Gallery")),
                                        Padding(
                                          padding: EdgeInsets.symmetric(
                                              vertical: 15),
                                          child: ElevatedButton(
                                              onPressed: () {
                                                imageFromCamera();
                                                isImage = true;
                                                Get.back();
                                              },
                                              child:
                                                  Text("Upload from Camera")),
                                        ),
                                        ElevatedButton(
                                            onPressed: () {
                                              isImage = false;
                                              Get.back();
                                            },
                                            child: Text("Cancel")),
                                      ]),
                                ),
                              ),
                            ),
                          ),
                        );
                      },
                      child: Stack(
                        children: [
                          CircleAvatar(
                              radius: 80,
                              backgroundColor: customPurple,
                              backgroundImage: singleImage != null
                                  ? FileImage(singleImage!)
                                  : Get.arguments["image"] != null
                                      ? Image.network(Get.arguments['image'])
                                          .image
                                      : NetworkImage(
                                          "https://cdn.pixabay.com/photo/2015/10/05/22/37/blank-profile-picture-973460_1280.png")),
                          Positioned(
                            right: 10,
                            bottom: 10,
                            child: CircleAvatar(
                              radius: 25,
                              backgroundColor: Colors.white,
                              child: CircleAvatar(
                                radius: 21,
                                backgroundColor: customOrange,
                                child: Icon(
                                  UniconsLine.camera,
                                  color: Colors.white,
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                    )
                  : InkWell(
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
                                                isImage = false;
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
                      child: CircleAvatar(
                        radius: 70,
                        backgroundColor: customPurple,
                        backgroundImage: singleImage != null
                            ? Image.file(singleImage!).image
                            : null,
                        child: singleImage == null
                            ? Icon(
                                Icons.image_search_rounded,
                                size: 70,
                                color: Colors.white,
                              )
                            : null,
                      ),
                    ),
              Padding(
                padding: EdgeInsets.only(top: 30),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Container(
                      height: 50,
                      width: sideBySide(),
                      child: CustomFormField(
                        fillColour: customLightGrey,
                        controller: controller.nameController,
                        hintText: "First Name",
                        caps: TextCapitalization.sentences,
                        cInputAction: TextInputAction.next,
                        cKeyBoardType: TextInputType.text,
                      ),
                    ),
                    Container(
                      height: 50,
                      width: sideBySide(),
                      child: CustomFormField(
                        fillColour: customLightGrey,
                        controller: controller.surnameController,
                        hintText: "Last Name",
                        caps: TextCapitalization.sentences,
                        cInputAction: TextInputAction.next,
                        cKeyBoardType: TextInputType.text,
                      ),
                    ),
                  ],
                ),
              ),
              CustomFormField(
                  fillColour: customLightGrey,
                  controller: controller.emailController,
                  cKeyBoardType: TextInputType.emailAddress,
                  cInputAction: TextInputAction.next,
                  hintText: "Email Address",
                  caps: TextCapitalization.none,
                  validate: (value) {
                    return emailValidation(value!);
                  }),
              CustomFormField(
                  fillColour: customLightGrey,
                  controller: controller.passwordController,
                  cKeyBoardType: TextInputType.text,
                  cInputAction: TextInputAction.next,
                  hintText: "Choose Password",
                  isObscured: true,
                  caps: TextCapitalization.none,
                  validate: (value) {
                    return passwordValidation(value!);
                  }),

              CustomFormField(
                fillColour: customLightGrey,
                controller: SettingsPage.reController,
                cKeyBoardType: TextInputType.text,
                cInputAction: TextInputAction.next,
                caps: TextCapitalization.none,
                hintText: "Repeat Password",
                isObscured: true,
                validate: (value) {
                  if (value != controller.passwordController.text) {
                    return "Passwords do not match";
                  }
                  return null;
                },
              ),
              Spacer(),
              Padding(
                padding: EdgeInsets.only(top: 10, bottom: 20),
                child: ElevatedButton(
                    onPressed: () {
                      if (controller.nameController.text !=
                          Get.arguments["name"]) {
                        userGetController.updateUser();
                      }
                      if (controller.surnameController.text !=
                          Get.arguments["surname"]) {
                        userGetController.updateUser();
                      }
                      if (controller.emailController.text !=
                          Get.arguments["email"]) {
                        userGetController.updateUser();
                      }
                      if (controller.passwordController.text != "") {
                        userGetController.updateUser();
                      } else
                        null;
                      if (singleImage != null) {
                        if (isImage == true) {
                          if (Get.arguments['isTeam'] == true) {
                            userGetController
                                .deleteTeamImage(Get.arguments['image_id']);
                            ;
                            userGetController
                                .createTeamImage(Get.arguments['id'])
                                .then((_) {
                              Get.back();
                            });
                          } else if (Get.arguments['image'] == null) {
                            print(Get.arguments["id"]);
                            userGetController
                                .createUserImage(Get.arguments['id'])
                                .then((_) {
                              Get.back();
                            });
                          } else {
                            userGetController
                                .deleteUserImage(Get.arguments["image_id"])
                                .then((_) {
                              userGetController
                                  .createUserImage(Get.arguments["id"])
                                  .then((_) {
                                Get.back();
                              });
                            });
                          }
                        } else if (isImage == false) {
                          if (Get.arguments['isTeam'] == true) {
                            userGetController
                                .createTeamImage(Get.arguments['id'])
                                .then((_) {
                              Get.back();
                            });
                          } else {
                            userGetController
                                .createUserImage(Get.arguments["id"])
                                .then(
                              (_) {
                                Get.back();
                              },
                            );
                          }
                        }
                       }
                      clearControllers();
                      SettingsPage.reController.clear();
                    },
                    child: Text("Update")),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
