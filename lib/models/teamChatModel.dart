class TeamChat {
  TeamChat({
    required this.user,
    required this.groupChats,
    required this.privateChats,
  });

  User user;
  List<dynamic> groupChats;
  List<dynamic> privateChats;

  factory TeamChat.fromJson(Map<String, dynamic> json) => TeamChat(
        user: User.fromJson(json["user"]),
        groupChats: List<dynamic>.from(json["group_chats"].map((x) => x)),
        privateChats: List<dynamic>.from(json["private_chats"].map((x) => x)),
      );

  Map<String, dynamic> toJson() => {
        "user": user.toJson(),
        "group_chats": List<dynamic>.from(groupChats.map((x) => x)),
        "private_chats": List<dynamic>.from(privateChats.map((x) => x)),
      };
}

class User {
  User({
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
    required this.groups,
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
  List<Group> groups;

  factory User.fromJson(Map<String, dynamic> json) => User(
        id: json["id"],
        roleId: json["role_id"],
        userRole: json["user_role"],
        firstName: json["first_name"],
        lastName: json["last_name"],
        billingRate: json["billing_rate"],
        email: json["email"],
        emailVerifiedAt: json["email_verified_at"],
        isApproved: json["is_approved"],
        //created at can be null
        createdAt: json["created_at"] == null
            ? DateTime.now()
            : DateTime.parse(json["created_at"]),
        // updated at can be null
        updatedAt: json["updated_at"] == null
            ? DateTime.now()
            : DateTime.parse(json["updated_at"]),
        // contact number can be null
        contactNumber:
            json["contact_number"] == null ? "" : json["contact_number"],
        // groups can be empty
        groups: json["groups"] == null
            ? []
            : List<Group>.from(json["groups"].map((x) => Group.fromJson(x))),
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
