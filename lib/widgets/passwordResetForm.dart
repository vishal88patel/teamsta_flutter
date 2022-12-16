import 'package:flutter/material.dart';
import 'package:teamsta/constants/prefrence_box.dart';
import 'package:teamsta/widgets/widgets.dart';

import '../constants/dimensions.dart';
import '../constants/controllers.dart';

class NewPasswordForm extends StatefulWidget {
  const NewPasswordForm({
    Key? key,
    required this.passwordController,
  }) : super(key: key);

  final TextEditingController passwordController;

  @override
  State<NewPasswordForm> createState() => _NewPasswordFormState();
}

class _NewPasswordFormState extends State<NewPasswordForm> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  TextEditingController rePassword = TextEditingController();

  @override
  void initState() {
    super.initState();
    controller.passwordController.clear();
  }

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

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.transparent,
      body: Center(
        child: Form(
          key: _formKey,
          autovalidateMode: AutovalidateMode.always,
          child: Container(
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(15),
              color: Colors.white,
            ),
            height: 500,
            width: mobileWidth - 50,
            child: Padding(
              padding: EdgeInsets.symmetric(horizontal: 20, vertical: 20),
              child:
                  Column(mainAxisAlignment: MainAxisAlignment.start, children: [
                Text(
                  "Please enter a new password and add the code sent to your email address",
                  style: Theme.of(context).textTheme.headline2,
                ),
                const SizedBox(height: 20),
                CustomFormField(
                  controller: controller.passwordController,
                  cKeyBoardType: TextInputType.text,
                  cInputAction: TextInputAction.done,
                  hintText: "Password",
                  caps: TextCapitalization.none,
                  isObscured: true,
                  fillColour: Colors.grey[200],
                  validate: (value) {
                    return passwordValidation(value!);
                  },
                ),
                const SizedBox(height: 10),
                CustomFormField(
                  controller: rePassword,
                  cKeyBoardType: TextInputType.text,
                  cInputAction: TextInputAction.done,
                  isObscured: true,
                  fillColour: Colors.grey[200],
                  hintText: "Repeat Password",
                  caps: TextCapitalization.none,
                  validate: (value) {
                    if (value != controller.passwordController.text) {
                      return "Passwords do not match";
                    }
                    return null;
                  },
                ),
                const SizedBox(height: 10),
                CustomFormField(
                  controller: controller.token,
                  cKeyBoardType: TextInputType.text,
                  cInputAction: TextInputAction.done,
                  isObscured: false,
                  fillColour: Colors.grey[200],
                  hintText: "Reset Code",
                  caps: TextCapitalization.none,
                ),
                Spacer(),
                Padding(
                  padding: EdgeInsets.symmetric(vertical: 20),
                  child: ElevatedButton(
                      onPressed: () {
                        if (_formKey.currentState!.validate()) {
                          var email = boxForgottenPassword.read("email");
                          controller.resetPassword(email);
                        }
                      },
                      child: Text("Reset Password")),
                )
              ]),
            ),
          ),
        ),
      ),
    );
  }
}
