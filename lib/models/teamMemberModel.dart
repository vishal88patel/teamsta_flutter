import 'package:teamsta/constants/export_constants.dart';

class TeamMemberModel {
  TeamMemberModel({
    required this.name,
    required this.role,
    required this.images,
    required this.bio,
  });

  String name;
  String role;
  String images;
  String bio;

  factory TeamMemberModel.fromJson(Map<String, dynamic> json) {
    //TODO: don't leave this here for production!!!!

    var tempImage =
        "https://imgs.search.brave.com/hjb-1IAnom_kWER5bRt55lPTpQvE3Wbh0kZC38e2T_A/rs:fit:450:150:1/g:ce/aHR0cHM6Ly93d3cu/Y3JlYXRlYW5ldC5j/by51ay93cC1jb250/ZW50L3VwbG9hZHMv/MjAxOS8wMS9sb2dv/Mi5qcGc_aXMtcGVu/ZGluZy1sb2FkPTE";
    if (json.containsKey("image")) {
      if (json["image"] != null) {
        if (json.containsKey("img_url")) {
          if (json['image']["img_url"] != null) {
            tempImage = imageBaseWithout + json['image']["img_url"];
          }
        }
      }
    }

    return TeamMemberModel(
      name: json["name"],
      role: json["role"],
      // image can be nullable
      images: tempImage,
      bio: json["bio"],
    );
  }

  Map<String, dynamic> toJson() => {
        "name": name,
        "role": role,
        "imageUrl": images,
        "bio": bio,
      };
}
