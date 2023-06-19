import 'package:flutter/material.dart';

import 'package:gocar/models/AccountType.dart';

class RegisterScreen extends StatefulWidget {

   AccountType? accountType;
   RegisterScreen({
    Key? key,
    this.accountType,
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
