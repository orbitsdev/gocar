import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

import 'package:gocar/models/account_type.dart';
import 'package:gocar/utils/app_color.dart';
import 'package:gocar/utils/asset.dart';
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
      margin: EdgeInsets.only(bottom: 16),
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(8),
          border: Border.all(color: Colors.grey.withOpacity(0.5), width: 0.5),
          color: Colors.white,
          boxShadow: [
            // BoxShadow(
            //   color: Colors.grey.withOpacity(0.5),
            //   spreadRadius: 0.5,
            //   blurRadius: 5,
            //   offset: Offset(0, 0.5),
            // )
          ]),
      padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 20),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisSize: MainAxisSize.max,
        children: [
          SvgPicture.asset(
            Asset.image(accountType.image),
            width: 150,
            height: 150,
          ),
          const V(16.0),
          Text(
            accountType.title,
            style: const TextStyle(
              fontSize: 28,
              color: AppColor.primary,
              fontWeight: FontWeight.bold,
            ),
          ),
          const V(8.0),
          Text(
            accountType.body,
            textAlign: TextAlign.center,
            style: TextStyle(color: Colors.grey.shade800, fontSize: 16),
          ),
        ],
      ),
    );
  }
}
