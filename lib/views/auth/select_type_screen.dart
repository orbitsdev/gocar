import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:gocar/models/AccountType.dart';
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
        title: const Text('Title'),
      ),
      body: Container(
        alignment: Alignment.center,
        child: ListView.builder(
          itemCount: accountdata.length,
          itemBuilder: (BuildContext context, int index) {
            final accountType = accountdata[index];
            return GestureDetector(
                onTap: () => Get.to(
                    () => RegisterScreen(
                          accountType: accountType,
                        ),
                    transition: Transition.cupertino),
                child: AccountTypeWidget(accountType: accountdata[index]));
          },
        ),
      ),
    );
  }
}
