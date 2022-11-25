import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:social_app/constans/components.dart';
import 'package:social_app/modules/edit_profile/edit_profile_screen.dart';

import '../../cubit/cubit.dart';
import '../../cubit/states.dart';

class SettingsScreen extends StatelessWidget {
  const SettingsScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<SocialAppCubitMain, SocialAppStatesMain>(
      listener: (context, state) {},
      builder: (context, state) {
        var c = SocialAppCubitMain.get(context);
        return Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            children: [
              Stack(
                children: [
                  Container(
                    height: 260,
                    child: Stack(
                      children: [
                        Card(
                          clipBehavior: Clip.antiAliasWithSaveLayer,
                          margin: const EdgeInsets.symmetric(
                              horizontal: 0.0, vertical: 7),
                          elevation: 5.0,
                          child: CachedNetworkImage(
                            imageUrl:'${c.model!.cover}',
                            fit: BoxFit.fill,
                            width: double.infinity,
                            height: 200.0,
                          ),
                        ),
                        Align(
                          alignment: Alignment.bottomCenter,
                          child: CircleAvatar(
                            child: Container(
                              clipBehavior: Clip.antiAliasWithSaveLayer,
                              decoration: BoxDecoration(),
                              child: CircleAvatar(
                                radius: 60,
                                backgroundImage: CachedNetworkImageProvider(
                                  c.model!.image,
                                ),
                              ),
                            ),
                            radius: 64,
                            backgroundColor:
                                Theme.of(context).scaffoldBackgroundColor,
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
              const SizedBox(
                height: 10.0,
              ),
              Text(
                c.model!.name,
                style: TextStyle(fontSize: 18.0, fontWeight: FontWeight.bold),
              ),
              const SizedBox(
                height: 10.0,
              ),
              Text(
                c.model!.bio,
                style: TextStyle(
                    fontSize: 14.0,
                    fontWeight: FontWeight.bold,
                    color: Colors.grey),
              ),
              const SizedBox(
                height: 10.0,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Expanded(
                      child: InkWell(
                    child: Column(
                      children: [
                        const Text(
                          'Posts',
                          style: TextStyle(
                              fontSize: 18.0, fontWeight: FontWeight.bold),
                        ),
                        Text(
                          '100',
                          style: Theme.of(context)
                              .textTheme
                              .caption!
                              .copyWith(fontSize: 14.0),
                        ),
                      ],
                    ),
                    onTap: () {},
                  )),
                  Expanded(
                      child: InkWell(
                    child: Column(
                      children: [
                        const Text(
                          'Photos',
                          style: TextStyle(
                              fontSize: 18.0, fontWeight: FontWeight.bold),
                        ),
                        Text(
                          '256',
                          style: Theme.of(context)
                              .textTheme
                              .caption!
                              .copyWith(fontSize: 14.0),
                        ),
                      ],
                    ),
                    onTap: () {},
                  )),
                  Expanded(
                      child: InkWell(
                    child: Column(
                      children: [
                        const Text(
                          'Follwers',
                          style: TextStyle(
                              fontSize: 18.0, fontWeight: FontWeight.bold),
                        ),
                        Text(
                          '100',
                          style: Theme.of(context)
                              .textTheme
                              .caption!
                              .copyWith(fontSize: 14.0),
                        ),
                      ],
                    ),
                    onTap: () {},
                  )),
                  Expanded(
                      child: InkWell(
                    child: Column(
                      children: [
                        const Text(
                          'Followings',
                          style: TextStyle(
                              fontSize: 18.0, fontWeight: FontWeight.bold),
                        ),
                        Text(
                          '100',
                          style: Theme.of(context)
                              .textTheme
                              .caption!
                              .copyWith(fontSize: 14.0),
                        ),
                      ],
                    ),
                    onTap: () {},
                  )),
                ],
              ),
              const SizedBox(
                height: 10.0,
              ),
              Row(
                children: [
                  Expanded(
                    flex: 4,
                    child: OutlinedButton(
                      onPressed: () {},
                      child: Text('Add Photo'),
                    ),
                  ),
                  const SizedBox(
                    width: 5.0,
                  ),
                  Expanded(
                    flex: 1,
                    child: OutlinedButton(
                      onPressed: () {
                        navigatetTo(context, widget: EditProfileScreen());
                      },
                      child: Icon(Icons.edit_outlined),
                    ),
                  ),
                ],
              )
            ],
          ),
        );
      },
    );
  }
}
