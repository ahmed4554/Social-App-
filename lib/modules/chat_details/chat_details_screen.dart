import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:social_app/cubit/cubit.dart';
import 'package:social_app/cubit/states.dart';
import 'package:social_app/models/create_user_model.dart';
import 'package:social_app/models/message_model.dart';

class ChatDetailsScreen extends StatelessWidget {
  CreateUserModel model;
  ChatDetailsScreen(this.model);
  var messageController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Builder(
      builder: (context) {
        SocialAppCubitMain.get(context).getmessages(recieverId: model.uId);
        return BlocConsumer<SocialAppCubitMain, SocialAppStatesMain>(
          listener: (context, state) {},
          builder: (context, state) {
            var c = SocialAppCubitMain.get(context);
            return Scaffold(
              appBar: AppBar(
                  leadingWidth: 0.0,
                  titleSpacing: 0.0,
                  centerTitle: false,
                  elevation: 0,
                  title: Row(
                    children: [
                      const SizedBox(
                        width: 15.0,
                      ),
                      CircleAvatar(
                        radius: 25.0,
                        backgroundImage:
                            CachedNetworkImageProvider(model.image),
                      ),
                      const SizedBox(
                        width: 8.0,
                      ),
                      Text('${model.name}',
                          style: const TextStyle(
                            fontWeight: FontWeight.bold,
                            color: Colors.black,
                          )),
                    ],
                  )),
              body: Padding(
                padding: const EdgeInsets.all(15.0),
                child: Column(
                  mainAxisSize: MainAxisSize.max, 
                  children: [
                  Expanded(
                      child: ListView.separated(
                          itemBuilder: (context, index) {
                            if (c.messages[index].senderId == c.model!.uId) {
                              return buildMessageFrom(c.messages[index]);
                            } else {
                              return messageBuild(c.messages[index]);
                            }
                          },
                          separatorBuilder: (context, index) => const SizedBox(
                                height: 10.0,
                              ),
                          itemCount: c.messages.length)),
                  Container(
                    clipBehavior: Clip.antiAliasWithSaveLayer,
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(30.0),
                        border: Border.all(
                          color: Colors.grey.withOpacity(.2),
                          width: 1.0,
                        )),
                    child: Row(
                      children: [
                        Expanded(
                          flex: 6,
                          child: TextFormField(
                            controller: messageController,
                            decoration: const InputDecoration(
                              contentPadding: EdgeInsets.only(left: 8.0),
                              border: InputBorder.none,
                              hintText: 'Write your message',
                            ),
                          ),
                        ),
                        Expanded(
                          child: MaterialButton(
                            child: Icon(
                              Icons.send_rounded,
                              color: Colors.white,
                            ),
                            onPressed: () {
                              c.sendMessage(
                                  content: messageController.text,
                                  dateTime: DateTime.now().toString(),
                                  recieverId: model.uId);
                            },
                            color: Colors.blue[400],
                            height: 50,
                          ),
                        ),
                      ],
                    ),
                  )
                ]),
              ),
            );
          },
        );
      },
    );
  }

  Widget messageBuild(MessageModel model) => Align(
        alignment: Alignment.topLeft,
        child: Container(
          padding: EdgeInsets.symmetric(vertical: 10.0, horizontal: 10.0),
          decoration: BoxDecoration(
            color: Colors.grey[300],
            borderRadius: const BorderRadius.only(
              topLeft: Radius.circular(10.0),
              topRight: Radius.circular(10.0),
              bottomRight: Radius.circular(10.0),
            ),
          ),
          child: Text('${model.content}',
              style: const TextStyle(
                fontWeight: FontWeight.bold,
                color: Colors.black,
              )),
        ),
      );

  Widget buildMessageFrom(MessageModel model) => Align(
        alignment: Alignment.topRight,
        child: Container(
          padding: EdgeInsets.symmetric(vertical: 10.0, horizontal: 10.0),
          decoration: BoxDecoration(
            color: Colors.blue[300],
            borderRadius: const BorderRadius.only(
              topLeft: Radius.circular(10.0),
              topRight: Radius.circular(10.0),
              bottomLeft: Radius.circular(10.0),
            ),
          ),
          child: Text('${model.content}',
              style: const TextStyle(
                fontWeight: FontWeight.bold,
                color: Colors.black,
              )),
        ),
      );
}
