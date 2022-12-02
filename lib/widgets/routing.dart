part of './pages.dart';

abstract class Routes {
  static const SPLASH = '/';
  static const LOGIN = '/login';
  static const REGISTER = '/register';
  static const NAV = '/nav';
  static const PRIVACY = '/privacy';	
  static const TERMS = '/terms';

  // user only pages
  static const CLUB = '/club';
  static const SERVICES = '/services';
  static const MESSAGING = '/messaging';
  static const INAPPCHAT = '/inAppChat';
  static const FIXTURES = '/fixtures';
  static const RESULTS = '/results';
  static const CLUBNEWS = '/clubNews';
  static const TEAMBIO = '/teamBio';
  static const SETTINGS = '/settings';
  static const USER_SERVICE = '/userService';


  // Organisation only pages
  static const SETUP = '/setup';
  static const PENDING = '/pending';
  static const ORGHOME = '/orgHome';
  static const SETUP2 = '/setup2';
  static const SETUP3 = '/setup3';
  static const SETUP4 = '/setup4';
  static const SETUP5 = '/setup5';
  static const FIXTURECREATE = '/fixtureCreate';	
}
