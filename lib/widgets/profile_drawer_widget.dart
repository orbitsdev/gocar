import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:gocar/constants/firbase_constant.dart';
import 'package:gocar/controllers/auth/auth_controller.dart';
import 'package:gocar/utils/helpers/asset.dart';
import 'package:gocar/utils/themes/app_color.dart';
import 'package:gocar/widgets/h.dart';

class ProfileDrawerWidget extends StatelessWidget {
  
  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: GetBuilder<AuthController>(builder: (controller) {
        return ListView(
          children: [
            Container(
              height: 100,
              color: AppColor.primary,
              padding: EdgeInsets.all(10),
              child: Image.asset(Asset.image('logo.png')),
            ),
            H(40),
            if (auth.currentUser != null)
              ListTile(
                onTap: () => controller.logout(context),
                title: Text('Logout'),
                leading: Icon(Icons.logout),
              )
          ],
        );
      }),
    );
  }
}
