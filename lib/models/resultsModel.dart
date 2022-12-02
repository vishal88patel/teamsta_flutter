import 'package:teamsta/constants/export_constants.dart';

class ResultsModel {
  ResultsModel({
    required this.id,
    required this.vs,
    required this.isHome,
    required this.homeScore,
    required this.awayScore,
    required this.result,
    required this.description,
    required this.addressLine1,
    required this.addressLine2,
    required this.townOrCity,
    required this.county,
    required this.postcode,
    required this.date,
    required this.time,
    required this.imgUrl,
    required this.createdAt,
    required this.updatedAt,
    required this.userId,
    required this.images,
  });

  int id;
  String vs;
  int isHome;
  int homeScore;
  int awayScore;
  String result;
  String description;
  String addressLine1;
  String addressLine2;
  String townOrCity;
  String county;
  String postcode;
  String date;
  String time;
  dynamic imgUrl;
  DateTime createdAt;
  DateTime updatedAt;
  int userId;
  List<Image> images;

  factory ResultsModel.fromJson(Map<String, dynamic> json) => ResultsModel(
        id: json["id"],
        vs: json["vs"],
        isHome: json["is_home"],
        homeScore: json["home_score"],
        awayScore: json["away_score"],
        result: json["result"],
        description: json["description"],
        addressLine1: json["address_line_1"],
        addressLine2:
            json["address_line_2"] != null ? json["address_line_2"] : "",
        townOrCity: json["town_or_city"],
        county: json["county"],
        postcode: json["postcode"],
        date: json["date"],
        time: json["time"],
        imgUrl: json["img_url"],
        createdAt: DateTime.parse(json["created_at"]),
        updatedAt: DateTime.parse(json["updated_at"]),
        userId: json["user_id"],
        images: List<Image>.from(json["images"].map((x) => Image.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "vs": vs,
        "is_home": isHome,
        "home_score": homeScore,
        "away_score": awayScore,
        "result": result,
        "description": description,
        "address_line_1": addressLine1,
        "address_line_2": addressLine2,
        "town_or_city": townOrCity,
        "county": county,
        "postcode": postcode,
        "date": date,
        "time": time,
        "img_url": imgUrl,
        "created_at": createdAt.toIso8601String(),
        "updated_at": updatedAt.toIso8601String(),
        "user_id": userId,
        "images": List<dynamic>.from(images.map((x) => x.toJson())),
      };
}

class Image {
  Image({
    required this.id,
    required this.resultId,
    required this.imgUrl,
    required this.caption,
    required this.notes,
    required this.createdAt,
    required this.updatedAt,
  });

  int id;
  int resultId;
  String imgUrl;
  dynamic caption;
  dynamic notes;
  DateTime createdAt;
  DateTime updatedAt;

  factory Image.fromJson(Map<String, dynamic> json) => Image(
        id: json["id"],
        resultId: json["result_id"],
        imgUrl: imageBaseWithout + json["img_url"],
        caption: json["caption"],
        notes: json["notes"],
        createdAt: DateTime.parse(json["created_at"]),
        updatedAt: DateTime.parse(json["updated_at"]),
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "result_id": resultId,
        "img_url": imgUrl,
        "caption": caption,
        "notes": notes,
        "created_at": createdAt.toIso8601String(),
        "updated_at": updatedAt.toIso8601String(),
      };
}
