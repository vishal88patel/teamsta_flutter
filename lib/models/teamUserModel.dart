import 'package:teamsta/constants/export_constants.dart';

class TeamUserModel {
  TeamUserModel({
    required this.id,
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
    required this.team,
    required this.groups,
    required this.user_image,
    required this.image,
  });

  int id;
  int roleId;
  String userRole;
  String firstName;
  String lastName;
  dynamic billingRate;
  String email;
  dynamic emailVerifiedAt;
  String isApproved;
  DateTime createdAt;
  DateTime updatedAt;
  dynamic contactNumber;
  Team team;
  List<Group> groups;
  String user_image;
  String image;

  factory TeamUserModel.fromJson(Map<String, dynamic> json) => TeamUserModel(
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
        image: json["image"] == null
            ? ""
            : imageBaseWithout + json["image"]["img_url"],
        user_image: json["user_image"] == null
            ? ""
            : imageBaseWithout + json["user_image"]["user_image"],
        contactNumber: json["contact_number"],
        team: Team.fromJson(json["team"]),
        groups: List<Group>.from(json["groups"].map((x) => Group.fromJson(x))),
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
        "team": team.toJson(),
        "groups": List<dynamic>.from(groups.map((x) => x.toJson())),
      };
}

class Group {
  Group({
    required this.id,
    required this.name,
    required this.welcomeMessage,
    required this.createdAt,
    required this.updatedAt,
    required this.pivot,
  });

  int id;
  String name;
  String welcomeMessage;
  DateTime createdAt;
  DateTime updatedAt;
  Pivot pivot;

  factory Group.fromJson(Map<String, dynamic> json) => Group(
        id: json["id"],
        name: json["name"],
        welcomeMessage: json["welcome_message"],
        createdAt: DateTime.parse(json["created_at"]),
        updatedAt: DateTime.parse(json["updated_at"]),
        pivot: Pivot.fromJson(json["pivot"]),
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "name": name,
        "welcome_message": welcomeMessage,
        "created_at": createdAt.toIso8601String(),
        "updated_at": updatedAt.toIso8601String(),
        "pivot": pivot.toJson(),
      };
}

class Pivot {
  Pivot({
    required this.userId,
    required this.groupId,
  });

  int userId;
  int groupId;

  factory Pivot.fromJson(Map<String, dynamic> json) => Pivot(
        userId: json["user_id"],
        groupId: json["group_id"],
      );

  Map<String, dynamic> toJson() => {
        "user_id": userId,
        "group_id": groupId,
      };
}

class Team {
  Team({
    required this.id,
    required this.userId,
    required this.clubName,
    required this.description,
    required this.category,
    required this.isLoggedIn,
    required this.addressLine1,
    required this.addressLine2,
    required this.townOrCity,
    required this.county,
    required this.postcode,
    required this.isApproved,
    required this.createdAt,
    required this.updatedAt,
    required this.profileImage,
  });

  int id;
  int userId;
  String clubName;
  String description;
  String category;
  int isLoggedIn;
  String addressLine1;
  String addressLine2;
  String townOrCity;
  String county;
  String postcode;
  String isApproved;
  DateTime createdAt;
  DateTime updatedAt;
  List<ProfileImage> profileImage;

  factory Team.fromJson(Map<String, dynamic> json) => Team(
        id: json["id"],
        userId: json["user_id"],
        clubName: json["club_name"],
        description: json["description"],
        category: json["category"],
        isLoggedIn: json["is_logged_in"],
        addressLine1: json["address_line_1"],
        // addressLine2 can be nullable
        addressLine2:
            json["address_line_2"] == null ? "" : json["address_line_2"],
        townOrCity: json["town_or_city"],
        county: json["county"],
        postcode: json["postcode"],
        isApproved: json["is_approved"],
        createdAt: DateTime.parse(json["created_at"]),
        updatedAt: DateTime.parse(json["updated_at"]),
        // profile image if not null then return list of profile image
        profileImage: json["profile_image"] == null
            ? []
            : List<ProfileImage>.from(
                json["profile_image"].map((x) => ProfileImage.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "user_id": userId,
        "club_name": clubName,
        "description": description,
        "category": category,
        "is_logged_in": isLoggedIn,
        "address_line_1": addressLine1,
        "address_line_2": addressLine2,
        "town_or_city": townOrCity,
        "county": county,
        "postcode": postcode,
        "is_approved": isApproved,
        "created_at": createdAt.toIso8601String(),
        "updated_at": updatedAt.toIso8601String(),
      };
}

class ProfileImage {
  ProfileImage({
    required this.id,
    required this.userId,
    required this.image,
    required this.createdAt,
    required this.updatedAt,
  });

  int id;
  int userId;
  String image;
  DateTime createdAt;
  DateTime updatedAt;

  factory ProfileImage.fromJson(Map<String, dynamic> json) => ProfileImage(
        id: json["id"],
        userId: json["user_id"],
        image: json["image"],
        createdAt: DateTime.parse(json["created_at"]),
        updatedAt: DateTime.parse(json["updated_at"]),
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "user_id": userId,
        "image": image,
        "created_at": createdAt.toIso8601String(),
        "updated_at": updatedAt.toIso8601String(),
      };
}
