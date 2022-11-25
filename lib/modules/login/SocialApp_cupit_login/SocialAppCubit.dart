import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:social_app/helper/cache/cache_helper.dart';
import 'package:social_app/models/create_user_model.dart';

import '../../../constans/constant.dart';
import 'SocialAppStates.dart';

class SocialAppCubit extends Cubit<SocialAppStates> {
  SocialAppCubit() : super(SocialAppInitialState());

  static SocialAppCubit get(context) => BlocProvider.of(context);
  TextEditingController passController = TextEditingController();
  TextEditingController emailController = TextEditingController();
  bool isSecure = true;
  IconData suffixIconFromCubit = Icons.visibility;

  void changeMode() {
    isSecure = !isSecure;
    isSecure == true
        ? suffixIconFromCubit = Icons.visibility
        : suffixIconFromCubit = Icons.visibility_off_rounded;
    emit(ChangeMode());
  }

  CreateUserModel? model;
  void loginUser(context, {required String email, required password}) {
    emit(LoadingLoginState());
    FirebaseAuth.instance
        .signInWithEmailAndPassword(email: email, password: password)
        .then((value) {
      print(value.user!.uid);
      print(value.user!.email);
      emit(LoginSucces(value.user!.uid));
    }).catchError((e) {
      print(e.toString());
      emit(LoginFailed(e.toString()));
    });
  }
}
