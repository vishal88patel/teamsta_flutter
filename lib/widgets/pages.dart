import 'package:get/get.dart';
import 'package:teamsta/representation/page_exports.dart';
import 'package:teamsta/representation/userScreens/clubView.dart';
import 'package:teamsta/representation/userScreens/fixtures_page.dart';
import 'package:teamsta/representation/userScreens/in_app_chat.dart';
import 'package:teamsta/representation/userScreens/messaging.dart';
import 'package:teamsta/representation/userScreens/news_page.dart';
import 'package:teamsta/representation/userScreens/results_page.dart';
import 'package:teamsta/representation/userScreens/services.dart';
import 'package:teamsta/representation/userScreens/settings.dart';
import 'package:teamsta/representation/userScreens/team_bio_page.dart';
import 'package:teamsta/representation/userScreens/user_service.dart';
import 'package:teamsta/widgets/widgets.dart';

import '../representation/authScreens/loginScreen.dart';
import '../representation/authScreens/registrationScreen.dart';
import '../representation/authScreens/splashScreen.dart';
import '../representation/organisationScreens/widgets/fixture_form.dart';

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
