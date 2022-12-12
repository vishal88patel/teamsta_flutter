import 'dart:io';
import 'dart:ui';

import 'package:file_picker/file_picker.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_native_image/flutter_native_image.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:teamsta/constants/export_constants.dart';
import 'package:teamsta/widgets/custom_form_field.dart';

class Members extends StatelessWidget {
  const Members({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    memberController.membersList.value.isEmpty
        ? memberController.getMember()
        : null;
    return Scaffold(
      appBar: AppBar(
        title: Text("Members"),
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
      body: Padding(
        padding: EdgeInsets.symmetric(horizontal: 20, vertical: 20),
        child: Column(
          children: [
            Obx(
              () {
                if (memberController.isLoading.value == true) {
                  return Padding(
                    padding: EdgeInsets.only(top: mobileHight / 2.5),
                    child: Center(
                      child: CircularProgressIndicator(),
                    ),
                  );
                }
                if (memberController.membersList.value.length == 0) {
                  return Padding(
                    padding: EdgeInsets.only(top: mobileHight / 2.5),
                    child: Center(
                      child: Text(
                        "No Members as yet",
                        style: Theme.of(context).textTheme.headline2,
                      ),
                    ),
                  );
                }
                return ListView.builder(
                  shrinkWrap: true,
                  itemCount: memberController.membersList.value.length,
                  itemBuilder: (BuildContext context, int index) {
                    return Dismissible(
                      background: Container(
                        color: Colors.red,
                        child: Center(
                            child: Icon(
                          Icons.delete,
                          color: Colors.white,
                          size: 50,
                        )),
                      ),
                      onDismissed: (_) {
                        if (memberController.membersList.value.length > 0) {
                          memberController.deleteMember(
                              memberController.membersList.value[index].id);
                          memberController.membersList.value.removeAt(index);
                        }
                      },
                      key: UniqueKey(),
                      child: Padding(
                        padding: const EdgeInsets.symmetric(vertical: 10),
                        child: Card(
                          child: ListTile(
                            onTap: () {
                              var data = {
                                "name": memberController
                                    .membersList.value[index].name,
                                "memberBio": memberController
                                    .membersList.value[index].bio,
                                "memberRole": memberController
                                    .membersList.value[index].role,
                                "memberImage": imageBaseWithout +
                                    memberController
                                        .membersList.value[index].imgUrl,
                                "id": memberController
                                    .membersList.value[index].id,
                                "edit": true
                              };
                              Get.dialog(
                                  barrierColor: Colors.transparent,
                                  AddMemberDialog(),
                                  arguments: data);
                            },
                            title: Text(
                              memberController.membersList.value[index].name,
                              style: Theme.of(context).textTheme.headline2,
                            ),
                            subtitle: Text(
                              memberController
                                          .membersList.value[index].bio.length >
                                      30
                                  ? memberController
                                          .membersList.value[index].bio
                                          .substring(0, 30) +
                                      "..."
                                  : memberController
                                      .membersList.value[index].bio,
                              style: Theme.of(context).textTheme.headline3,
                            ),
                            trailing: CircleAvatar(
                              backgroundImage: NetworkImage(imageBaseUrl +
                                  memberController
                                      .membersList.value[index].imgUrl),
                            ),
                          ),
                        ),
                      ),
                    );
                  },
                );
              },
            ),
            Spacer(),
            Padding(
              padding: EdgeInsets.symmetric(vertical: 20),
              child: ElevatedButton(
                child: Text('Add Team Member'),
                onPressed: () {
                  var data = {"edit": false};
                  Get.dialog(
                      barrierColor: Colors.transparent,
                      AddMemberDialog(),
                      arguments: data);
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class AddMemberDialog extends StatefulWidget {
  const AddMemberDialog({Key? key}) : super(key: key);

  @override
  State<AddMemberDialog> createState() => _AddMemberDialogState();
}

class _AddMemberDialogState extends State<AddMemberDialog> {
  TextEditingController _nameController = TextEditingController();
  TextEditingController _bioController = TextEditingController();
  TextEditingController _roleController = TextEditingController();

  ImagePicker _imagePicker = ImagePicker();

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
        for (var file in newFile) {
          controller.imageFile = File(file.path!);
        }
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

  setControllers() {
    if (Get.arguments["edit"] == true) {
      _nameController.text = Get.arguments["name"];
      _bioController.text = Get.arguments["memberBio"];
      _roleController.text = Get.arguments["memberRole"];
    }
  }

  @override
  Widget build(BuildContext context) {
    setControllers();
    return Scaffold(
      appBar: AppBar(
        title: Get.arguments['edit'] ? Text("Edit Member") : Text("Add Member"),
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
      body: Padding(
        padding: EdgeInsets.symmetric(horizontal: 20, vertical: 20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: EdgeInsets.only(top: 20),
              child: Text(
                "Member Name",
                style: Theme.of(context).textTheme.headline3,
              ),
            ),
            CustomFormField(
              controller: _nameController,
              cKeyBoardType: TextInputType.text,
              cInputAction: TextInputAction.next,
              hintText: "",
              caps: TextCapitalization.sentences,
              fillColour: formFieldLightGrey,
            ),
            Padding(
              padding: EdgeInsets.only(top: 20),
              child: Text(
                "Member Bio",
                style: Theme.of(context).textTheme.headline3,
              ),
            ),
            // large text field
            Container(
              height: 120,
              decoration: BoxDecoration(
                  color: customLightGrey,
                  borderRadius: BorderRadius.circular(15)),
              child: TextField(
                controller: _bioController,
                keyboardType: TextInputType.multiline,
                minLines: 1,
                //Normal textInputField will be displayed
                maxLines: 5,
                decoration: InputDecoration(
                    fillColor:
                        formFieldLightGrey), // when user presses enter it will adapt to it
              ),
            ),
            Padding(
              padding: EdgeInsets.only(top: 20),
              child: Text(
                "Member Role",
                style: Theme.of(context).textTheme.headline3,
              ),
            ),
            CustomFormField(
              controller: _roleController,
              cKeyBoardType: TextInputType.text,
              cInputAction: TextInputAction.next,
              hintText: "",
              caps: TextCapitalization.sentences,
              fillColour: formFieldLightGrey,
            ),
            Padding(
              padding: EdgeInsets.symmetric(vertical: 20),
              child: controller.imageFile != null
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
                                            onPressed: () async {
                                              await imageFromGallery();
                                              Get.back();
                                            },
                                            style: ElevatedButton.styleFrom(
                                              primary: Colors.white,
                                            ),
                                            child: Text("Upload from Gallery",
                                                style: TextStyle(
                                                    color: Colors.black))),
                                        Padding(
                                          padding: EdgeInsets.symmetric(
                                              vertical: 15),
                                          child: ElevatedButton(
                                              onPressed: () async {
                                                await imageFromCamera();
                                                Get.back();
                                              },
                                              style: ElevatedButton.styleFrom(
                                                primary: Colors.white,
                                              ),
                                              child:
                                                  Text("Upload from Camera",style: TextStyle(
                                                      color: Colors.black))),
                                        ),
                                        ElevatedButton(
                                            onPressed: () => Get.back(),
                                            style: ElevatedButton.styleFrom(
                                              primary: Colors.white,
                                            ),
                                            child: Text("Cancel",style: TextStyle(
                                                color: Colors.black))),
                                      ]),
                                ),
                              ),
                            ),
                          ),
                        );
                      },
                      child: Container(
                        height: 180,
                        decoration: BoxDecoration(
                          image: DecorationImage(
                              image: Image.file(controller.imageFile!).image,
                              fit: BoxFit.contain),
                        ),
                      ),
                    )
                  : Get.arguments["edit"] == true
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
                                                onPressed: () async {
                                                  await imageFromGallery();
                                                  Get.back();
                                                },
                                                style: ElevatedButton.styleFrom(
                                                  primary: Colors.white,
                                                ),
                                                child: Text(
                                                    "Upload from Gallery",style: TextStyle(
                                                    color: Colors.black))),
                                            Padding(
                                              padding: EdgeInsets.symmetric(
                                                  vertical: 15),
                                              child: ElevatedButton(
                                                  onPressed: () async {
                                                    await imageFromCamera();
                                                    Get.back();
                                                  },
                                                  style: ElevatedButton.styleFrom(
                                                    primary: Colors.white,
                                                  ),
                                                  child: Text(
                                                      "Upload from Camera",style: TextStyle(
                                                      color: Colors.black))),
                                            ),
                                            ElevatedButton(
                                                style: ElevatedButton.styleFrom(
                                                  primary: Colors.white,
                                                ),
                                                onPressed: () => Get.back(),
                                                child: Text("Cancel",style: TextStyle(
                                                    color: Colors.black))),
                                          ]),
                                    ),
                                  ),
                                ),
                              ),
                            );
                          },
                          child: Container(
                            height: 200,
                            // width: double.infinity,
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(15),
                              image: DecorationImage(
                                  image: NetworkImage(
                                      Get.arguments["memberImage"]),
                                  fit: BoxFit.contain),
                            ),
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
                                                onPressed: () async {
                                                  await imageFromGallery();
                                                  Get.back();
                                                },
                                                style: ElevatedButton.styleFrom(
                                                  primary: Colors.white,
                                                ),
                                                child: Text(
                                                    "Upload from Gallery",style: TextStyle(
                                                    color: Colors.black))),
                                            Padding(
                                              padding: EdgeInsets.symmetric(
                                                  vertical: 15),
                                              child: ElevatedButton(
                                                  onPressed: () async {
                                                    await imageFromCamera();
                                                    Get.back();
                                                  },
                                                  style: ElevatedButton.styleFrom(
                                                    primary: Colors.white,
                                                  ),
                                                  child: Text(
                                                      "Upload from Camera",style: TextStyle(
                                                      color: Colors.black))),
                                            ),
                                            ElevatedButton(
                                                style: ElevatedButton.styleFrom(
                                                  primary: Colors.white,
                                                ),
                                                onPressed: () => Get.back(),
                                                child: Text("Cancel",style: TextStyle(
                                                    color: Colors.black))),
                                          ]),
                                    ),
                                  ),
                                ),
                              ),
                            );
                          },
                          child: Container(
                            height: 180,
                            // width: double.infinity,
                            decoration: BoxDecoration(
                              color: customLightGrey,
                              borderRadius: BorderRadius.circular(15),
                            ),
                            child: Center(
                                child: Icon(
                              Icons.camera_alt,
                              size: 50,
                              color: customPurple,
                            )),
                          ),
                        ),
            ),
            Spacer(),
            Padding(
              padding: EdgeInsets.symmetric(vertical: 20),
              child: ElevatedButton(
                child: Text(Get.arguments["edit"] ? "Update" : 'Save'),
                onPressed: () {
                  if (Get.arguments['edit'] == false) {
                    memberController.setMember(
                        controller.imageFile!,
                        _nameController.text,
                        _bioController.text,
                        _roleController.text);
                    controller.imageFile = null;
                  } else {
                    //TODO: if the image changes delete the old one and add the new one.
                    memberController.updateMember(
                        Get.arguments["id"],
                        _nameController.text,
                        _bioController.text,
                        _roleController.text);
                  }
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
