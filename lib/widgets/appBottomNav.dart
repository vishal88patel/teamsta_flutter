import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:search_map_location/search_map_location.dart';
import 'package:teamsta/constants/export_constants.dart';
import 'package:teamsta/widgets/custom_search_bar.dart';
import 'package:teamsta/widgets/getLatLng.dart';
import 'package:teamsta/widgets/getLocation.dart';

class CustomBottomSearch extends StatelessWidget {
  const CustomBottomSearch({
    Key? key,
    required this.selectedCategory,
    required this.itemCount,
    required this.searchCategories,
    required this.controller,
    required this.onChange,
    required this.isVisible,
    required this.function,
    required this.callData,
  }) : super(key: key);

  final RxString selectedCategory;
  final int itemCount;
  final List<String> searchCategories;

  final TextEditingController controller;
  final void Function(String) onChange;
  final RxBool isVisible;
  final Function function;
  final Future<void> Function() callData;

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(borderRadius: BorderRadius.circular(10)),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          IntrinsicHeight(
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Container(
                  width: 150,
                  height: 40,
                  child: TextButton.icon(
                    onPressed: () {
                      Get.to(CustomLocationDialog(
                        function: callData,
                      ));
                    },
                    icon: Image.asset(
                      CustomImage().pinIcon,
                      height: 20,
                    ),
                    label: Text(
                      "Location",
                      style: Theme.of(context)
                          .textTheme
                          .headline3!
                          .copyWith(color: Colors.white),
                    ),
                  ),
                ),
                VerticalDivider(
                  color: Colors.white,
                  thickness: 1,
                ),
                Flexible(
                  child: TextButton.icon(
                    onPressed: () {
                      Get.to(
                        Scaffold(
                          appBar: AppBar(
                            leading: InkWell(
                                onTap: () {
                                  Get.back();
                                },
                                child: Icon(
                                  CupertinoIcons.chevron_back,
                                  color: primaryWhite,
                                  size: 30,
                                )),                          ),
                          body: Container(
                            child: ListView.builder(
                              itemCount: itemCount,
                              itemBuilder: ((context, index) {
                                return Center(
                                  child: InkWell(
                                      onTap: () {
                                        selectedCategory.value =
                                            searchCategories[index];
                                        function();
                                      },
                                      child: Padding(
                                        padding:
                                            EdgeInsets.symmetric(vertical: 5),
                                        child: Text(
                                          searchCategories[index],
                                          style: Theme.of(context)
                                              .textTheme
                                              .headline3,
                                        ),
                                      )),
                                );
                              }),
                            ),
                          ),
                          bottomNavigationBar: Padding(
                              padding: EdgeInsets.symmetric(
                                  vertical: 10, horizontal: 20),
                              child: ElevatedButton(
                                  onPressed: () {
                                    Get.back();
                                  },
                                  child: Text(
                                    "Update",
                                    style: Theme.of(context)
                                        .textTheme
                                        .headline3!
                                        .copyWith(color: Colors.white),
                                  ))),
                        ),
                      );
                    },
                    icon: Image.asset(
                      CustomImage().filterIcon,
                      height: 20,
                    ),
                    label: Obx(
                      () => Text(
                        selectedCategory.value != ""
                            ? selectedCategory.value
                            : searchCategories[0],
                        style: Theme.of(context).textTheme.headline3!.copyWith(
                              color: Colors.white,
                            ),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
          CustomSearchBar(
            controller: controller,
            onChange: onChange,
            isVisible: isVisible,
          )
        ],
      ),
    );
  }
}

class CustomLocationDialog extends StatelessWidget {
  const CustomLocationDialog({Key? key, required this.function})
      : super(key: key);

  final Future<void> Function() function;

  static TextEditingController controller = TextEditingController();

  static RxBool isLocation = false.obs;

  static RxBool isLoading = false.obs;

  static String? newLocation;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
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
        padding: EdgeInsets.symmetric(horizontal: 20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: EdgeInsets.symmetric(vertical: 20, horizontal: 10),
              child: Text(
                "Filter by location",
                style: Theme.of(context).textTheme.headline1,
              ),
            ),
            Obx(() => Row(
                  children: [
                    Switch(
                        value: isLocation.value,
                        onChanged: (value) {
                          isLocation.toggle();
                        }),
                    Text(
                      "Use current Location",
                      style: Theme.of(context).textTheme.headline3,
                    )
                  ],
                )),
            // Padding(
            //   padding: EdgeInsets.only(top: 20),
            //   child: TextFormWithTopText(
            //     text: "Or enter a Postcode",
            //     controller: controller,
            //     caps: TextCapitalization.characters,
            //     keyboard: TextInputAction.done,
            //   ),
            // ),
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 10),
              child: Text(
                "or enter a postcode",
                style: Theme.of(context).textTheme.headline2,
              ),
            ),
            SearchLocation(
              apiKey: env("GoogleKey"),
              language: 'en',
              country: 'uk',
              iconColor: customOrange,
              radius: 15000,
              onChangeText: (_) {
                if (isLocation.value == true) {
                  isLocation.toggle();
                }
              },
              onSelected: (place) {
                print(place.description);

                newLocation = place.description;
              },
            ),
            Spacer(),
            Padding(
              padding: EdgeInsets.symmetric(
                vertical: 20,
              ),
              child: ElevatedButton(
                onPressed: () async {
                  isLoading.toggle();
                  //* Location toggle
                  if (isLocation.value == true) {
                    latUpdate = false;
                    GetLocation().getLocation().then((_) {
                      isLoading.toggle();
                    });
                  }
                  //* Postcode
                  else {
                    isLoading.toggle();
                    latUpdate = true;
                    GetLatLng().getCoords(newLocation!).then((value) {
                      lat = value!.latitude;
                      lng = value.longitude;
                    });
                  }
                  await function();
                  Get.back();
                },
                child: Obx(
                  () {
                    return !isLoading.value
                        ? Text(
                            "Apply",
                          )
                        : Transform.scale(
                            scale: .5,
                            child: CircularProgressIndicator(
                              color: Colors.white,
                              semanticsLabel: "Loading",
                            ),
                          );
                  },
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
