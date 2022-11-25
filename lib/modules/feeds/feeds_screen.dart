import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:social_app/cubit/cubit.dart';
import 'package:social_app/cubit/states.dart';

import '../../constans/components.dart';

class FeedScreen extends StatelessWidget {
  const FeedScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<SocialAppCubitMain, SocialAppStatesMain>(
        listener: (context, state) {},
        builder: ((context, state) {
          var c = SocialAppCubitMain.get(context);
          return ListView(
            children: [
              Card(
                clipBehavior: Clip.antiAliasWithSaveLayer,
                margin:
                    const EdgeInsets.symmetric(horizontal: 8.0, vertical: 7),
                elevation: 5.0,
                child: Stack(
                  alignment: Alignment.bottomRight,
                  children: [
                    CachedNetworkImage(
                      imageUrl:
                          'https://assets.entrepreneur.com/content/3x2/2000/20150225224437-computer.jpeg',
                      fit: BoxFit.fill,
                      width: double.infinity,
                      height: 250.0,
                    ),
                    const Padding(
                      padding: EdgeInsets.all(20.0),
                      child: Text(
                        'Communicate with your friends',
                        style: TextStyle(
                            color: Colors.white, fontWeight: FontWeight.bold),
                      ),
                    ),
                  ],
                ),
              ),
              c.postModel == null && c.posts.length == 0
                  ? Center(
                      child: CircularProgressIndicator(),
                    )
                  : ListView.separated(
                      shrinkWrap: true,
                      physics: const NeverScrollableScrollPhysics(),
                      itemBuilder: (context, index) {
                        return buildPostItem(c.posts[index], context, index);
                      },
                      separatorBuilder: (context, index) {
                        return const SizedBox(
                          height: 5.0,
                        );
                      },
                      itemCount: c.posts.length)
            ],
          );
        }));
  }
}
