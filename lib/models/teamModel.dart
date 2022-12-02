import 'package:teamsta/constants/export_constants.dart';
import 'package:teamsta/widgets/getLatLng.dart';

import '../widgets/getLocation.dart';

class TeamModel {
  TeamModel({
    required this.id,
    required this.userId,
    required this.clubName,
    required this.description,
    required this.category,
    required this.isLoggedIn,
    required this.imgUrl,
    required this.phones,
    required this.emails,
    // required this.sites,
    required this.addressLine1,
    required this.addressLine2,
    required this.town,
    required this.county,
    required this.postcode,
    required this.isApproved,
    required this.createdAt,
    required this.updatedAt,
    required this.profileImages,
  });

  int id;
  int userId;
  String clubName;
  String description;
  String category;
  int isLoggedIn;
  dynamic imgUrl;
  List<Contacts> phones;
  List<Emails> emails;
  // List<Websites> sites;
  String addressLine1;
  String addressLine2;
  String town;
  String county;
  String postcode;
  String isApproved;
  DateTime createdAt;
  DateTime updatedAt;
  double? distance;
  final List<ProfileImage> profileImages;

    getTheDistance() async {
   var response = await GetLatLng().getCoords(
        addressLine1 + ',' + addressLine2 + ',' + town + ',' + county + "," + postcode);
    if (response != null) {
    distance =  GetLocation().calculateDistance(response.latitude, response.longitude);
    }
  }

  factory TeamModel.fromJson(Map<String, dynamic> json) => TeamModel(
        id: json["id"],
        userId: json["user_id"],
        clubName: json["club_name"],
        description: json["description"],
        category: json["category"],
        isLoggedIn: json["is_logged_in"],
        imgUrl: (json.containsKey('image')) &&
                (json['image'] != null) &&
                (json['image'].containsKey('img_url'))
            ? "https://teamsta.createaclients.co.uk" + json["image"]["img_url"]
            : null,
        profileImages: json['profile_images'] != null
            ? List<ProfileImage>.from(
                json["profile_images"].map((x) => ProfileImage.fromJson(x)))
            : [],
        phones: List<Contacts>.from(
            json['phones'].map((x) => Contacts.fromJson(x))),
        emails:
            List<Emails>.from(json["emails"].map((x) => Emails.fromJson(x))),
        // sites:
        //     List<Websites>.from(json['sites'].map((x) => Websites.fromJson(x))),
        addressLine1: json["address_line_1"],
        addressLine2: json["address_line_2"] == null ? "" : json["address_line_2"],
        town: json["town_or_city"],
        county: json["county"],
        postcode: json["postcode"],
        isApproved: json["is_approved"],
        createdAt: DateTime.parse(json["created_at"]),
        updatedAt: DateTime.parse(json["updated_at"]),
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "user_id": userId,
        "club_name": clubName,
        "description": description,
        "category": category,
        "is_logged_in": isLoggedIn,
        "image": imgUrl,
        "phones": phones,
        "emails": emails,
        // "sites": sites,
        "address_line_1": addressLine1,
        "address_line_2": addressLine2,
        "town_or_city": town,
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
    required this.teamId,
    required this.imgUrl,
  });

  final int id;
  final int teamId;
  final String imgUrl;

  factory ProfileImage.fromJson(Map<String, dynamic> json) => ProfileImage(
        id: json["id"],
        teamId: json["team_id"],
        imgUrl: imageBaseWithout + json["img_url"],
      );
}

class Emails {
  Emails({
    this.id,
    required this.name,
    required this.email,
    this.teamId,
  });

  int? id;
  String name;
  String email;
  int? teamId;

  factory Emails.fromJson(Map<String, dynamic> json) => Emails(
        id: json["id"],
        name: json["name"],
        email: json["email"],
        teamId: json["team_id"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "name": name,
        "email": email,
        "team_id": teamId,
      };
}

class Contacts {
  Contacts({
    this.id,
    required this.name,
    required this.number,
    this.teamId,
  });

  int? id;
  String name;
  String number;
  int? teamId;

  factory Contacts.fromJson(Map<String, dynamic> json) => Contacts(
        id: json["id"],
        name: json["name"],
        number: json["number"],
        teamId: json["team_id"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "name": name,
        "number": number,
        "team_id": teamId,
      };
}

class Websites {
  Websites({
    this.id,
    required this.name,
    required this.url,
    this.teamId,
  });

  int? id;
  String name;
  String url;
  int? teamId;

  factory Websites.fromJson(Map<String, dynamic> json) => Websites(
        id: json["id"],
        name: json["name"],
        url: json["url"],
        teamId: json["team_id"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "name": name,
        "url": url,
        "team_id": teamId,
      };
}
