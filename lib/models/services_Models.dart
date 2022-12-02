import 'package:teamsta/widgets/getLatLng.dart';
import 'package:teamsta/widgets/getLocation.dart';

class TeamServicesModel {
  TeamServicesModel({
    required this.id,
    required this.title,
    required this.description,
    required this.sportOrActivity,
    required this.age,
    required this.abilityLevel,
    required this.sex,
    required this.repeatingDay,
    required this.date,
    required this.time,
    required this.addressLine1,
    required this.addressLine2,
    required this.cityOrTown,
    required this.county,
    required this.postcode,
    required this.createdAt,
    required this.updatedAt,
    required this.userId,
  });

  int id;
  String title;
  String description;
  String sportOrActivity;
  String age;
  String abilityLevel;
  String sex;
  String repeatingDay;
  String date;
  String time;
  String addressLine1;
  String addressLine2;
  String cityOrTown;
  String county;
  String postcode;
  DateTime createdAt;
  DateTime updatedAt;
  int userId;
  double? distance;

  getTheDistance() async {
    var response = await GetLatLng().getCoords(addressLine1 +
        ',' +
        addressLine2 +
        ',' +
        cityOrTown +
        ',' +
        county +
        "," +
        postcode);
    if (response != null) {
      distance = GetLocation()
          .calculateDistance(response.latitude, response.longitude);
    }

    
  }

  factory TeamServicesModel.fromJson(Map<String, dynamic> json) =>
      TeamServicesModel(
        id: json["id"],
        title: json["title"],
        description: json["description"],
        sportOrActivity: json["sport_or_activity"],
        age: json["age"],
        abilityLevel: json["ability_level"],
        sex: json["sex"],
        repeatingDay: json["repeating_day"],
        date: json["date"],
        time: json["time"],
        addressLine1: json["address_line_1"],
        addressLine2: json["address_line_2"] ?? '',
        cityOrTown: json["city_or_town"],
        county: json["county"],
        postcode: json["postcode"],
        createdAt: DateTime.parse(json["created_at"]),
        updatedAt: DateTime.parse(json["updated_at"]),
        userId: json["user_id"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "title": title,
        "description": description,
        "sport_or_activity": sportOrActivity,
        "age": age,
        "ability_level": abilityLevel,
        "sex": sex,
        "repeating_day": repeatingDay,
        "date": date,
        "time": time,
        "address_line_1": addressLine1,
        "address_line_2": addressLine2,
        "city_or_town": cityOrTown,
        "county": county,
        "postcode": postcode,
        "created_at": createdAt.toIso8601String(),
        "updated_at": updatedAt.toIso8601String(),
        "user_id": userId,
      };
}

class UserServicesModel {
  UserServicesModel({
    required this.id,
    required this.title,
    required this.description,
    required this.sportOrActivity,
    required this.age,
    required this.abilityLevel,
    required this.sex,
    required this.repeatingDay,
    required this.date,
    required this.time,
    required this.createdAt,
    required this.updatedAt,
    required this.userId,
    required this.address_line_1,
    required this.address_line_2,
    required this.town_or_city,
    required this.county,
    required this.postCode,
  });

  int id;
  String title;
  String description;
  String sportOrActivity;
  String age;
  String abilityLevel;
  String sex;
  String repeatingDay;
  String date;
  String time;
  DateTime createdAt;
  DateTime updatedAt;
  int userId;
  String address_line_1;
  String address_line_2;
  String town_or_city;
  String county;
  String postCode;
  double? distance;

  getTheDistance() async {
    var response = await GetLatLng().getCoords(address_line_1 +
        ',' +
        address_line_2 +
        ',' +
        town_or_city +
        ',' +
        county +
        "," +
        postCode);
    if (response != null) {
      distance = GetLocation()
          .calculateDistance(response.latitude, response.longitude);
    }
  }

  factory UserServicesModel.fromJson(Map<String, dynamic> json) =>
      UserServicesModel(
        id: json["id"],
        title: json["title"],
        description: json["description"],
        sportOrActivity: json["sport_or_activity"],
        age: json["age"],
        abilityLevel: json["ability_level"],
        sex: json["sex"],
        repeatingDay: json["repeating_day"],
        date: json["date"] != null ? json["date"] : "N/A",
        time: json["time"] != null ? json["time"] : "N/A",
        createdAt: DateTime.parse(json["created_at"]),
        updatedAt: DateTime.parse(json["updated_at"]),
        userId: json["user_id"],
        address_line_1: json["address_line_1"],
        address_line_2:
            json["address_line_2"] != null ? json["address_line_2"] : "",
        town_or_city: json["city_or_town"],
        county: json["county"],
        postCode: json["postcode"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "title": title,
        "description": description,
        "sport_or_activity": sportOrActivity,
        "age": age,
        "ability_level": abilityLevel,
        "sex": sex,
        "repeating_day": repeatingDay,
        "date": date,
        "time": time,
        "created_at": createdAt.toIso8601String(),
        "updated_at": updatedAt.toIso8601String(),
        "user_id": userId,
      };
}
