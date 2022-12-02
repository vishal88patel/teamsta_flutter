import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:teamsta/constants/export_constants.dart';
import 'package:teamsta/models/teamModel.dart';
import 'package:teamsta/widgets/widgets.dart';

class ContactWebsites extends StatefulWidget {
  @override
  State<ContactWebsites> createState() => _ContactWebsitesState();
}

class _ContactWebsitesState extends State<ContactWebsites> {
  // const ContactWebsites({Key? key}) : super(key: key);

  TextEditingController _contactName = TextEditingController();
  TextEditingController _contactWebsite = TextEditingController();

  clearControllers() {
    _contactName.clear();
    _contactWebsite.clear();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Websites"),
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
      body: Center(
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 20, vertical: 10),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Center(
                child: Text(
                  "Team/Organisation contact information",
                  style: Theme.of(context).textTheme.headline2!.copyWith(
                        fontWeight: FontWeight.w900,
                      ),
                ),
              ),
              Padding(
                padding: EdgeInsets.only(top: 20),
                child: Text(
                  "Web Addresses",
                  style: Theme.of(context).textTheme.headline2!.copyWith(
                        fontWeight: FontWeight.w900,
                      ),
                ),
              ),
              Text(
                "Enter your Website Address",
                style: Theme.of(context).textTheme.headline3,
              ),
              CustomFormField(
                controller: _contactWebsite,
                cKeyBoardType: TextInputType.number,
                cInputAction: TextInputAction.next,
                hintText: "",
                caps: TextCapitalization.none,
                fillColour: customLightGrey,
              ),
              Text(
                "Enter a name of your web address EG: Main Office",
                style: Theme.of(context).textTheme.headline3,
              ),
              CustomFormField(
                controller: _contactName,
                cKeyBoardType: TextInputType.text,
                cInputAction: TextInputAction.done,
                hintText: "",
                caps: TextCapitalization.sentences,
                fillColour: customLightGrey,
              ),
              Padding(
                padding: EdgeInsets.symmetric(vertical: 20),
                child: ElevatedButton(
                    onPressed: () {
                      FocusManager.instance.primaryFocus!.unfocus();
                      if (_contactName.text.isEmpty ||
                          _contactWebsite.text.isEmpty) {
                        Get.snackbar(
                          '',
                          '',
                          titleText: Text(
                            "Form Error",
                            textAlign: TextAlign.center,
                            style: Theme.of(context)
                                .textTheme
                                .headline2!
                                .copyWith(color: Colors.white),
                          ),
                          messageText: Text(
                            "Please enter the contact details",
                            textAlign: TextAlign.center,
                            style: Theme.of(context)
                                .textTheme
                                .headline3!
                                .copyWith(color: Colors.white),
                          ),
                        );
                      } else {
                        controller.updateWebsiteAddresses(
                            _contactName.text, _contactWebsite.text);
                        teamController.websiteList.value.add(
                          Websites.fromJson(
                            {
                              'name': _contactName.text,
                              "url": _contactWebsite.text,
                            },
                          ),
                        );
                        clearControllers();
                      }
                    },
                    child: Text("Add")),
              ),
              Divider(
                thickness: 1,
                indent: 10,
                endIndent: 10,
              ),
              Expanded(
                child: Obx(() => ListView.builder(
                      shrinkWrap: true,
                      itemCount: teamController.websiteList.value.length,
                      itemBuilder: (context, index) {
                        if (teamController.websiteList.value.length == 0) {
                          return Spacer();
                        } else
                          return Dismissible(
                            background: Container(color: Colors.red),
                            onDismissed: (_) {
                              print("Before: " + index.toString());
                              if (teamController.websiteList.value.length > 0) {
                                teamController.websiteList.value
                                    .removeAt(index);
                              }
                            },
                            //! don't change this!!!!!!
                            key: UniqueKey(),
                            child: ListTile(
                              // shape: Border(bottom: BorderSide(color: Colors.grey)),
                              title: Text(
                                teamController.websiteList.value[index].name,
                                style: Theme.of(context)
                                    .textTheme
                                    .headline3!
                                    .copyWith(
                                      fontWeight: FontWeight.bold,
                                    ),
                              ),
                              subtitle: Text(
                                teamController.websiteList.value[index].url,
                                style: Theme.of(context).textTheme.headline3,
                              ),
                            ),
                          );
                      },
                    )),
              ),
              Padding(
                padding: EdgeInsets.only(bottom: 50, top: 20),
                child: ElevatedButton(
                    onPressed: () {
                      //! only using this as the update does not take a list.
                      Future.delayed(Duration(seconds: 2), () => Get.back());
                    },
                    child: Text("Update")),
              )
            ],
          ),
        ),
      ),
    );
  }
}
