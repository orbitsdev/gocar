import 'package:flutter/material.dart';

import 'package:gocar/models/account_type.dart';

class RegisterScreen extends StatefulWidget {
  AccountType? account_type;
   RegisterScreen({
    Key? key,
    this.account_type,
  }) : super(key: key);
 

  @override
  _RegisterScreenState createState() => _RegisterScreenState();
}

class _RegisterScreenState extends State<RegisterScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Title'),
      ),
      body: Container(),
    );
  }
}
