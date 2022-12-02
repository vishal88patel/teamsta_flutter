import 'package:teamsta/constants/export_constants.dart';

class NewsModel {
  NewsModel({
    required this.id,
    required this.title,
    required this.description,
    required this.url,
    required this.imgUrl,
    required this.createdAt,
    required this.updatedAt,
    required this.userId,
    required this.image,
  });

  int id;
  String title;
  String description;
  String url;
  dynamic imgUrl;
  DateTime createdAt;
  DateTime updatedAt;
  int userId;
  Image? image;

  factory NewsModel.fromJson(Map<String, dynamic> json) => NewsModel(
        id: json["id"],
        title: json["title"],
        description: json["description"],
        url: json["url"],
        imgUrl: json["img_url"],
        createdAt: DateTime.parse(json["created_at"]),
        updatedAt: DateTime.parse(json["updated_at"]),
        userId: json["user_id"],
        //TODO: this can be nullable. 
        // image can be nullabe

        image: json["image"] == null ? null : Image.fromJson(json["image"]),
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
        "image": image == null ? null : image!.toJson(),
      };
}

class Image {
  Image({
    required this.id,
    required this.newsId,
    required this.imgUrl,
    required this.caption,
    required this.notes,
    required this.createdAt,
    required this.updatedAt,
  });

  int id;
  int newsId;
  String imgUrl;
  dynamic caption;
  dynamic notes;
  DateTime createdAt;
  DateTime updatedAt;

  factory Image.fromJson(Map<String, dynamic> json) => Image(
        id: json["id"],
        newsId: json["news_id"],
        imgUrl:
            json["img_url"] != null ? imageBaseWithout + json["img_url"] : "",
        caption: json["caption"],
        notes: json["notes"],
        createdAt: DateTime.parse(json["created_at"]),
        updatedAt: DateTime.parse(json["updated_at"]),
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "news_id": newsId,
        "img_url": imgUrl,
        "caption": caption,
        "notes": notes,
        "created_at": createdAt.toIso8601String(),
        "updated_at": updatedAt.toIso8601String(),
      };
}
