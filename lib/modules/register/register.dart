import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:social_app/layout/social_app_layout.dart';

import '../../constans/components.dart';
import 'cubit_register/cubit_register.dart';
import 'cubit_register/register_states.dart';
class RegisterScreen extends StatelessWidget {
  RegisterScreen({Key? key}) : super(key: key);
  var formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => RegisterCubit(),
      child: BlocConsumer<RegisterCubit, RegisterStates>(
        listener: (context, state) {
          if (state is RegisterFailed) {
          }
          if(state is CreateUserSuccess){
            navigatetOff(context, widget: HomeLayout());
          }
          if(state is CreateUserFailed){
            ScaffoldMessenger.of(context).showSnackBar(snackbar(massage: state.message, color: Colors.red));
          }
        },
        builder: (context, state) {
          RegisterCubit c = RegisterCubit.get(context);
          return Scaffold(
            body: Padding(
              padding: const EdgeInsets.all(20.0),
              child: Center(
                child: SingleChildScrollView(
                  child: Form(
                    key: formKey,
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.stretch,
                      children: [
                        Text(
                          'REGISTER',
                          style: Theme.of(context)
                              .textTheme
                              .headline3!
                              .copyWith(
                                  color: Colors.deepOrange, fontSize: 35.0),
                        ),
                        const SizedBox(height: 20,),
                        Text(
                          'Register to communicate with your friends',
                          style:
                              Theme.of(context).textTheme.headline6!.copyWith(
                                    color: Colors.grey,
                                  ),
                        ),
                        SizedBox(
                          height: 20.0,
                        ),
                        textInput(
                          onSubmit: (value) {},
                          inputLabal: 'User Name',
                          type: TextInputType.emailAddress,
                          isSave: false,
                          preffix: Icons.person,
                          validate: (value) {
                            if (value.isEmpty) {
                              return 'the name musn\'t be empty';
                            }
                          },
                          inputControler: c.nameController,
                        ),
                        SizedBox(
                          height: 20.0,
                        ),
                        textInput(
                          onSubmit: (value) {},
                          inputLabal: 'Email',
                          type: TextInputType.emailAddress,
                          isSave: false,
                          preffix: Icons.email,
                          validate: (value) {
                            if (value.isEmpty) {
                              return 'the Email musn\'t be empty';
                            }
                          },
                          inputControler: c.emailController,
                        ),
                        SizedBox(
                          height: 20.0,
                        ),
                        textInput(
                          onSubmit: (value) {},
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
                          height: 20.0,
                        ),
                        textInput(
                          onSubmit: (value) {},
                          inputLabal: 'Phone',
                          type: TextInputType.phone,
                          isSave: false,
                          preffix: Icons.phone,
                          validate: (value) {
                            if (value.isEmpty) {
                              return 'the Phone musn\'t be empty';
                            }
                          },
                          inputControler: c.phoneController,
                        ),
                        const SizedBox(
                          height: 20.0,
                        ),
                        TextButton(
                          style: TextButton.styleFrom(
                              padding: const EdgeInsets.symmetric(vertical: 15),
                              primary: Colors.white,
                              backgroundColor: Colors.deepOrange),
                          onPressed: () {
                            if (formKey.currentState!.validate()) {
                              c.registerUser(context,
                                  name: c.nameController.text,
                                  email: c.emailController.text,
                                  password: c.passController.text,
                                  phone: c.phoneController.text);
                            }
                          },
                          child: const Text('Register'),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}
