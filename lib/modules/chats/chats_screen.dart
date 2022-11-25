import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:social_app/constans/components.dart';
import 'package:social_app/cubit/cubit.dart';
import 'package:social_app/cubit/states.dart';
import 'package:social_app/models/create_user_model.dart';

import '../chat_details/chat_details_screen.dart';

class ChatScreen extends StatelessWidget {
  const ChatScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<SocialAppCubitMain, SocialAppStatesMain>(
      listener: (context, state) {},
      builder: (context, state) {
        var c = SocialAppCubitMain.get(context);
        return c.users.length > 0
            ? ListView.separated(
                itemBuilder: (context, index) {
                  return buildChatItem(c.users[index],context);
                },
                separatorBuilder: (context, index) => const SizedBox(
                      height: 10.0,
                    ),
                itemCount: c.users.length)
            : Center(
                child: CircularProgressIndicator(),
              );
      },
    );
  }

  Widget buildChatItem(CreateUserModel model, context) => InkWell(
        onTap: () {
          navigatetTo(context, widget: ChatDetailsScreen(model));
        },
        child: Padding(
          padding: const EdgeInsets.all(20.0),
          child: Row(
            children: [
              CircleAvatar(
                radius: 25.0,
                backgroundImage: CachedNetworkImageProvider('${model.image}'),
              ),
              const SizedBox(
                width: 10.0,
              ),
              Expanded(
                child: Text(
                  '${model.name}',
                  style: TextStyle(fontWeight: FontWeight.bold),
                ),
              ),
              IconButton(onPressed: () {}, icon: Icon(Icons.more_horiz)),
            ],
          ),
        ),
      );
}
