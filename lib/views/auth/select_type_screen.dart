import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:get/get.dart';
import 'package:gocar/models/account_type.dart';
import 'package:gocar/utils/app_color.dart';
import 'package:gocar/views/auth/register_screen.dart';
import 'package:gocar/widgets/account_type_widget.dart';

class SelectTypeScreen extends StatefulWidget {
  const SelectTypeScreen({Key? key}) : super(key: key);

  @override
  _SelectTypeScreenState createState() => _SelectTypeScreenState();
}

class _SelectTypeScreenState extends State<SelectTypeScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: const Text('Select Account Type'),
      ),
      body: Container(
        color: AppColor.bgPrimary,
        padding: EdgeInsets.symmetric(
          vertical: 20,
          horizontal: 20,
        ),
        alignment: Alignment.center,
        child: ListView.builder(
          itemCount: accountdata.length,
          itemBuilder: (BuildContext context, int index) {
            final accountType = accountdata[index];
            return GestureDetector(
                    onTap: () => Get.to(
                        () => RegisterScreen(
                              account_type: accountType,
                            ),
                        transition: Transition.cupertino),
                    child: AccountTypeWidget(accountType: accountdata[index]))
                .animate()
                .scale()
                .fadeIn(
                    duration: Duration(milliseconds: 500),
                    curve: Curves.easeOut);
          },
        ),
      ),
    );
  }
}
