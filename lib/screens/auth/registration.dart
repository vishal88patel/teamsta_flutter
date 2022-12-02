import 'dart:io';
import 'dart:ui';

import 'package:file_picker/file_picker.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_native_image/flutter_native_image.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:teamsta/constants/export_constants.dart';
import 'package:teamsta/constants/string_constants.dart';
import 'package:teamsta/widgets/widgets.dart';

class RegistrationPage extends StatefulWidget {
  const RegistrationPage({Key? key}) : super(key: key);

  @override
  State<RegistrationPage> createState() => _RegistrationPageState();
}

class _RegistrationPageState extends State<RegistrationPage> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  TextEditingController rePassword = TextEditingController();
  ImagePicker _imagePicker = ImagePicker();

  // user
  RxBool user = false.obs;

  // organisation
  RxBool organisation = false.obs;

  //t's and c's
  RxBool terms = false.obs;

  // privacy policy
  RxBool privacy = false.obs;

  // gets the width of the mobile to fit the containers for the side by side
  // name and surname form fields.
  double phoneWidth() {
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
      return "Password is required";
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

  // get the images from gallery
  imageFromGallery() async {
    FilePickerResult? result = await FilePicker.platform.pickFiles(
      type: FileType.image,
      allowCompression: true,
      withReadStream: true,
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
          print(compressedFile.lengthSync());
          newFile.add(compressedFile);
        } else {
          newFile.add(File(result.files[i].path!));
        }
      }
      setState(() {
        for (var file in newFile) {
          singleImage = File(file.path!);
        }
        ;
      });
    }
  }

  // get the image from Camera
  imageFromCamera() async {
    var pickedFile = await _imagePicker.pickImage(
      source: ImageSource.camera,
      maxWidth: 300,
      imageQuality: 95,
    );
    if (pickedFile != null) {
      setState(() {
        singleImage = File(pickedFile.path);
      });
    }
  }

  @override
  void initState() {
    Future.delayed(Duration(milliseconds: 50), () {
      controller.emailController.clear();
      controller.passwordController.clear();
      user.value = true;
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: customOrange,
      appBar: AppBar(
        title: Text("Register"),
        leading: InkWell(
            onTap: () {
              Get.back();
            },
            child: Icon(
              CupertinoIcons.chevron_back,
              color: primaryWhite,
              size: 30,
            )),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 20),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Center(
                child: Padding(
                  padding: EdgeInsets.only(top: 20),
                  child: singleImage != null
                      ? InkWell(
                          onTap: () {
                            Get.dialog(
                              barrierColor: Colors.transparent,
                              ClipRRect(
                                child: BackdropFilter(
                                  filter:
                                      ImageFilter.blur(sigmaX: 3, sigmaY: 3),
                                  child: Scaffold(
                                    backgroundColor:
                                        Colors.white.withOpacity(.3),
                                    body: Padding(
                                      padding: EdgeInsets.all(20),
                                      child: Column(
                                          mainAxisAlignment:
                                              MainAxisAlignment.end,
                                          children: [
                                            ElevatedButton(
                                                onPressed: () {
                                                  imageFromGallery();
                                                  Get.back();
                                                },
                                                child: Text(
                                                    "Upload from Gallery")),
                                            Padding(
                                              padding: EdgeInsets.symmetric(
                                                  vertical: 15),
                                              child: ElevatedButton(
                                                  onPressed: () {
                                                    imageFromCamera();
                                                    Get.back();
                                                  },
                                                  child: Text(
                                                      "Upload from Camera")),
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
                            radius: 60,
                            backgroundImage: FileImage(singleImage!),
                          ),
                        )
                      : InkWell(
                          onTap: () {
                            Get.dialog(
                              barrierColor: Colors.transparent,
                              ClipRRect(
                                child: BackdropFilter(
                                  filter:
                                      ImageFilter.blur(sigmaX: 3, sigmaY: 3),
                                  child: Scaffold(
                                    backgroundColor:
                                        Colors.white.withOpacity(.3),
                                    body: Padding(
                                      padding: EdgeInsets.all(20),
                                      child: Column(
                                          mainAxisAlignment:
                                              MainAxisAlignment.end,
                                          children: [
                                            ElevatedButton(
                                              onPressed: () {
                                                imageFromGallery();
                                                Get.back();
                                              },
                                              child: Text(
                                                "Upload from Gallery",
                                                style: TextStyle(
                                                    color: Colors.black),
                                              ),
                                              style: ElevatedButton.styleFrom(
                                                primary: Colors.white,
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
                                                child: Text(
                                                  "Take a Photo",
                                                  style: TextStyle(
                                                      color: Colors.black),
                                                ),
                                                style: ElevatedButton.styleFrom(
                                                  primary: Colors.white,
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
                          child: CircleAvatar(
                            backgroundColor: customPurple,
                            radius: 60,
                            child: Icon(Icons.person, size: 70),
                          ),
                        ),
                ),
              ),
              SizedBox(height: 40),
              Form(
                  key: _formKey,
                  autovalidateMode: AutovalidateMode.always,
                  child: Column(
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Column(
                            children: [
                              Container(
                                height: 50,
                                width: phoneWidth(),
                                child: CustomFormField(
                                  controller: controller.nameController,
                                  hintText: "First Name",
                                  caps: TextCapitalization.sentences,
                                  cInputAction: TextInputAction.next,
                                  cKeyBoardType: TextInputType.text,
                                ),
                              ),
                            ],
                          ),
                          Container(
                            height: 50,
                            width: phoneWidth(),
                            child: CustomFormField(
                              controller: controller.surnameController,
                              cInputAction: TextInputAction.next,
                              cKeyBoardType: TextInputType.text,
                              caps: TextCapitalization.sentences,
                              hintText: "Last Name",
                            ),
                          ),
                        ],
                      ),
                      CustomFormField(
                        controller: controller.emailController,
                        cKeyBoardType: TextInputType.emailAddress,
                        cInputAction: TextInputAction.next,
                        hintText: "Email Address",
                        caps: TextCapitalization.none,
                        // validate: (value) {
                        //   return emailValidation(value!);
                        // },
                      ),
                      CustomFormField(
                        controller: controller.passwordController,
                        cKeyBoardType: TextInputType.text,
                        cInputAction: TextInputAction.next,
                        isObscured: true,
                        hintText: "Password",
                        caps: TextCapitalization.none,
                        // validate: (value) {
                        //   return passwordValidation(value!);
                        // },
                      ),
                      CustomFormField(
                        controller: rePassword,
                        cKeyBoardType: TextInputType.text,
                        cInputAction: TextInputAction.done,
                        isObscured: true,
                        hintText: "Repeat Password",
                        caps: TextCapitalization.none,
                        // validate: (value) {
                        //   if (value != controller.passwordController.text) {
                        //     return "Passwords do not match";
                        //   }
                        //   return null;
                        // },
                      ),
                      SizedBox(height: 20),
                      CustomCheckBox(
                          value: user,
                          function: (value) {
                            user.toggle();
                            user.value = value!;
                            if (user.value == true) {
                              organisation.value = false;
                            }
                          },
                          isExtra: true,
                          heading: "Register as a User",
                          subHeading:
                              "If you're a player or a players guardian"),
                      SizedBox(height: 16),
                      CustomCheckBox(
                          value: organisation,
                          function: (value) {
                            organisation.toggle();
                            organisation.value = value!;
                            if (organisation.value == true) {
                              user.value = false;
                            }
                          },
                          isExtra: true,
                          heading: "Register as a Team/Organisation",
                          subHeading: Get.width < 390
                              ? "Team/Organisation: teams, clubs, \ntournaments, referees, physios, \nbusiness, etc"
                              : '''Team/Organisation: teams, clubs,\ntournaments, referees, physios, business, et
          '''),
                      Get.width < 390
                          ? SizedBox(height: 10)
                          : SizedBox(height: 0),
                      Row(
                        children: [
                          Text(
                            "By creating an account I agree to the",
                            style:
                                Theme.of(context).textTheme.headline3!.copyWith(
                                      color: Colors.white,
                                    ),
                          ),
                        ],
                      ),
                      CustomCheckBox(
                          value: terms,
                          function: (value) {
                            terms.toggle();
                            terms.value = value!;
                            var data = {
                              "isMore": false,
                            };
                            // Get.toNamed("/terms", arguments: data);
                          },
                          isExtra: false,
                          heading: "Terms & Conditions",
                          subHeading: "none"),
                      CustomCheckBox(
                          value: privacy,
                          function: (value) {
                            privacy.toggle();
                            privacy.value = value!;
                            var data = {
                              "isMore": false,
                            };
                            // Get.toNamed("/privacy", arguments: data);
                          },
                          isExtra: false,
                          heading: "Privacy Policy",
                          subHeading: "none"),
                      SizedBox(height: 10),
                      ElevatedButton(
                        onPressed: () {
                          if (singleImage == null) {
                            Get.snackbar(StringConstants.ERROR,
                                "Please Select Profile Photo",
                                colorText: Colors.white);
                          } else if (controller.nameController.text
                              .trim()
                              .isEmpty) {
                            Get.snackbar(StringConstants.ERROR,
                                "Please Enter First Name",
                                colorText: Colors.white);
                          } else if (controller.surnameController.text
                              .trim()
                              .isEmpty) {
                            Get.snackbar(
                                StringConstants.ERROR, "Please Enter Last Name",
                                colorText: Colors.white);
                          } else if (controller.emailController.text
                              .trim()
                              .isEmpty) {
                            Get.snackbar(
                                StringConstants.ERROR, "Please Enter Email",
                                colorText: Colors.white);
                          } else if (!GetUtils.isEmail(
                              controller.emailController.text)) {
                            Get.snackbar(StringConstants.ERROR,
                                "Please Enter Valid Email",
                                colorText: Colors.white);
                          } else if (controller.passwordController.text
                              .trim()
                              .isEmpty) {
                            Get.snackbar(
                                StringConstants.ERROR, "Please Enter Password",
                                colorText: Colors.white);
                          } else if (controller.passwordController.text
                              .trim().length<6
                          ) {
                            Get.snackbar(
                                StringConstants.ERROR, "Password Must be At least 6 characters",
                                colorText: Colors.white);
                          } else if (rePassword.text.trim().isEmpty) {
                            Get.snackbar(StringConstants.ERROR,
                                "Please Enter Repeat Password",
                                colorText: Colors.white);
                          } else if (rePassword.text.trim() !=
                              controller.passwordController.text.trim()) {
                            Get.snackbar(StringConstants.ERROR,
                                "Password did not Matched",
                                colorText: Colors.white);
                          } else if (terms.value == false) {
                            // Get.snackbar('', '',
                            //     titleText: Text(
                            //       "Required Fields",
                            //       style: Theme.of(context)
                            //           .textTheme
                            //           .headline2!
                            //           .copyWith(
                            //             color: Colors.white,
                            //             fontWeight: FontWeight.bold,
                            //           ),
                            //     ),
                            //     messageText: Text(
                            //       "Please check terms and condition",
                            //     ));
                            Get.snackbar(
                                StringConstants.ERROR, "Please check terms and condition",
                                colorText: Colors.white);
                          } else if (privacy.value == false) {
                            // Get.snackbar(
                            //   '',
                            //   '',
                            //   titleText: Text(
                            //     "Required Fields",
                            //     style: Theme.of(context)
                            //         .textTheme
                            //         .headline2!
                            //         .copyWith(
                            //           color: Colors.white,
                            //           fontWeight: FontWeight.bold,
                            //         ),
                            //   ),
                            //   messageText: Text(
                            //     "Please check privacy policy",
                            //     style: Theme.of(context)
                            //         .textTheme
                            //         .headline3!
                            //         .copyWith(color: Colors.white),
                            //   ),
                            // );
                            Get.snackbar(
                                StringConstants.ERROR, "Please check privacy policy",
                                colorText: Colors.white);
                          } else if (_formKey.currentState!.validate()) {
                            if (user.value == true) {
                              boxTeamMember.write("isTeam", false);
                              controller.registerUser();
                            } else if (organisation.value == true) {
                              boxTeamMember.write("isTeam", true);
                              var data = {
                                "name": controller.nameController.text,
                                "surname": controller.surnameController.text,
                                "email": controller.emailController.text.trim(),
                                "password": controller.passwordController.text,
                              };
                              Get.offAllNamed("/setup", parameters: data);
                            }
                          } else if (controller.nameController.text.isEmpty) {
                            Get.snackbar(
                              '',
                              '',
                              titleText: Text(
                                "Required Fields",
                                textAlign: TextAlign.center,
                                style: Theme.of(context)
                                    .textTheme
                                    .headline2!
                                    .copyWith(color: Colors.white),
                              ),
                              messageText: Text(
                                "First Name is required",
                                textAlign: TextAlign.center,
                                style: Theme.of(context)
                                    .textTheme
                                    .headline3!
                                    .copyWith(color: Colors.white),
                              ),
                            );
                          } else if (controller
                              .surnameController.text.isEmpty) {
                            Get.snackbar("", "",
                                titleText: Text(
                                  "Required Fields",
                                  textAlign: TextAlign.center,
                                  style: Theme.of(context)
                                      .textTheme
                                      .headline2!
                                      .copyWith(color: Colors.white),
                                ),
                                messageText: Text(
                                  "Last Name is required",
                                  textAlign: TextAlign.center,
                                  style: Theme.of(context)
                                      .textTheme
                                      .headline3!
                                      .copyWith(color: Colors.white),
                                ));
                          } else {
                            Get.snackbar('', '',
                                titleText: Text(
                                  "Required Fields",
                                  textAlign: TextAlign.center,
                                  style: Theme.of(context)
                                      .textTheme
                                      .headline2!
                                      .copyWith(color: Colors.white),
                                ),
                                messageText: Text(
                                  "Please complete the form",
                                  textAlign: TextAlign.center,
                                  style: Theme.of(context)
                                      .textTheme
                                      .headline3!
                                      .copyWith(color: Colors.white),
                                ));
                          }
                        },
                        child: Text(
                          "Register",
                        ),
                      ),
                    ],
                  )),
              SizedBox(height: 50),
            ],
          ),
        ),
      ),
    );
  }
}
