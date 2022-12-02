import 'package:get/get.dart';
import 'package:teamsta/screens/page_exports.dart';
import 'package:teamsta/widgets/widgets.dart';

import '../screens/auth/login.dart';
import '../screens/auth/registration.dart';
import '../screens/auth/splashScreen.dart';
import '../screens/organisation/widgets/widgets.dart';

part './routing.dart';

abstract class AppPages {
  static final pages = [
    // shared pages.
    GetPage(name: Routes.SPLASH, page: () => SplashPage()),
    GetPage(name: Routes.LOGIN, page: () => LoginPage()),
    GetPage(name: Routes.REGISTER, page: () => RegistrationPage()),
    GetPage(name: Routes.PRIVACY, page: () => PrivacyPolicy()),
    GetPage(name: Routes.TERMS, page: () => TermsAndConditions()),

    // main screen for the user
    GetPage(name: Routes.NAV, page: () => CustomNavigation()),
    GetPage(name: Routes.CLUB, page: () => ClubView()),
    GetPage(name: Routes.SERVICES, page: () => ServicesPage()),
    GetPage(name: Routes.MESSAGING, page: () => MessagingPage()),
    GetPage(name: Routes.INAPPCHAT, page: () => InAppChat()),
    GetPage(name: Routes.FIXTURES, page: () => FixturesPage()),
    GetPage(name: Routes.RESULTS, page: () => ResultsPage()),
    GetPage(name: Routes.CLUBNEWS, page: () => NewsPage()),
    GetPage(name: Routes.TEAMBIO, page: () => TeamBioPage()),
    GetPage(name: Routes.SETTINGS, page: () => SettingsPage()),
    GetPage(name: Routes.USER_SERVICE, page: () => UserService()),

    // main screens for the Teams.
    GetPage(name: Routes.SETUP, page: () => SetupPage()),
    GetPage(name: Routes.PENDING, page: () => PendingPage()),
    GetPage(name: Routes.ORGHOME, page: () => OrgHomePage()),
    GetPage(name: Routes.SETUP2, page: () => Setup2()),
    GetPage(name: Routes.SETUP3, page: () => Setup3()),
    GetPage(name: Routes.SETUP4, page: () => Setup4()),
    GetPage(name: Routes.SETUP5, page: () => Setup5()),
    GetPage(
        name: Routes.FIXTURECREATE,
        page: () => FixtureCreateForm(
              comeFromEdit: false,
            )),
  ];
}
