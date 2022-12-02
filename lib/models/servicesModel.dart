class ServicesModel {
  ServicesModel({
    required this.id,
    required this.description,
    required this.title,
    required this.sport_or_activity,
    required this.age,
    required this.ability,
    required this.sex,
    required this.repeating_day,
    required this.date,
    required this.time,
    required this.addressLineOne,
    required this.addressLineTwo,
    required this.city_or_town,
    required this.county,
    required this.postcode,
    required this.user_id,
  });

  String title;
  String description;
  String sport_or_activity;
  String age;
  String ability;
  String sex;
  String repeating_day;
  String date;
  String time;
  int id;
  String addressLineOne;
  String addressLineTwo;
  String city_or_town;
  String county;
  String postcode;
  int user_id;

  factory ServicesModel.fromJson(Map<String, dynamic> json) => ServicesModel(
        title: json['title'],
        description: json['description'],
        sport_or_activity: json['sport_or_activity'],
        age: json['age'],
        ability: json.containsKey('ability_level') ? json['ability_level'] : "",
        sex: json['sex'],
        repeating_day: json['repeating_day'],
        date: json["date"] != null? json["date"] : "",
        time: json["time"] != null? json["time"] : "",
        id: json['id'],
        addressLineOne: json['address_line_1'],
        addressLineTwo:
            json['address_line_2'] != null ? json['address_line_2'] : "",
        city_or_town: json['city_or_town'],
        county: json['county'],
        postcode: json['postcode'],
        user_id: json['user_id'],
      );

  Map<String, dynamic> toJson() => {
        "title": title,
        "description": description,
        "sport_or_activity": sport_or_activity,
        "age": age,
        "sex": sex,
        "repeating_day": repeating_day,
        "date": date,
        "time": time,
        "ability": ability,
      };
}
