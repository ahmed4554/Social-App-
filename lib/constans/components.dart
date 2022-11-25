import 'dart:ui';

import 'package:bloc/bloc.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:social_app/cubit/cubit.dart';
import 'package:social_app/models/post_model.dart';

class MyBlocObserver extends BlocObserver {
  @override
  void onCreate(BlocBase bloc) {
    super.onCreate(bloc);
    print('onCreate -- ${bloc.runtimeType}');
  }

  @override
  void onChange(BlocBase bloc, Change change) {
    super.onChange(bloc, change);
    print('onChange -- ${bloc.runtimeType}, $change');
  }

  @override
  void onError(BlocBase bloc, Object error, StackTrace stackTrace) {
    print('onError -- ${bloc.runtimeType}, $error');
    super.onError(bloc, error, stackTrace);
  }

  @override
  void onClose(BlocBase bloc) {
    super.onClose(bloc);
    print('onClose -- ${bloc.runtimeType}');
  }
}

Widget textInput(
    {inputControler,
    required String inputLabal,
    required TextInputType type,
    required bool isSave,
    required IconData preffix,
    IconData? suffix,
    required dynamic validate,
    VoidCallback? onSuffixPressed,
    change,
    dynamic onSubmit}) {
  return TextFormField(
    controller: inputControler,
    decoration: InputDecoration(
      border: OutlineInputBorder(),
      label: Text(inputLabal),
      prefixIcon: Icon(preffix),
      suffixIcon: IconButton(
        onPressed: onSuffixPressed,
        icon: Icon(suffix),
      ),
    ),
    keyboardType: type,
    obscureText: isSave,
    validator: validate,
    onChanged: change,
    onFieldSubmitted: onSubmit,
  );
}

void navigatetTo(context, {required Widget widget}) {
  Navigator.push(context, MaterialPageRoute(builder: (context) => widget));
}

void navigatetOff(context, {required Widget widget}) {
  Navigator.pushAndRemoveUntil(
      context,
      MaterialPageRoute(builder: (context) => widget),
      (Route<dynamic> router) => false);
}

SnackBar snackbar({required String massage, required Color color}) {
  return SnackBar(
    backgroundColor: color,
    duration: Duration(seconds: 3),
    behavior: SnackBarBehavior.floating,
    content: Text(
      massage,
      style: const TextStyle(fontWeight: FontWeight.bold),
      textAlign: TextAlign.center,
    ),
    dismissDirection: DismissDirection.down,
  );
}

Widget buildPostItem(PostModel model, context, index) {
  return Card(
    elevation: 5.0,
    clipBehavior: Clip.antiAliasWithSaveLayer,
    margin: const EdgeInsets.symmetric(horizontal: 8.0),
    child: Padding(
      padding: const EdgeInsets.all(10.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              CircleAvatar(
                radius: 25.0,
                backgroundImage: CachedNetworkImageProvider('${model.image}'),
              ),
              const SizedBox(
                width: 10.0,
              ),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      '${model.name}',
                      style: TextStyle(fontWeight: FontWeight.bold),
                    ),
                    Text(
                      '${model.dateTime}',
                      style: Theme.of(context).textTheme.caption,
                    ),
                  ],
                ),
              ),
              IconButton(onPressed: () {}, icon: Icon(Icons.more_horiz)),
            ],
          ),
          const SizedBox(
            height: 10.0,
          ),
          Container(
            width: double.infinity,
            height: 1,
            color: Colors.grey.withOpacity(.5),
          ),
          const SizedBox(
            height: 10.0,
          ),
          Text(
            '${model.text}',
            style: const TextStyle(fontSize: 15.0, fontWeight: FontWeight.bold),
          ),
          const SizedBox(
            height: 10,
          ),
          if (model.postImage != '')
            Card(
              margin: const EdgeInsets.symmetric(horizontal: 0),
              elevation: 5,
              clipBehavior: Clip.antiAliasWithSaveLayer,
              child: CachedNetworkImage(
                imageUrl: '${model.postImage}',
                fit: BoxFit.fill,
                width: double.infinity,
                height: 150.0,
              ),
            ),
          const SizedBox(
            height: 5.0,
          ),
          Row(
            children: [
              Expanded(
                child: MaterialButton(
                  onPressed: () {},
                  child: Row(
                    children: [
                      Icon(
                        Icons.favorite_border,
                        color: Colors.red,
                      ),
                      const SizedBox(
                        width: 5.0,
                      ),
                      Text(
                        '${SocialAppCubitMain.get(context).likes[index]}',
                        style: Theme.of(context)
                            .textTheme
                            .caption!
                            .copyWith(color: Colors.red),
                      ),
                    ],
                  ),
                ),
              ),
              Expanded(
                child: MaterialButton(
                  onPressed: () {},
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      Icon(
                        Icons.comment_outlined,
                        color: Colors.amber,
                      ),
                      const SizedBox(
                        width: 5.0,
                      ),
                      Text(
                        '0 Comment',
                        style: Theme.of(context)
                            .textTheme
                            .caption!
                            .copyWith(color: Colors.amber),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
          Container(
            width: double.infinity,
            height: 1,
            color: Colors.grey.withOpacity(.5),
          ),
          const SizedBox(
            height: 5,
          ),
          Row(
            children: [
              CircleAvatar(
                radius: 20.0,
                backgroundImage: CachedNetworkImageProvider('${model.image}'),
              ),
              const SizedBox(
                width: 7.0,
              ),
              Text('Write a comment ...',
                  style: Theme.of(context).textTheme.caption!),
              Expanded(
                child: MaterialButton(
                  onPressed: () {
                    SocialAppCubitMain.get(context)
                        .likePost(SocialAppCubitMain.get(context).postsId[index]);
                  },
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      const Icon(
                        Icons.favorite_border,
                        color: Colors.red,
                      ),
                      const SizedBox(
                        width: 5.0,
                      ),
                      Text(
                        'Like',
                        style: Theme.of(context)
                            .textTheme
                            .caption!
                            .copyWith(color: Colors.red),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    ),
  );
}

Widget buildBlur(
    {required Widget child, double sigmaX = 10, double sigmaY = 10}) {
  return ClipRRect(
    borderRadius: BorderRadius.circular(20),
    child: BackdropFilter(
      filter: ImageFilter.blur(sigmaX: sigmaX, sigmaY: sigmaY),
      child: child,
    ),
  );
}
