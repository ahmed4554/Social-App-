import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:social_app/helper/cache/cache_helper.dart';
import 'package:social_app/models/create_user_model.dart';
import 'register_states.dart';
import 'package:firebase_auth/firebase_auth.dart';

class RegisterCubit extends Cubit<RegisterStates> {
  RegisterCubit() : super(RegisterInitialState());

  static RegisterCubit get(context) => BlocProvider.of(context);

  var nameController = TextEditingController();
  var emailController = TextEditingController();
  var passController = TextEditingController();
  var phoneController = TextEditingController();

  void registerUser(
    context, {
    required String name,
    required String email,
    required String password,
    required String phone,
  }) {
    emit(RegisterLoading());
    FirebaseAuth.instance
        .createUserWithEmailAndPassword(email: email, password: password)
        .then((value) {
      saveUserData(
          uId: value.user!.uid,
          phone: phone,
          name: name,
          email: email,
          isEmailVerfied: false);
    }).catchError((e) {
      print(e.toString());
      emit(RegisterFailed());
    });
  }

  void saveUserData({
    required String name,
    required String email,
    required String phone,
    required String uId,
    required bool isEmailVerfied,
  }) {
    emit(CreateUserLoading());
    CreateUserModel model = CreateUserModel(
        email: email,
        name: name,
        phone: phone,
        bio: 'Write your bio ...',
        image:
            'https://www.samma3a.com/tech/en/wp-content/uploads/sites/2/2020/06/laptop-wallpaper-1280x800.jpg',
        cover:
            'https://assets.entrepreneur.com/content/3x2/2000/20150225224437-computer.jpeg',
        uId: uId,
        isEmailVerified: isEmailVerfied);
    FirebaseFirestore.instance
        .collection('users')
        .doc(uId)
        .set(model.toJson())
        .then((value) {
      CacheHelper.setBoolen(
          key: 'isEmailVerified', value: model.isEmailVerified);
      CacheHelper.setData(key: 'uId', value: uId);
      //     .then((value) {})
      //     .catchError((e) {
      //   print('$e from cahce helper setting');
      // });
      emit(CreateUserSuccess(uId));
    }).catchError((e) {
      print(e.toString());
      emit(CreateUserFailed(e.toString()));
    });
  }

  bool isSecure = true;
  IconData suffixIconFromCubit = Icons.visibility;

  void changeMode() {
    isSecure = !isSecure;
    isSecure == true
        ? suffixIconFromCubit = Icons.visibility
        : suffixIconFromCubit = Icons.visibility_off_rounded;
    emit(ChangeModeRegister());
  }
}
