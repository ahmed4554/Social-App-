import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:social_app/constans/components.dart';

import '../../cubit/cubit.dart';
import '../../cubit/states.dart';

class EditProfileScreen extends StatelessWidget {
  EditProfileScreen({Key? key}) : super(key: key);

  var nameController = TextEditingController();
  var bioController = TextEditingController();
  var phoneController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<SocialAppCubitMain, SocialAppStatesMain>(
      listener: (context, state) {},
      builder: (context, state) {
        var c = SocialAppCubitMain.get(context);
        nameController.text = c.model!.name;
        bioController.text = c.model!.bio;
        phoneController.text = c.model!.phone;
        return Scaffold(
          appBar: AppBar(
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
              'Edit Profle',
              style: TextStyle(
                  color: Colors.black,
                  fontSize: 18.0,
                  fontWeight: FontWeight.bold),
            ),
            actions: [
              TextButton(
                onPressed: () {
                  c.updateUser(
                      bio: bioController.text,
                      name: nameController.text,
                      phone: phoneController.text);
                },
                child: Text(
                  'UPDATE',
                  style: TextStyle(fontWeight: FontWeight.bold),
                ),
              ),
              const SizedBox(
                width: 10.0,
              )
            ],
          ),
          body: SingleChildScrollView(
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Column(children: [
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
                            child: c.coverImage == null
                                ? CachedNetworkImage(
                                    imageUrl: c.model!.cover,
                                    fit: BoxFit.fill,
                                    width: double.infinity,
                                    height: 200.0,
                                  )
                                : Image(
                                    image: FileImage(c.coverImage!),
                                    fit: BoxFit.fill,
                                    width: double.infinity,
                                    height: 200.0,
                                  ),
                          ),
                          Align(
                            alignment: Alignment.bottomCenter,
                            child: Stack(
                              alignment: Alignment.bottomRight,
                              children: [
                                CircleAvatar(
                                  radius: 64,
                                  backgroundColor:
                                      Theme.of(context).scaffoldBackgroundColor,
                                  child: Container(
                                    child: CircleAvatar(
                                      radius: 60,
                                      backgroundImage: c.profileImage == null
                                          ? CachedNetworkImageProvider(
                                              c.model!.image,
                                            )
                                          : FileImage(c.profileImage!)
                                              as ImageProvider,
                                    ),
                                  ),
                                ),
                                CircleAvatar(
                                  radius: 15,
                                  child: InkWell(
                                      onTap: () {
                                        c.imagePick();
                                      },
                                      child: Icon(Icons.camera)),
                                ),
                              ],
                            ),
                          ),
                          Align(
                            alignment: Alignment.topRight,
                            child: Padding(
                              padding:
                                  const EdgeInsets.only(top: 16.0, right: 10.0),
                              child: CircleAvatar(
                                radius: 15,
                                child: InkWell(
                                    onTap: () {
                                      c.coverPick();
                                    },
                                    child: Icon(Icons.camera)),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
                if (c.coverImage != null || c.profileImage != null)
                  const SizedBox(
                    height: 20.0,
                  ),
                if (c.coverImage != null || c.profileImage != null)
                  Row(
                    children: [
                      if (c.profileImage != null)
                        Expanded(
                          child: TextButton(
                            onPressed: () {
                              c.uploudProfileImage(
                                  name: nameController.text,
                                  bio: bioController.text,
                                  phone: phoneController.text);
                            },
                            style: TextButton.styleFrom(
                                backgroundColor: Colors.blue),
                            child: const Text(
                              'Upload Profile Image',
                              style: TextStyle(
                                  fontSize: 15.0,
                                  fontWeight: FontWeight.bold,
                                  color: Colors.white),
                            ),
                          ),
                        ),
                      if (c.coverImage != null)
                        const SizedBox(
                          width: 8,
                        ),
                      if (c.coverImage != null)
                        Expanded(
                          child: TextButton(
                            onPressed: () {
                              c.uploudCoverImage(
                                  name: nameController.text,
                                  bio: bioController.text,
                                  phone: phoneController.text);
                            },
                            style: TextButton.styleFrom(
                                backgroundColor: Colors.blue),
                            child: const Text(
                              'Upload Cover',
                              style: TextStyle(
                                  fontSize: 15.0,
                                  fontWeight: FontWeight.bold,
                                  color: Colors.white),
                            ),
                          ),
                        ),
                    ],
                  ),
                const SizedBox(
                  height: 20.0,
                ),
                textInput(
                    inputControler: nameController,
                    inputLabal: 'Name',
                    type: TextInputType.name,
                    isSave: false,
                    preffix: Icons.person,
                    validate: (String? value) {
                      if (value!.isEmpty) {
                        return 'Name mustn\'t be empty';
                      }
                    }),
                const SizedBox(
                  height: 20.0,
                ),
                textInput(
                    inputControler: bioController,
                    inputLabal: 'Bio',
                    type: TextInputType.name,
                    isSave: false,
                    preffix: Icons.info_outline,
                    validate: (String? value) {
                      if (value!.isEmpty) {
                        return 'bio mustn\'t be empty';
                      }
                    }),
                const SizedBox(
                  height: 20.0,
                ),
                textInput(
                    inputControler: phoneController,
                    inputLabal: 'Phone',
                    type: TextInputType.phone,
                    isSave: false,
                    preffix: Icons.phone,
                    validate: (String? value) {
                      if (value!.isEmpty) {
                        return 'Phone mustn\'t be empty';
                      }
                    })
              ]),
            ),
          ),
        );
      },
    );
  }
}
