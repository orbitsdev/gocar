import 'dart:io';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:gocar/controllers/auth/auth_controller.dart';
import 'package:gocar/controllers/user/profile_controller.dart';
import 'package:gocar/utils/helpers/functions.dart';
import 'package:gocar/utils/modal.dart';
import 'package:gocar/utils/themes/app_color.dart';
import 'package:gocar/views/global/update_profile_screen.dart';
import 'package:gocar/widgets/loader_widget.dart';
import 'package:gocar/widgets/profile_card_widget.dart';
import 'package:gocar/widgets/profile_widget.dart';
import 'package:gocar/widgets/v.dart';
import 'package:image_picker/image_picker.dart';

class ProfileScreen extends StatefulWidget {
  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  final profileController = Get.find<ProfileController>();

  File? _image;
  final picker = ImagePicker();
  void getImage(BuildContext context) async {
    final pickedFile = await picker.pickImage(source: ImageSource.gallery);
    if (pickedFile != null) {
      setState(() {
        _image = File(pickedFile.path);
      });

      await profileController
        ..updateProfile(context: context, new_photo: _image as File);

      setState(() {
        _image = null;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            V(MediaQuery.of(context).size.height * 0.08),
            Container(
              constraints: BoxConstraints(
                minHeight: MediaQuery.of(context).size.height * 0.40,
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Container(),
                  Container(
                    height: 140,
                    width: 140,
                    child: Stack(
                        fit: StackFit.expand,
                        clipBehavior: Clip.none,
                        children: [
                          ClipOval(
                            child: _image != null
                                ? Image.file(
                                    _image!,
                                    width: 60,
                                    height: 60,
                                    fit: BoxFit.cover,
                                  )
                                : ProfileWidget(
                                    width: 60,
                                    height: 60,
                                  ),
                          ),
                          Positioned(
                              bottom: -6,
                              right: 30,
                              child: Container(
                                height: 45,
                                width: 45,
                                decoration: BoxDecoration(
                                  shape: BoxShape.circle,
                                  border: Border.all(
                                    color: Colors.white,
                                    width: 2.0,
                                  ),
                                  color: AppColor.font,
                                ),
                                child: Builder(builder: (context) {
                                  return IconButton(
                                    onPressed: () async {
                                      String? selectedAction =
                                          await Modal.showProfileUpdateModal(
                                              context);

                                      if (selectedAction != null) {
                                        if (selectedAction == 'update_photo') {
                                          getImage(context);
                                        }
                                        if (selectedAction ==
                                            'update_details') {
                                          Get.back();

                                          Get.to(() => UpdateProfileScreen());
                                        }
                                      }
                                    },
                                    icon: Icon(
                                      Icons.edit,
                                      color: Colors.white,
                                      size: 24,
                                    ),
                                  );
                                }),
                              ))
                        ]),
                  ),
                  SizedBox(height: 16),
                  GetBuilder<ProfileController>(builder: (controller) {
                    return controller.isUploading.value
                        ? Column(
                            children: [LoaderWidget(), Text('Uploading')],
                          )
                        : Container();
                  }),
                  GetBuilder<AuthController>(builder: (controller) {
                    return Column(
                      children: [
                        Text(
                          capitalize(
                              '${controller.user.value.first_name} ${controller.user.value.last_name}'),
                          style: TextStyle(
                            fontSize: 24,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        SizedBox(height: 8),
                        Text(
                          '${controller.user.value.email}',
                          style: TextStyle(
                            fontSize: 16,
                            color: Colors.grey,
                          ),
                        ),
                      ],
                    );
                  }),
                ],
              ), // Use your desired background color or image
            ),

            Padding(
              padding: const EdgeInsets.all(16),
              child: GetBuilder<AuthController>(builder: (controller) {
                return Column(
                  children: [
                    ProfileCardWidget(
                        icon: Icons.person_2_outlined,
                        text: capitalize(
                            '${controller.user.value.first_name} ${controller.user.value.last_name}')),
                    Divider(
                      color: Colors.grey.shade300,
                    ),
                    ProfileCardWidget(
                        icon: Icons.email_outlined,
                        text: '${controller.user.value.email}'),
                    Divider(
                      color: Colors.grey.shade300,
                    ),
                    ProfileCardWidget(
                        icon: Icons.phone_outlined,
                        text: '${controller.user.value.contact_number}'),
                    Divider(
                      color: Colors.grey.shade300,
                    ),
                    Divider(
                      color: Colors.grey.shade300,
                    ),
                  ],
                );
              }),
            ), // Padding(
          ],
        ),
      ),
    );
  }
}
