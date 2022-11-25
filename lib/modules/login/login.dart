import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:social_app/helper/cache/cache_helper.dart';
import 'package:social_app/layout/social_app_layout.dart';

import '../../constans/components.dart';
import '../register/register.dart';
import 'SocialApp_cupit_login/SocialAppCubit.dart';
import 'SocialApp_cupit_login/SocialAppStates.dart';

class LoginScreen extends StatelessWidget {
  var formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<SocialAppCubit, SocialAppStates>(
      listener: (context, state) {
        if (state is LoginFailed) {
          ScaffoldMessenger.of(context).showSnackBar(
              snackbar(massage: state.message, color: Colors.red));
        }
        if (state is LoginSucces) {
          CacheHelper.setData(key: 'uId', value: state.uId).then((value) {
            navigatetOff(context, widget: HomeLayout());
          }).catchError((e) {
            print('$e from login listner');
          });
        }
      },
      builder: (context, state) {
        SocialAppCubit c = SocialAppCubit.get(context);
        return Scaffold(
          body: Padding(
            padding: const EdgeInsets.all(20.0),
            child: Center(
              child: SingleChildScrollView(
                child: Form(
                  key: formKey,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Login',
                        style: Theme.of(context)
                            .textTheme
                            .headline3!
                            .copyWith(color: Colors.deepOrange, fontSize: 35.0),
                      ),
                      const SizedBox(
                        height: 20,
                      ),
                      Text(
                        'login to communicate with your friends',
                        style: Theme.of(context).textTheme.headline5!.copyWith(
                              color: Colors.grey,
                            ),
                      ),
                      const SizedBox(
                        height: 20.0,
                      ),
                      textInput(
                        onSubmit: (value) {
                          if (formKey.currentState!.validate()) {
                            c.loginUser(
                              context,
                              email: c.emailController.text,
                              password: c.passController.text,
                            );
                          }
                        },
                        inputLabal: 'Email Address',
                        type: TextInputType.emailAddress,
                        isSave: false,
                        preffix: Icons.email_outlined,
                        validate: (value) {
                          if (value.isEmpty) {
                            return 'the email musn\'t be empty';
                          }
                        },
                        inputControler: c.emailController,
                      ),
                      const SizedBox(
                        height: 20.0,
                      ),
                      textInput(
                        onSubmit: (value) {
                          if (formKey.currentState!.validate()) {
                            c.loginUser(
                              context,
                              email: c.emailController.text,
                              password: c.passController.text,
                            );
                          }
                        },
                        suffix: c.suffixIconFromCubit,
                        inputLabal: 'Password',
                        type: TextInputType.visiblePassword,
                        isSave: c.isSecure,
                        preffix: Icons.lock_outline,
                        validate: (value) {
                          if (value.isEmpty) {
                            return 'the password musn\'t be empty';
                          }
                        },
                        inputControler: c.passController,
                        onSuffixPressed: () {
                          c.changeMode();
                        },
                      ),
                      const SizedBox(
                        height: 30.0,
                      ),
                      Container(
                        decoration: const BoxDecoration(
                          borderRadius: BorderRadius.all(Radius.circular(21.0)),
                        ),
                        clipBehavior: Clip.antiAliasWithSaveLayer,
                        height: 50.0,
                        width: double.infinity,
                        child: state is LoadingLoginState
                            ? const Center(
                                child: CircularProgressIndicator(),
                              )
                            : MaterialButton(
                                onPressed: () {
                                  if (formKey.currentState!.validate()) {
                                    c.loginUser(
                                      context,
                                      email: c.emailController.text,
                                      password: c.passController.text,
                                    );
                                  }
                                },
                                child: const Text(
                                  'Login',
                                  style: TextStyle(
                                    color: Colors.white,
                                  ),
                                ),
                                color: Colors.deepOrange,
                              ),
                      ),
                      Row(
                        children: [
                          Text('Don\'t have an account '),
                          TextButton(
                            onPressed: () {
                              navigatetTo(context, widget: RegisterScreen());
                            },
                            child: Text('REGISTER'),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ),
        );
      },
    );
  }
}
