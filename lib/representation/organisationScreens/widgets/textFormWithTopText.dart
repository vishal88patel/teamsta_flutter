import 'package:flutter/material.dart';
import 'package:teamsta/constants/export_constants.dart';
import 'package:teamsta/widgets/widgets.dart';

class TextFormWithTopText extends StatelessWidget {
  const TextFormWithTopText({
    Key? key,
    required this.controller,
    required this.text,
    required this.keyboard,
    required this.caps,
    this.hintText,
  }) : super(key: key);

  final TextEditingController controller;
  final String text;
  final TextInputAction keyboard;
  final TextCapitalization caps;
  final String? hintText;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 5),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            text,
            style: Theme.of(context).textTheme.headline3,
          ),
          CustomFormField(
            controller: controller,
            cKeyBoardType: TextInputType.text,
            cInputAction: keyboard,
            hintText: hintText ?? "",
            caps: caps,
            fillColour: formFieldLightGrey,
          ),
        ],
      ),
    );
  }
}
