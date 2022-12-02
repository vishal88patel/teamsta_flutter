class MembersModel {
  MembersModel({
    required this.name,
    required this.bio,
    required this.imgUrl,
    required this.role,
    required this.id,
  });

  String name;
  String bio;
  String role;
  String imgUrl;
  int id;

  factory MembersModel.fromJson(Map<String, dynamic> json) => MembersModel(
        name: json["name"],
        bio: json["bio"],
        imgUrl: json['image']["img_url"],
        role: json["role"],
        id: json["id"],
      );

  Map<String, dynamic> toJson() => {
        "name": name,
        "bio": bio,
        "img_url": imgUrl,
        "role": role,
        "id": id,
      };
}
