class CreateUserModel {
  late String name;
  late String email;
  late String phone;
  late String uId;
  late String bio;
  late String image;
  late String cover;
  late bool isEmailVerified;

  CreateUserModel(
      {required this.uId,
      required this.email,
      required this.name,
      required this.phone,
      required this.bio,
      required this.image,
      required this.cover,
      required this.isEmailVerified});

  CreateUserModel.fromJson(Map<String, dynamic>? json) {
    email = json!['email'];
    name = json['name'];
    phone = json['phone'];
    bio = json['bio'];
    image = json['image'];
    cover = json['cover'];
    uId = json['uId'];
    isEmailVerified = json['isEmailVerified'];
  }

  Map<String, dynamic> toJson() {
    return {
      'email': email,
      'name': name,
      'phone': phone,
      'uId': uId,
      'bio': bio,
      'image': image,
      'cover': cover,
      'isEmailVerified' : isEmailVerified
    };
  }
}
