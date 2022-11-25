import 'dart:developer';

import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:social_app/helper/cache/cache_helper.dart';
import 'package:social_app/themes/dark_theme.dart';
import 'package:social_app/themes/light_theme.dart';
import 'constans/components.dart';
import 'constans/constant.dart';
import 'cubit/cubit.dart';
import 'layout/social_app_layout.dart';
import 'modules/login/SocialApp_cupit_login/SocialAppCubit.dart';
import 'modules/login/SocialApp_cupit_login/SocialAppStates.dart';
import 'modules/login/login.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  await CacheHelper.int();
  uId = CacheHelper.getCached(key: 'uId');
  log('$uId from main');
  Widget? widget;
  if (uId == null) {
    widget = LoginScreen();
  } else {
    widget = HomeLayout();
  }
  BlocOverrides.runZoned(
    () {
      runApp(MyApp(widget!));
    },
    blocObserver: MyBlocObserver(),
  );
}

class MyApp extends StatelessWidget {
  final Widget startWidget;
  MyApp(this.startWidget);

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(
          create: (BuildContext context) => SocialAppCubit(),
        ),
                BlocProvider(
          create: (BuildContext context) => SocialAppCubitMain()..getUserData()..getPosts(),
        ),
      ],
      child: BlocConsumer<SocialAppCubit, SocialAppStates>(
        listener: (context, state) {},
        builder: (context, state) {
          return MaterialApp(
            theme: lightTheme(),
            darkTheme: darkTheme(),
            themeMode: ThemeMode.light,
            debugShowCheckedModeBanner: false,
            home: startWidget,
          );
        },
      ),
    );
  }
}
