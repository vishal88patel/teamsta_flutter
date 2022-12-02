import 'package:flutter/material.dart';

import '../constants/colors.dart';

class CustomFormField extends StatelessWidget {
  const CustomFormField({
    Key? key,
    required this.controller,
    required this.cKeyBoardType,
    required this.cInputAction,
    required this.hintText,
    this.validate,
    this.isObscured,
    this.fillColour,
    this.errorColour,
    required this.caps
  }) : super(key: key);

  final TextEditingController controller;
  final String? Function(String?)? validate;
  final bool? isObscured;
  final TextInputType? cKeyBoardType;
  final TextInputAction? cInputAction;
  final String hintText;
  final Color? fillColour;
  final Color? errorColour;
  final TextCapitalization caps;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(
        vertical: 5,
      ),
      child: TextFormField(
        controller: controller,
        validator: validate,
        obscureText: isObscured ?? false,
        textAlign: TextAlign.center,
        keyboardType: cKeyBoardType,
        textCapitalization: caps,
        textInputAction: cInputAction,
        decoration: InputDecoration(
          hintStyle: TextStyle(color: hintColor),
          hintText: hintText,
          contentPadding: EdgeInsets.all(5),
          fillColor: fillColour ?? Colors.white,
        ),
      ),
    );
  }
}
