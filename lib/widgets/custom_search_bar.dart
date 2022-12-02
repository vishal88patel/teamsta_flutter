import 'package:flutter/material.dart';
import 'package:get/get.dart';

// ignore: must_be_immutable
class CustomSearchBar extends StatelessWidget {
  final TextEditingController controller;
  CustomSearchBar({
    Key? key,
    required this.controller,
    required this.onChange,
    required this.isVisible,
  }) : super(key: key);

  final RxBool isVisible;
  final void Function(String) onChange;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(left: 20, right: 20, bottom: 20, top: 10),
      child: Container(
        alignment: Alignment.topCenter,
        width: double.infinity,
        height: 35,
        decoration: BoxDecoration(
            color: Colors.white.withOpacity(.3),
            borderRadius: BorderRadius.circular(11)),
        child: Stack(
          children: [
            Obx(() => isVisible.value
                ? Center(
                    child: RichText(
                      text: TextSpan(
                        children: [
                          WidgetSpan(
                            child: Icon(
                              Icons.search,
                              color: Colors.white,
                            ),
                          ),
                          WidgetSpan(
                              child: Text(
                            "Search",
                            style: Theme.of(context)
                                .textTheme
                                .headline3!
                                .copyWith(color: Colors.white),
                          ))
                        ],
                      ),
                    ),
                  )
                : Text("")),
            TextField(
              onChanged: onChange,
              controller: controller,
              textAlign: TextAlign.center,
              style: Theme.of(context)
                  .textTheme
                  .headline3!
                  .copyWith(color: Colors.white.withOpacity(0.5)),
              autofocus: false,
              decoration: InputDecoration(
                fillColor: Colors.transparent,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
