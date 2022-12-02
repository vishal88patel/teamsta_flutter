class ChatModel {
  ChatModel({
    required this.name,
    required this.id,
    required this.conversation,
  });

  String name;
  int id;
  List conversation;

  factory ChatModel.fromJson(Map<String, dynamic> json) => ChatModel(
        name: json["name"],
        id: json["id"],
        conversation:
            json["conversations"] == null ? [] : json["conversations"],
      );

  Map<String, dynamic> toJson() => {
        "name": name,
        "id": id,
        "conversation": conversation,
      };
}

class MessageModel {
  MessageModel({required this.message});

  String message;

  factory MessageModel.fromJson(Map<String, dynamic> json) => MessageModel(
        message: json["message"],
      );

  Map<String, dynamic> toJson() => {
        "message": message,
      };
}
