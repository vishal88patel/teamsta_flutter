import 'package:debug_overlay/debug_overlay.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:teamsta/constants/export_constants.dart';
import 'package:teamsta/constants/string_constants.dart';
import 'package:teamsta/widgets/widgets.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({Key? key}) : super(key: key);

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  emailValidation(String value) {
    if (value.isEmpty || !GetUtils.isEmail(value)) {
      Get.snackbar(
          StringConstants.ERROR, "Please enter a valid email address",
          colorText: Colors.white);
      return ;
    }
  }

  passwordValidation(String value) {
    if (value.isEmpty) {
      Get.snackbar(
          StringConstants.ERROR, "Please enter a password",
          colorText: Colors.white);
      return ;
    }
  }

// need to delay this as it runs before the login page is loaded.
  isForgottenPassword() {
    if (boxForgottenPassword.read('forgotten') == true) {
      Future.delayed(
          Duration(seconds: 1),
          () => Get.dialog(
              barrierColor: Colors.transparent,
              NewPasswordForm(
                  passwordController: controller.passwordController)));
    }
  }

  @override
  Widget build(BuildContext context) {
    isForgottenPassword();
    return Scaffold(
      backgroundColor: customOrange,
      body: Center(
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 20),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Spacer(
                flex: 4,
              ),
              Center(
                child: Container(
                  width: double.infinity,
                  height: 100,
                  decoration: BoxDecoration(
                    image: DecorationImage(image: CustomImage.splashLogo),
                  ),
                ),
              ),
              Spacer(
                flex: 2,
              ),
              Column(
                children: [
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
                    cInputAction: TextInputAction.done,
                    hintText: "Password",
                    caps: TextCapitalization.none,
                    isObscured: true,
                    // validate: (value) {
                    //   return passwordValidation(value!);
                    // },
                  ),
                  Padding(
                    padding: EdgeInsets.symmetric(vertical: 5),
                    child: TextButton(
                      onPressed: () {
                        Get.dialog(
                          barrierColor: Colors.black.withOpacity(0.7),
                          Scaffold(
                            backgroundColor: Colors.transparent,
                            body: Center(
                              child: Container(
                                width: mobileWidth - 50,
                                height: mobileHight / 3,
                                decoration: BoxDecoration(
                                  color: Colors.white,
                                  borderRadius: BorderRadius.circular(15),
                                ),
                                child: Padding(
                                  padding:
                                      EdgeInsets.symmetric(horizontal: 10),
                                  child: Column(
                                    mainAxisAlignment:
                                        MainAxisAlignment.start,
                                    crossAxisAlignment:
                                        CrossAxisAlignment.center,
                                    children: [
                                      Padding(
                                        padding: EdgeInsets.symmetric(
                                            vertical: 20),
                                        child: Text(
                                          "Forgot Password?",
                                          style: TextStyle(
                                            fontSize: 20,
                                            fontWeight: FontWeight.w900,
                                            color: primaryBlack,
                                          ),

                                        ),
                                      ),
                                      Padding(
                                        padding: EdgeInsets.only(bottom: 20),
                                        child: Text(
                                          "Enter your email address below\nand we will send you a password reset\nlink",
                                          textAlign: TextAlign.center,
                                          style: TextStyle(
                                            fontSize: 15,
                                            fontWeight: FontWeight.w900,
                                            color: primaryBlack,
                                          ),
                                        ),
                                      ),
                                      CustomFormField(
                                          controller:
                                              controller.emailController,
                                          fillColour: customLightGrey,
                                          cKeyBoardType:
                                              TextInputType.emailAddress,
                                          caps: TextCapitalization.none,
                                          cInputAction: TextInputAction.done,
                                          hintText: "Email Address"),
                                      Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceEvenly,
                                        children: [
                                          Container(
                                            width: mobileWidth / 2 - 50,
                                            height: 45,
                                            child: ElevatedButton(
                                              style: ElevatedButton.styleFrom(
                                                  primary: customLightGrey,
                                                  elevation: 0),
                                              onPressed: () {
                                                controller.emailController
                                                    .clear();
                                                Get.back();
                                              },
                                              child: Text(
                                                "Cancel",
                                                style: Theme.of(context)
                                                    .textTheme
                                                    .headline3,
                                              ),
                                            ),
                                          ),
                                          Container(
                                            width: mobileWidth / 2 - 50,
                                            height: 45,
                                            child: ElevatedButton(
                                              style: ElevatedButton.styleFrom(
                                                  elevation: 0),
                                              onPressed: () {
                                                if (controller.emailController
                                                        .text.isEmpty ||
                                                    !GetUtils.isEmail(
                                                        controller
                                                            .emailController
                                                            .text
                                                            .trim())) {
                                                  Get.snackbar(
                                                    '',
                                                    '',
                                                    titleText: Text(
                                                      "Please enter a valid email address",
                                                      textAlign:
                                                          TextAlign.center,
                                                      style: Theme.of(context)
                                                          .textTheme
                                                          .headline2!
                                                          .copyWith(
                                                              color: Colors
                                                                  .white),
                                                    ),
                                                    messageText: Text(
                                                      "Please enter a valid email address",
                                                      textAlign:
                                                          TextAlign.center,
                                                      style: Theme.of(context)
                                                          .textTheme
                                                          .headline3!
                                                          .copyWith(
                                                              color: Colors
                                                                  .white),
                                                    ),
                                                  );
                                                } else {
                                                  controller.forgotPassword(
                                                      controller
                                                          .emailController
                                                          .text
                                                          .trim());
                                                }
                                              },
                                              child: Text("Send"),
                                            ),
                                          ),
                                        ],
                                      )
                                    ],
                                  ),
                                ),
                              ),
                            ),
                          ),
                        );
                      },
                      child: Text(
                        "Forgotten password?",
                        style: Theme.of(context)
                            .textTheme
                            .headline3!
                            .copyWith(
                                color: Colors.white,
                                fontWeight: FontWeight.normal),
                      ),
                    ),
                  ),
                  ElevatedButton(
                    onPressed: () {
                      if (controller.emailController.text.isEmpty) {
                        Get.snackbar(
                            StringConstants.ERROR, "Please Enter Email",
                            colorText: Colors.white);
                      } else if(!GetUtils.isEmail(controller.emailController.text)){
                        Get.snackbar(
                            StringConstants.ERROR, "Please Enter Valid Email",
                            colorText: Colors.white);
                      }else if(controller.passwordController.text.isEmpty){
                        Get.snackbar(
                            StringConstants.ERROR, "Please enter a password",
                            colorText: Colors.white);
                      }else{
                        // Get.offNamed("/nav");
                       controller.userLogin();
                      }
                    },
                    child: Text("Login"),
                  ),
                ],
              ),
              Spacer(),
              Padding(
                padding: EdgeInsets.only(bottom: 40),
                child: TextButton(
                  onPressed: () {
                    Get.toNamed("/register");
                  },
                  child: Text(
                    "Not Registered?",
                    style: Theme.of(context).textTheme.headline3!.copyWith(
                        color: Colors.white, fontWeight: FontWeight.normal),
                  ),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
