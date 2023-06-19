import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

import 'package:gocar/models/AccountType.dart';
import 'package:gocar/widgets/v.dart';

class AccountTypeWidget extends StatelessWidget {
  final AccountType accountType;
  const AccountTypeWidget({
    Key? key,
    required this.accountType,
  }) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(16.0),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisSize: MainAxisSize.max,
        children: [
         SvgPicture.asset(
          accountType.image,
            width: 150,
            height: 150,
          ),
          const V( 16.0),
          Text(
          accountType.title,
            style: TextStyle(
              fontSize: 20,
              fontWeight: FontWeight.bold,
            ),
          ),
          const V( 8.0),
          Text(
          accountType.body,
            textAlign: TextAlign.center,
            style: TextStyle(fontSize: 16),
          ),
        ],
      ),
    );
  }
}
