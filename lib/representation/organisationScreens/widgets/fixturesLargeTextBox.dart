import 'package:flutter/material.dart';
import 'package:teamsta/constants/export_constants.dart';

class LargeTextBox extends StatelessWidget {
  const LargeTextBox({
    Key? key,
    required this.controller,
    required this.hintText,
    this.isCenter,
    this.mainHint,
    this.hintStyle,
  }) : super(key: key);

  final TextEditingController controller;
  final String hintText;
  final String? mainHint;
  final CrossAxisAlignment? isCenter;
  final TextStyle? hintStyle;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(vertical: 5),
      child: Column(
        crossAxisAlignment: isCenter ?? CrossAxisAlignment.start,
        children: [
          Text(
            hintText,
            style: hintStyle ?? Theme.of(context).textTheme.headline3,
          ),
          Container(
            height: 150,
            width: mobileWidth - 40,
            decoration: BoxDecoration(
              color: formFieldLightGrey,
              borderRadius: BorderRadius.circular(15),
            ),
            child: TextFormField(
              textInputAction: TextInputAction.done,
              controller: controller,
              maxLines: null,
              decoration: InputDecoration(
                fillColor: formFieldLightGrey,
                border: InputBorder.none,
                hintText: mainHint ?? "",
                contentPadding: EdgeInsets.symmetric(
                  horizontal: 20,
                  vertical: 10,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
