import 'package:teamsta/constants/export_constants.dart';

class FixtureModel {
  FixtureModel({
    this.id,
    required this.vs,
    required this.description,
    required this.date,
    required this.time,
    required this.isHome,
    required this.images,
    required this.addressLine1,
    required this.addressLine2,
    required this.town,
    required this.county,
    required this.postcode,
  });
// testing
  int? id;
  String vs;
  String description;
  String date;
  String time;
  String addressLine1;
  String addressLine2;
  String town;
  String county;
  String postcode;
  List<FixtureImage> images;
  int isHome;

  factory FixtureModel.fromJson(Map<String, dynamic> json) {
    List<String> urls = [];
    if (json.containsKey("images")) {
      if (json['images'] != null) {
        for (var image in json['images']) {
          if (image.containsKey("img_url")) {
            if (image["img_url"] != null) {
              urls.add(image["img_url"]);
            }
          }
        }
      }
    }

    return FixtureModel(
      id: json["id"],
      vs: json["vs"],
      description: json["description"],
      date: json["date"],
      time: json["time"],
      isHome: json["is_home"],
      addressLine1: json["address_line_1"],
      // address line 2 can be nullable
      addressLine2: json["address_line_2"] ?? "",
      town: json["town_or_city"],
      county: json["county"],
      postcode: json["postcode"],
      images: List<FixtureImage>.from(
        json["images"].map(
          (x) => FixtureImage.fromJson(x),
        ),
      ),
    );
  }

  Map<String, dynamic> toJson() => {
        "id": id,
        "vs": vs,
        "description": description,
        "date": date,
        "time": time,
        'addressLine1': addressLine1,
        'addressLine2': addressLine2,
        'town': town,
        'county': county,
        'postcode': postcode,
        "image": images,
        "is_home": isHome,
      };
}

class FixtureImage {
  FixtureImage({
    required this.id,
    required this.imgUrl,
  });

  final int? id;
  final String? imgUrl;

  factory FixtureImage.fromJson(Map<String, dynamic> json) => FixtureImage(
        id: json["id"],
        imgUrl: imageBaseWithout + json["img_url"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "img_url": imgUrl,
      };
}
