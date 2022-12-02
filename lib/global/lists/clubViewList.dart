import 'package:teamsta/screens/club_Screens/about.dart';
import 'package:teamsta/screens/club_Screens/contacts.dart';
import 'package:teamsta/screens/club_Screens/fixtures.dart';
import 'package:teamsta/screens/club_Screens/news.dart';
import 'package:teamsta/screens/club_Screens/results.dart';
import 'package:teamsta/screens/club_Screens/services_club.dart';
import 'package:teamsta/screens/club_Screens/team.dart';
import 'package:tuple/tuple.dart';

final List<Tuple2> clubViewPages = [
  Tuple2("Fixtures", ClubFixtures()),
  Tuple2("Results", ClubResults()),
  Tuple2("Services", ClubServices()),
  Tuple2("News", ClubNews()),
  Tuple2("Team", ClubTeam()),
  Tuple2("Contacts", ClubContacts()),
  Tuple2("About", ClubAbout()),
];
