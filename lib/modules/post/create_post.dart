import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:social_app/constans/components.dart';

import '../../cubit/cubit.dart';
import '../../cubit/states.dart';

class CreateNewPost extends StatelessWidget {
  CreateNewPost({Key? key}) : super(key: key);
  var postContoller = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<SocialAppCubitMain, SocialAppStatesMain>(
      listener: (context, state) {},
      builder: ((context, state) {
        var c = SocialAppCubitMain.get(context);
        return Scaffold(
          backgroundColor: Colors.white,
          appBar: AppBar(
            elevation: 0,
            centerTitle: false,
            leading: IconButton(
              onPressed: () {
                Navigator.pop(context);
              },
              icon: Icon(
                Icons.arrow_back_ios,
                color: Colors.black,
              ),
            ),
            title: const Text(
              'Create Post',
              style: TextStyle(
                  color: Colors.black,
                  fontSize: 18.0,
                  fontWeight: FontWeight.bold),
            ),
            actions: [
              TextButton(
                onPressed: () {
                  var now = DateTime.now();
                  if (c.postImage == null) {
                    c.createPost(
                        dateTime: now.toString(), text: postContoller.text);
                    c.getPosts();
                    Navigator.pop(context);
                  } else {
                    c.uploadPostImage(
                        dateTime: now.toString(), text: postContoller.text);
                    c.getPosts();
                    Navigator.pop(context);
                  }
                },
                child: Text(
                  'POST',
                  style: TextStyle(fontWeight: FontWeight.bold),
                ),
              ),
              const SizedBox(
                width: 10.0,
              )
            ],
          ),
          body: Padding(
            padding: const EdgeInsets.all(20.0),
            child: Column(mainAxisSize: MainAxisSize.max, children: [
              if (state is UploadPostImageLoadingState ||
                  state is CreatePostLoadingState)
                LinearProgressIndicator(),
              if (state is UploadPostImageLoadingState ||
                  state is CreatePostLoadingState)
                const SizedBox(
                  height: 10,
                ),
              Row(
                children: [
                  CircleAvatar(
                    radius: 25.0,
                    backgroundImage: CachedNetworkImageProvider(
                        'https://assets.entrepreneur.com/content/3x2/2000/20150225224437-computer.jpeg'),
                  ),
                  const SizedBox(
                    width: 10.0,
                  ),
                  Expanded(
                    child: Text(
                      'AHmed',
                      style: TextStyle(fontWeight: FontWeight.bold),
                    ),
                  ),
                ],
              ),
              const SizedBox(
                height: 20.0,
              ),
              Expanded(
                child: TextFormField(
                  controller: postContoller,
                  decoration: InputDecoration(
                    hintText: "What is in your mind ....",
                    hintStyle: TextStyle(fontWeight: FontWeight.bold),
                    border: InputBorder.none,
                  ),
                ),
              ),
              if (c.postImage != null)
                Stack(
                  children: [
                    Container(
                      clipBehavior: Clip.antiAliasWithSaveLayer,
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(5),
                          boxShadow: [
                            BoxShadow(
                              color: Colors.black,
                              blurRadius: 20,
                              spreadRadius: 1,
                              offset: Offset(0, 0),
                            ),
                          ]),
                      height: 200,
                      width: double.infinity,
                      child: Image(
                          width: double.infinity,
                          fit: BoxFit.fill,
                          image: FileImage(c.postImage!)),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(10.0),
                      child: Align(
                        alignment: Alignment.topRight,
                        child: buildBlur(
                          sigmaX: 15,
                          sigmaY: 15,
                          child: Container(
                            decoration: BoxDecoration(
                                shape: BoxShape.circle,
                                color: Colors.blue.withOpacity(.7)),
                            child: IconButton(
                              onPressed: () {
                                c.removePostImage();
                              },
                              icon: Icon(
                                Icons.close,
                                color: Colors.white,
                              ),
                            ),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              if (c.postImage != null)
                const SizedBox(
                  height: 20.0,
                ),
              Row(
                children: [
                  Expanded(
                    child: TextButton(
                      onPressed: () {
                        c.getPostImage();
                      },
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: const [
                          Icon(Icons.photo_album_outlined),
                          Text(
                            'add photo',
                            style: TextStyle(
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                  Expanded(
                    child: TextButton(
                      onPressed: () {},
                      child: Text(
                        '# tags',
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  ),
                ],
              )
            ]),
          ),
        );
      }),
    );
  }
}
