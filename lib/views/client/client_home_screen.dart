import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:gocar/constants/firbase_constant.dart';
import 'package:gocar/controllers/auth/auth_controller.dart';
import 'package:gocar/utils/helpers/asset.dart';
import 'package:gocar/utils/themes/app_color.dart';
import 'package:gocar/widgets/h.dart';
import 'package:heroicons/heroicons.dart';

class ClientHomeScreen extends StatefulWidget {
  const ClientHomeScreen({Key? key}) : super(key: key);

  @override
  _ClientHomeScreenState createState() => _ClientHomeScreenState();
}

class _ClientHomeScreenState extends State<ClientHomeScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Client'),
      ),
      drawer: Drawer(
        child: GetBuilder<AuthController>(
          builder: (controller) {
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
          }
        ),
      ),
      body: Container(),
    );
  }
}
