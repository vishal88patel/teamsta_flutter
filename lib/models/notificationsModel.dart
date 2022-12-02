class NotificationsModel {
  NotificationsModel({
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
    required this.news,
    required this.fixtures,
  });

  int id;
  String clubName;
  String addressLine1;
  dynamic addressLine2;
  String townOrCity;
  String county;
  String postcode;
  int teamId;
  int userId;
  DateTime createdAt;
  DateTime updatedAt;
  List<News> news;
  List<Fixture> fixtures;

  factory NotificationsModel.fromJson(Map<String, dynamic> json) =>
      NotificationsModel(
        id: json["id"],
        clubName: json["club_name"],
        addressLine1: json["address_line_1"],
        addressLine2: json["address_line_2"],
        townOrCity: json["town_or_city"],
        county: json["county"],
        postcode: json["postcode"],
        teamId: json["team_id"],
        userId: json["user_id"],
        createdAt: DateTime.parse(json["created_at"]),
        updatedAt: DateTime.parse(json["updated_at"]),
        news: List<News>.from(json["news"].map((x) => News.fromJson(x))),
        fixtures: List<Fixture>.from(
            json["fixtures"].map((x) => Fixture.fromJson(x))),
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
        "news": List<dynamic>.from(news.map((x) => x.toJson())),
        "fixtures": List<dynamic>.from(fixtures.map((x) => x.toJson())),
      };
}

class Fixture {
  Fixture({
    required this.id,
    required this.vs,
    required this.isHome,
    required this.description,
    required this.addressLine1,
    required this.addressLine2,
    required this.townOrCity,
    required this.county,
    required this.postcode,
    required this.date,
    required this.time,
    required this.imgUrl,
    required this.userId,
    required this.createdAt,
    required this.updatedAt,
  });

  int id;
  String vs;
  int isHome;
  String description;
  String addressLine1;
  dynamic addressLine2;
  String townOrCity;
  String county;
  String postcode;
  String date;
  String time;
  dynamic imgUrl;
  int userId;
  DateTime createdAt;
  DateTime updatedAt;

  factory Fixture.fromJson(Map<String, dynamic> json) => Fixture(
        id: json["id"],
        vs: json["vs"],
        isHome: json["is_home"],
        description: json["description"],
        addressLine1: json["address_line_1"],
        addressLine2: json["address_line_2"],
        townOrCity: json["town_or_city"],
        county: json["county"],
        postcode: json["postcode"],
        date: json["date"],
        time: json["time"],
        imgUrl: json["img_url"],
        userId: json["user_id"],
        createdAt: DateTime.parse(json["created_at"]),
        updatedAt: DateTime.parse(json["updated_at"]),
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "vs": vs,
        "is_home": isHome,
        "description": description,
        "address_line_1": addressLine1,
        "address_line_2": addressLine2,
        "town_or_city": townOrCity,
        "county": county,
        "postcode": postcode,
        "date": date,
        "time": time,
        "img_url": imgUrl,
        "user_id": userId,
        "created_at": createdAt.toIso8601String(),
        "updated_at": updatedAt.toIso8601String(),
      };
}

class News {
  News({
    required this.id,
    required this.title,
    required this.description,
    required this.url,
    required this.imgUrl,
    required this.createdAt,
    required this.updatedAt,
    required this.userId,
  });

  int id;
  String title;
  String description;
  String url;
  dynamic imgUrl;
  DateTime createdAt;
  DateTime updatedAt;
  int userId;

  factory News.fromJson(Map<String, dynamic> json) => News(
        id: json["id"],
        title: json["title"],
        description: json["description"],
        url: json["url"] != null ? json["url"] : "",
        imgUrl: json["img_url"],
        createdAt: DateTime.parse(json["created_at"]),
        updatedAt: DateTime.parse(json["updated_at"]),
        userId: json["user_id"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "title": title,
        "description": description,
        "url": url,
        "img_url": imgUrl,
        "created_at": createdAt.toIso8601String(),
        "updated_at": updatedAt.toIso8601String(),
        "user_id": userId,
      };
}
