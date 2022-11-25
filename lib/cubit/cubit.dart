import 'dart:developer';
import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:image_picker/image_picker.dart';
import 'package:social_app/constans/constant.dart';
import 'package:social_app/helper/cache/cache_helper.dart';
import 'package:social_app/models/create_user_model.dart';
import 'package:social_app/models/message_model.dart';
import 'package:social_app/models/post_model.dart';
import 'package:social_app/modules/chats/chats_screen.dart';
import 'package:social_app/modules/feeds/feeds_screen.dart';
import 'package:social_app/modules/settings/settings_screen.dart';
import 'package:social_app/modules/users/users_screen.dart';
import 'states.dart';
import 'package:firebase_storage/firebase_storage.dart' as firebase_storage;

class SocialAppCubitMain extends Cubit<SocialAppStatesMain> {
  SocialAppCubitMain() : super(ShopAppMainCubitInitialState());
  static SocialAppCubitMain get(context) => BlocProvider.of(context);

  CreateUserModel? model;
  void getUserData() {
    uId = CacheHelper.getCached(key: 'uId');
    emit(ShopAppMainCubitGetUserDataLoadingState());
    FirebaseFirestore.instance.collection('users').doc(uId).get().then((value) {
      model = CreateUserModel.fromJson(value.data());
      emit(ShopAppMainCubitGetUserDataSuccesState(model!.isEmailVerified));
    }).catchError((e) {
      print('$e from get user data');
      emit(ShopAppMainCubitGetUserDataFailedState());
    });
  }

  List<Widget> screens = [
    FeedScreen(),
    ChatScreen(),
    UsersScreen(),
    SettingsScreen(),
  ];

  List<String> titles = ['Feeds', 'Chats', 'Users', 'Settings'];

  int currentIndex = 0;
  void changeIndex(int index) {
    if (index == 1) {
      getAllUsers();
    }
    currentIndex = index;
    emit(ChangeNavBarState());
  }

  File? profileImage;
  var picker = ImagePicker();
  Future<void> imagePick() async {
    await picker.pickImage(source: ImageSource.gallery).then((value) {
      profileImage = File(value!.path);
      emit(ImagePickerProfileSucces());
    }).catchError((e) {
      print('$e from image picker');
      emit(ImagePickerProfileFailed());
    });
  }

  File? coverImage;
  Future<void> coverPick() async {
    await picker.pickImage(source: ImageSource.gallery).then((value) {
      coverImage = File(value!.path);
      emit(ImagePickerCoverSucces());
    }).catchError((e) {
      print('$e from image picker');
      emit(ImagePickerCoverFailed());
    });
  }

  void uploudProfileImage({
    required String name,
    required String bio,
    required String phone,
  }) {
    firebase_storage.FirebaseStorage.instance
        .ref()
        .child('users/${Uri.file(profileImage!.path).pathSegments.last}')
        .putFile(profileImage!)
        .then((value) {
      value.ref.getDownloadURL().then((value) {
        updateUser(name: name, bio: bio, phone: phone, profileImage: value);
        emit(UploadProfileImageSuccessState());
      }).catchError((e) {
        emit(UploadProfileImageErrorState());
      });
    }).catchError((e) {
      emit(UploadProfileImageErrorState());
    });
  }

  void uploudCoverImage({
    required String name,
    required String bio,
    required String phone,
  }) {
    firebase_storage.FirebaseStorage.instance
        .ref()
        .child('users/${Uri.file(coverImage!.path).pathSegments.last}')
        .putFile(coverImage!)
        .then((value) {
      value.ref.getDownloadURL().then((value) {
        updateUser(name: name, bio: bio, phone: phone, cover: value);
        emit(UploadCoverImageSuccessState());
      }).catchError((e) {
        emit(UploadCoverImageErrorState());
      });
    }).catchError((e) {
      emit(UploadCoverImageErrorState());
    });
  }

  // void updateUserData({
  //   required String name,
  //   required String bio,
  //   required String phone,
  // }) {
  //   if (coverImage != null) {
  //     uploudCoverImage();
  //   } else if (profileImage != null) {
  //     uploudProfileImage();
  //   } else if (coverImage != null && profileImage != null) {
  //     uploudCoverImage();
  //     uploudProfileImage();
  //   } else {
  //     updateUser(name: name, bio: bio, phone: phone);
  //   }
  // }

  void updateUser({
    required String name,
    required String bio,
    required String phone,
    String? cover,
    String? profileImage,
  }) {
    CreateUserModel updateModel = CreateUserModel(
        uId: model!.uId,
        email: model!.email,
        name: name,
        phone: phone,
        bio: bio,
        image: profileImage ?? model!.image,
        cover: cover ?? model!.cover,
        isEmailVerified: model!.isEmailVerified);
    FirebaseFirestore.instance
        .collection('users')
        .doc(model!.uId)
        .update(updateModel.toJson())
        .then((value) {
      getUserData();
    }).catchError((e) {
      emit(UpdateUserDataErrorState());
    });
  }

  File? postImage;
  Future<void> getPostImage() async {
    await picker.pickImage(source: ImageSource.gallery).then((value) {
      postImage = File(value!.path);
      emit(ImagePickerPostSucces());
    }).catchError((e) {
      print('$e from pick post image');
      emit(ImagePickerPostFailed());
    });
  }

  PostModel? postModel;

  void uploadPostImage({
    required String dateTime,
    required String text,
  }) {
    emit(UploadPostImageLoadingState());
    firebase_storage.FirebaseStorage.instance
        .ref()
        .child('posts/${Uri.file(postImage!.path).pathSegments.last}')
        .putFile(postImage!)
        .then((value) {
      value.ref.getDownloadURL().then((value) {
        createPost(dateTime: dateTime, text: text, postImage: value);
        emit(CreatePostSuccessState());
      }).catchError((e) {
        emit(CreatePostErrorState());
      });
    }).catchError((e) {
      emit(CreatePostErrorState());
    });
  }

  void createPost({
    required String dateTime,
    required String text,
    String? postImage,
  }) {
    emit(CreatePostLoadingState());
    postModel = PostModel(
        dateTime: dateTime,
        image: model!.image,
        name: model!.name,
        postImage: postImage ?? '',
        text: text,
        uId: model!.uId);
    FirebaseFirestore.instance
        .collection('posts')
        .add(postModel!.toJson())
        .then((value) {
      emit(CreatePostSuccessState());
    }).catchError((e) {
      emit(CreatePostErrorState());
    });
  }

  void removePostImage() {
    postImage = null;
    emit(RemovePostImageState());
  }

  List<PostModel> posts = [];
  List<String> postsId = [];
  List<int> likes = [];
  void getPosts() {
    emit(GetPostsLoadingState());
    FirebaseFirestore.instance.collection('posts').get().then((value) {
      value.docs.forEach((element) {
        element.reference.collection('likes').get().then((value) {
          posts.add(PostModel.fromJson(element.data()));
          postsId.add(element.id);
          likes.add(value.docs.length);
          emit(GetLikedPostsSuccessState());
        }).catchError((e) {
          log(e.toString());
        });
        emit(GetLikedPostsSuccessState());
      });
    }).catchError((e) {
      emit(GetPostsErrorState(e.toString()));
      log(e.toString());
    });
  }

  void likePost(String id) {
    FirebaseFirestore.instance
        .collection('posts')
        .doc(id)
        .collection('likes')
        .doc(model!.uId)
        .set({'liked': true}).then((value) {
      emit(LikePostSuccessState());
    }).catchError((e) {
      emit(LikePostErrorState(e.toString()));
    });
  }

  List<CreateUserModel> users = [];

  void getAllUsers() {
    emit(GetAllUsersLoadingState());
    if (users.isEmpty) {
      FirebaseFirestore.instance.collection('users').get().then((value) {
        value.docs.forEach((element) {
          if (element.data()['uId'] != model!.uId)
            users.add(CreateUserModel.fromJson(element.data()));
        });
        emit(GetAllUsersSuccessState());
      }).catchError((e) {
        emit(GetAllUsersErrorState(e.toString()));
      });
    }
  }

  void sendMessage(
      {required String content,
      required String dateTime,
      required recieverId}) {
    MessageModel messageModel = MessageModel(
        content: content,
        dateTime: dateTime,
        recieverId: recieverId,
        senderId: model!.uId);
    FirebaseFirestore.instance
        .collection('users')
        .doc(model!.uId)
        .collection('chats')
        .doc(recieverId)
        .collection('messages')
        .add(messageModel.toMap())
        .then((value) {
      emit(SendMessageSuccessState());
    }).catchError((e) {
      emit(SendMessageErrorState());
    });
    // sent receiver message
    FirebaseFirestore.instance
        .collection('users')
        .doc(recieverId)
        .collection('chats')
        .doc(model!.uId)
        .collection('messages')
        .add(messageModel.toMap())
        .then((value) {
      emit(SendMessageSuccessState());
    }).catchError((e) {
      emit(SendMessageErrorState());
    });
  }

  List<MessageModel> messages = [];
  void getmessages({required String recieverId}) {
    FirebaseFirestore.instance
        .collection('users')
        .doc(model!.uId)
        .collection('chats')
        .doc(recieverId)
        .collection('messages')
        .orderBy('dateTime')
        .snapshots()
        .listen((event) {
      messages = [];
      event.docs.forEach((element) {
        messages.add(MessageModel.fromJson(element.data()));
      });
      emit(GetMessageSuccessState());
    });
  }
}
