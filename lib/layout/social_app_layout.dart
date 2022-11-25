import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:social_app/constans/components.dart';
import 'package:social_app/constans/constant.dart';
import 'package:social_app/modules/post/create_post.dart';

import '../cubit/cubit.dart';
import '../cubit/states.dart';


class HomeLayout extends StatelessWidget {
  const HomeLayout({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<SocialAppCubitMain, SocialAppStatesMain>(
      listener: (context, state) {},
      builder: (context, state) {
        var c = SocialAppCubitMain.get(context);
        return Scaffold(
          extendBody: true,
          appBar: AppBar(
            title: Text(
              c.titles[c.currentIndex],
              style:
                  TextStyle(color: Colors.black, fontWeight: FontWeight.bold),
            ),
            actions: [
              IconButton(
                onPressed: () {},
                icon: Icon(
                  Icons.notifications_active,
                  color: Colors.blue,
                ),
              ),
              IconButton(
                onPressed: () {},
                icon: Icon(
                  Icons.search,
                  color: Colors.blue,
                ),
              ),
            ],
          ),
          // body: c.model == null
          //     ? Center(
          //         child: LinearProgressIndicator(),
          //       )
          //     : ListView(
          //         children: [
          //           if (!c.model!.isEmailVerified)
          //             Container(
          //               color: Colors.amber.withOpacity(.6),
          //               padding: const EdgeInsets.symmetric(horizontal: 10),
          //               child: Row(
          //                 children: [
          //                   Icon(Icons.info_outline),
          //                   const SizedBox(
          //                     width: 10,
          //                   ),
          //                   Expanded(child: Text('Verify Your Account ...')),
          //                   TextButton(
          //                       onPressed: () {
          //                         FirebaseAuth.instance.currentUser!
          //                             .sendEmailVerification()
          //                             .then((value) {})
          //                             .catchError((e) {
          //                           print(
          //                               '$e from text button sent email verification');
          //                         });
          //                       },
          //                       child: Text('Send')),
          //                 ],
          //               ),
          //             )
          //         ],
          //       ),
          body: c.screens[c.currentIndex],
          floatingActionButton: FloatingActionButton(
            onPressed: () {
              navigatetTo(context, widget: CreateNewPost());
            },
            child: Icon(Icons.add_card),
          ),
          floatingActionButtonLocation:
              FloatingActionButtonLocation.centerDocked,
          bottomNavigationBar: BottomAppBar(
            elevation: 10,
            notchMargin: 10,
            shape: CircularNotchedRectangle(),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              mainAxisSize: MainAxisSize.max,
              children: [
                Padding(
                  padding: const EdgeInsets.only(left: 10),
                  child: IconButton(
                    onPressed: () {
                      c.changeIndex(0);
                    },
                    icon: Icon(
                      Icons.home,
                      color: c.currentIndex == 0 ? Colors.blue : Colors.grey,
                    ),
                  ),
                ),
                IconButton(
                  onPressed: () {
                    c.changeIndex(1);
                  },
                  icon: Icon(
                    Icons.message,
                    color: c.currentIndex == 1 ? Colors.blue : Colors.grey,
                  ),
                ),
                IconButton(
                  onPressed: () {
                    c.changeIndex(2);
                  },
                  icon: Icon(
                    Icons.person,
                    color: c.currentIndex == 2 ? Colors.blue : Colors.grey,
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(right: 10),
                  child: IconButton(
                    onPressed: () {
                      c.changeIndex(3);
                    },
                    icon: Icon(
                      Icons.settings,
                      color: c.currentIndex == 3 ? Colors.blue : Colors.grey,
                    ),
                  ),
                ),
              ],
            ),
          ),
          // bottomNavigationBar: BottomNavigationBar(
          //   onTap: (index) {
          //     c.changeIndex(index);
          //   },
          //   items: const [
          //     BottomNavigationBarItem(
          //         icon: Icon(
          //           Icons.home,
          //         ),
          //         label: 'Feeds'),
          //     BottomNavigationBarItem(
          //         icon: Icon(
          //           Icons.message,
          //         ),
          //         label: 'Chats'),
          //     BottomNavigationBarItem(
          //         icon: Icon(
          //           Icons.person,
          //         ),
          //         label: 'Users'),
          //     BottomNavigationBarItem(
          //         icon: Icon(
          //           Icons.settings,
          //         ),
          //         label: 'Setting'),
          //   ],
          //   currentIndex: c.currentIndex,
          // ),
        );
      },
    );
  }
}
