class MessageModel {
  late String content;
  late String dateTime;
  late String senderId;
  late String recieverId;

  MessageModel(
      {required this.content,
      required this.dateTime,
      required this.recieverId,
      required this.senderId});

  MessageModel.fromJson(Map<String, dynamic> json) {
    content = json['content'];
    dateTime = json['dateTime'];
    senderId = json['senderId'];
    recieverId = json['recieverId'];
  }

  Map<String, dynamic> toMap() => {
    'content':content,
    'dateTime':dateTime,
    'senderId':senderId,
    'recieverId':recieverId,
  };
}
