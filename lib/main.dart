import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:teamsta/constants/export_constants.dart';
import 'package:teamsta/widgets/widgets.dart';

void main() async {
// login keep logged in.
  // check if the user is logged in and compare it with the box thn send them to the correct page.
  // in initial page rout.
  WidgetsFlutterBinding.ensureInitialized();
  await GetStorage.init();
  // await dotenv.load(fileName: "secrets.env");

  // portrait mode only
  SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp]);

  print(accessToken);

  // boxAccessToken.erase();
  // accessToken = null;

  // boxForgottenPassword.erase();

  runApp(GetMaterialApp(
    debugShowCheckedModeBanner: false,
    initialRoute: Routes.SPLASH,
    theme: appThemeData,
    defaultTransition: Transition.fade,
    getPages: AppPages.pages,
  ));
}
