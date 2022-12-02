class MessageModel {
    MessageModel({
        required this.id,
        required this.name,
        required this.createdAt,
        required this.updatedAt,
        required this.conversations,
    });

    final int id;
    final String name;
    final DateTime createdAt;
    final DateTime updatedAt;
    final List<dynamic> conversations;

    factory MessageModel.fromJson(Map<String, dynamic> json) => MessageModel(
        id: json["id"],
        name: json["name"],
        createdAt: DateTime.parse(json["created_at"]),
        updatedAt: DateTime.parse(json["updated_at"]),
        conversations: List<dynamic>.from(json["conversations"].map((x) => x)),
    );

    Map<String, dynamic> toJson() => {
        "id": id,
        "name": name,
        "created_at": createdAt.toIso8601String(),
        "updated_at": updatedAt.toIso8601String(),
        "conversations": List<dynamic>.from(conversations.map((x) => x)),
    };
}
