import 'package:teamsta/constants/export_constants.dart';

class UserModel {
  UserModel(
      {required this.id,
      required this.roleId,
      required this.userRole,
      required this.firstName,
      required this.lastName,
      required this.billingRate,
      required this.email,
      required this.emailVerifiedAt,
      required this.isApproved,
      required this.createdAt,
      required this.updatedAt,
      required this.contactNumber,
      required this.groups,
      required this.appUser,
      required this.favoriteTeams});

  final int id;
  final int roleId;
  final String userRole;
  final String firstName;
  final String lastName;
  final dynamic billingRate;
  final String email;
  final dynamic emailVerifiedAt;
  final String isApproved;
  final DateTime createdAt;
  final DateTime updatedAt;
  final dynamic contactNumber;
  final List<dynamic> groups;
  final AppUserImage appUser;
  final List<FavoriteTeam> favoriteTeams;

  factory UserModel.fromJson(Map<String, dynamic> json) => UserModel(
        id: json["id"],
        roleId: json["role_id"],
        userRole: json["user_role"],
        firstName: json["first_name"],
        lastName: json["last_name"],
        billingRate: json["billing_rate"],
        email: json["email"],
        emailVerifiedAt: json["email_verified_at"],
        isApproved: json["is_approved"],
        createdAt: DateTime.parse(json["created_at"]),
        updatedAt: DateTime.parse(json["updated_at"]),
        contactNumber: json["contact_number"],
        groups: List<dynamic>.from(json["groups"].map((x) => x)),
        appUser: json["user_image"] != null
            ? AppUserImage.fromJson(json["user_image"])
            : AppUserImage.fromJson({
                "id": 0,
                "user_id": 0,
                "image":
                    "https://teamsta.s3.ap-south-1.amazonaws.com/1619630000.png",
                "created_at": "2021-04-29T11:33:20.000000Z",
                "updated_at": "2021-04-29T11:33:20.000000Z"
              }),
        favoriteTeams: List<FavoriteTeam>.from(
            json["favorite_teams"].map((x) => FavoriteTeam.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "role_id": roleId,
        "user_role": userRole,
        "first_name": firstName,
        "last_name": lastName,
        "billing_rate": billingRate,
        "email": email,
        "email_verified_at": emailVerifiedAt,
        "is_approved": isApproved,
        "created_at": createdAt.toIso8601String(),
        "updated_at": updatedAt.toIso8601String(),
        "contact_number": contactNumber,
        "groups": List<dynamic>.from(groups.map((x) => x)),
        "app_user": appUser.toJson(),
      };
}

class AppUser {
  AppUser({
    required this.id,
    required this.userId,
    required this.isApproved,
    required this.isLoggedIn,
    required this.favoriteTeams,
    required this.createdAt,
    required this.updatedAt,
    required this.appUserImage,
  });

  final int id;
  final int userId;
  final String isApproved;
  final int isLoggedIn;
  final dynamic favoriteTeams;
  final DateTime createdAt;
  final DateTime updatedAt;
  final AppUserImage? appUserImage;

  factory AppUser.fromJson(Map<String, dynamic> json) => AppUser(
        id: json["id"],
        userId: json["app_user_id"],
        isApproved: json["is_approved"],
        isLoggedIn: json["is_logged_in"],
        favoriteTeams: json["favorite_teams"],
        createdAt: DateTime.parse(json["created_at"]),
        updatedAt: DateTime.parse(json["updated_at"]),
        appUserImage: json['app_user_image'] != null
            ? AppUserImage.fromJson(json["app_user_image"])
            : null,
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "user_id": userId,
        "is_approved": isApproved,
        "is_logged_in": isLoggedIn,
        "favorite_teams": favoriteTeams,
        "created_at": createdAt.toIso8601String(),
        "updated_at": updatedAt.toIso8601String(),
        "app_user_image": appUserImage!.toJson(),
      };
}

class AppUserImage {
  AppUserImage({
    required this.id,
    required this.appUserId,
    required this.imgUrl,
    required this.caption,
    required this.notes,
    required this.createdAt,
    required this.updatedAt,
  });

  final int id;
  final int appUserId;
  final String imgUrl;
  final dynamic caption;
  final dynamic notes;
  final DateTime createdAt;
  final DateTime updatedAt;

  factory AppUserImage.fromJson(Map<String, dynamic> json) => AppUserImage(
        id: json["id"],
        appUserId: json["app_user_id"] != null ? json["app_user_id"] : 0,
        imgUrl:
            json["img_url"] != null ? imageBaseWithout + json["img_url"] : "",
        caption: json["caption"],
        notes: json["notes"],
        createdAt: DateTime.parse(json["created_at"]),
        updatedAt: DateTime.parse(json["updated_at"]),
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "app_user_id": appUserId,
        "img_url": imgUrl,
        "caption": caption,
        "notes": notes,
        "created_at": createdAt.toIso8601String(),
        "updated_at": updatedAt.toIso8601String(),
      };
}

class FavoriteTeam {
  FavoriteTeam({
    required this.id,
    required this.clubName,
    required this.addressLine1,
    required this.addressLine2,
    required this.townOrCity,
    required this.county,
    required this.postcode,
    required this.teamId,
    required this.userId,
    required this.createdAt,
    required this.updatedAt,
    required this.image,
    required this.teamUserId,
  });

  int id;
  String clubName;
  String addressLine1;
  String addressLine2;
  String townOrCity;
  String county;
  String postcode;
  int teamId;
  int userId;
  int teamUserId;
  DateTime createdAt;
  DateTime updatedAt;
  AppUserImage image;

  factory FavoriteTeam.fromJson(Map<String, dynamic> json) => FavoriteTeam(
        id: json["id"],
        clubName: json["club_name"],
        addressLine1: json["address_line_1"],
        teamUserId: json["id_of_followed_team"],
        addressLine2:
            json["address_line_2"] != null ? json["address_line_2"] : "",
        townOrCity: json["town_or_city"],
        county: json["county"],
        postcode: json["postcode"],
        teamId: json["team_id"],
        userId: json["user_id"],
        createdAt: DateTime.parse(json["created_at"]),
        updatedAt: DateTime.parse(json["updated_at"]),
        image: AppUserImage.fromJson(json["image"]),
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "club_name": clubName,
        "address_line_1": addressLine1,
        "address_line_2": addressLine2,
        "town_or_city": townOrCity,
        "county": county,
        "postcode": postcode,
        "team_id": teamId,
        "user_id": userId,
        "created_at": createdAt.toIso8601String(),
        "updated_at": updatedAt.toIso8601String(),
      };
}
