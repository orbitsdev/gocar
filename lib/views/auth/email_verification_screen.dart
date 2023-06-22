import 'dart:async';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:gocar/constants/firbase_constant.dart';
import 'package:gocar/controllers/auth/auth_controller.dart';
import 'package:gocar/utils/helpers/asset.dart';
import 'package:gocar/utils/modal.dart';
import 'package:gocar/utils/themes/app_color.dart';
import 'package:gocar/views/admin/admin_home_screen.dart';
import 'package:gocar/views/client/client_home_screen.dart';
import 'package:gocar/views/rental/rental_home_screen.dart';
import 'package:gocar/widgets/v.dart';

class EmailVerificationScreen extends StatefulWidget {
  const EmailVerificationScreen({Key? key}) : super(key: key);

  @override
  _EmailVerificationScreenState createState() =>
      _EmailVerificationScreenState();
}

class _EmailVerificationScreenState extends State<EmailVerificationScreen> {
 final authcontroller = Get.find<AuthController>();
bool isEmailVerified = false;
bool canResendEmail = false;
Timer? timer;

@override
void initState() {
  super.initState();
  isEmailVerified = FirebaseAuth.instance.currentUser!.emailVerified;

  if (!isEmailVerified) {
    final user = FirebaseAuth.instance.currentUser;
    sendVerification();

    timer = Timer.periodic(Duration(seconds: 3), (timer) {
      checkEmailVerified();
    });
  }
}

@override
void dispose() {
  timer?.cancel();
  super.dispose();
}

 
 @override
  void setState(fn) {
    if (mounted) super.setState(fn);
  }


void logout() async {
  timer?.cancel();
timer = null; // Reset th
authcontroller.logout(context);
}
Future<void> sendVerification() async {
  print('sending verification');
  try {
    final authuser = FirebaseAuth.instance.currentUser;
    await authuser?.sendEmailVerification();
    Modal.showToastSucces(message: 'Email has been sent to ${authuser?.email}');
    setState(() => canResendEmail = false);
    await Future.delayed(Duration(seconds: 5));
    setState(() => canResendEmail = true);
  } catch (e) {
    Modal.errorToast(message: e.toString());
    setState(() => canResendEmail = true);
  }
}

Future<void> checkEmailVerified() async {
  final authuser = FirebaseAuth.instance.currentUser;
  if (authuser != null) {
    await authuser.reload();
    setState(() {
      isEmailVerified = FirebaseAuth.instance.currentUser!.emailVerified;
    });

    if (isEmailVerified) {
      timer?.cancel(); // Cancel the timer when email is verified
      redirectToHomeScreen();
    }
  }
}

void redirectToHomeScreen() {
  authcontroller.getUserDetails(auth.currentUser!.uid);
  if (authcontroller.user.value.role == 'Admin') {
    Get.offAll(() => AdminHomeScreen());
  } else if (authcontroller.user.value.role == 'Car Owner') {
    Get.offAll(() => RentalHomeScreen());
  } else {
    Get.offAll(() => ClientHomeScreen());
  }
}

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Container(),
            //  SvgPicture.asset(
            //         Asset.image('mail.svg'),
            //         height: MediaQuery.of(context).size.height * 0.33,
            //         fit: BoxFit.cover,
            //       ),
            //       const V(20),
            // Text(
            //   'GO CAR',
            //   style: TextStyle(
            //       color: AppColor.primary,
            //       fontWeight: FontWeight.bold,
            //       fontSize: 40),
            // ),
            Icon(
              Icons.email,
              size: 80,
              color: Theme.of(context).primaryColor,
            ),

            const V(16.0),
            Text(
              'Email Verification',
              style: TextStyle(
                fontSize: 24,
                fontWeight: FontWeight.bold,
              ),
            ),
            const V(8.0),
            Text(
              'We have sent email verification link to your email. Please verify your email to continue.',
              style: TextStyle(fontSize: 16),
              textAlign: TextAlign.center,
            ),
            const V(16.0),
            ElevatedButton(
              onPressed: canResendEmail ? sendVerification : null,
              child: Text('Resend Email'),
            ),
            const V(16.0),
            TextButton(
              onPressed: () =>logout(),
              child: Text('Cancel'),
            ),
          ],
        ),
      ),
    );
  }
}
