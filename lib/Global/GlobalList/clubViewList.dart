
import 'package:tuple/tuple.dart';

import '../../representation/clubScreens/aboutScreen.dart';
import '../../representation/clubScreens/contactsScreen.dart';
import '../../representation/clubScreens/fixturesScreen.dart';
import '../../representation/clubScreens/newsScreen.dart';
import '../../representation/clubScreens/resultsScreen.dart';
import '../../representation/clubScreens/servicesclubScreen.dart';
import '../../representation/clubScreens/teamScreen.dart';

final List<Tuple2> clubViewPages = [
  Tuple2("Fixtures", ClubFixtures()),
  Tuple2("Results", ClubResults()),
  Tuple2("Services", ClubServices()),
  Tuple2("News", ClubNews()),
  Tuple2("Team", ClubTeam()),
  Tuple2("Contacts", ClubContacts()),
  Tuple2("About", ClubAbout()),
];
