class PostModel {
  late String name;
  late String uId;
  late String image;
  late String dateTime;
  late String postImage;
  late String text;

  PostModel({
    required this.uId,
    required this.name,
    required this.image,
    required this.dateTime,
    required this.postImage,
    required this.text,
  });

  PostModel.fromJson(Map<String, dynamic>? json) {
    name = json!['name'];
    image = json['image'];
    uId = json['uId'];
    dateTime = json['dateTime'];
    postImage = json['postImage'];
    text = json['text'];
  }

  Map<String, dynamic> toJson() {
    return {
      'name': name,
      'uId': uId,
      'image': image,
      'dateTime': dateTime,
      'postImage': postImage,
      'text': text,
    };
  }
}
