import 'package:teamsta/controllers/chatController.dart';
import 'package:teamsta/controllers/fixturesController.dart';
import 'package:teamsta/controllers/followingController.dart';
import 'package:teamsta/controllers/getTeamInfoController.dart';
import 'package:teamsta/controllers/getUserInfoController.dart';
import 'package:teamsta/controllers/membersController.dart';
import 'package:teamsta/controllers/newsController.dart';
import 'package:teamsta/controllers/privacy_terms.dart';
import 'package:teamsta/controllers/registrationController.dart';
import 'package:teamsta/controllers/resultsController.dart';
import 'package:teamsta/controllers/servicesController.dart';
import 'package:teamsta/controllers/team_registrationController.dart';
import 'package:teamsta/models/teamModel.dart';

import '../controllers/notificationController.dart';

Information controller = Information();
GetTeamInfoController teamGetController = GetTeamInfoController();
GetUserInfoController userGetController = GetUserInfoController();
FixturesController fixtureController = FixturesController();
ResultsController resultController = ResultsController();
PrivacyTermsController privacyTermsController = PrivacyTermsController();
NewsController newsController = NewsController();
ChatController chatController = ChatController();
TeamController teamController = TeamController();
MemberController memberController = MemberController();
ServicesController servicesController = ServicesController();
// GetAllController getAllController = GetAllController();
FollowingController followingController = FollowingController();
NotificationsController notificationController = NotificationsController();

TeamModel? teamModel;
