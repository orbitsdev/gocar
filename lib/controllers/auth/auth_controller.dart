import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:gocar/constants/firbase_constant.dart';
import 'package:gocar/models/user_account.dart';
import 'package:gocar/utils/helpers/asset.dart';
import 'package:gocar/utils/modal.dart';
import 'package:gocar/views/admin/admin_home_screen.dart';
import 'package:gocar/views/auth/email_verification_screen.dart';
import 'package:gocar/views/auth/login_screen.dart';
import 'package:gocar/views/client/client_home_screen.dart';
import 'package:gocar/views/rental/rental_home_screen.dart';

class AuthController extends GetxController {
  var isLoginLoading = false.obs;
  var isRegisterLoading = false.obs;
  var user = UserAccount().obs;

  void handleError(BuildContext context, e) {
    isRegisterLoading(false);
    update();
    Get.back();
    Modal.showErrorDialog(context: context, message: e.toString());
  }

  void LoginhandleError(BuildContext context, e) {
    isLoginLoading(false);
    update();
    Get.back();
    Modal.showErrorDialog(context: context, message: e.toString());
  }

  void login({
    required BuildContext context,
    required String email,
    required String password,
  }) async {
    try {
      isLoginLoading(true);
      Modal.showProgressDialog(context: context);
      update();

      UserCredential userCredential = await auth.signInWithEmailAndPassword(
          email: email, password: password);
      DocumentSnapshot userDoc =
          await users.doc(userCredential.user!.uid).get();

      if (!userDoc.exists) {
        throw 'User not found';
      }

      UserAccount userAccount =
          UserAccount.fromMap(userDoc.data() as Map<String, dynamic>);
      user(userAccount);
      isLoginLoading(false);
      update();

      Get.back();
      final isEmailVerified = auth.currentUser!.emailVerified;

      if(!isEmailVerified) {
        Get.offAll(() => EmailVerificationScreen());

      } else  if (user.value.role == 'Admin') {
        Get.offAll(() => AdminHomeScreen());
      } else if (user.value.role == 'Car Owner') {
        Get.offAll(() => RentalHomeScreen());
      } else {
        Get.offAll(() => ClientHomeScreen());
      }
      
    } on SocketException catch (e) {
      LoginhandleError(context, e.message);
    } on PlatformException catch (e) {
      LoginhandleError(context, e.message);
    } on FirebaseException catch (e) {
      LoginhandleError(context, e.message);
    } on FirebaseAuthException catch (e) {
      if (e.code == 'user-not-found') {
        throw 'No user found for that email.';
      } else if (e.code == 'wrong-password') {
        throw 'Wrong password provided for that user.';
      } else {
        LoginhandleError(context, e.message);
      }
    } catch (e) {
      LoginhandleError(context, e);
    }
  }

  void register({
    required BuildContext context,
    required String email,
    required String password,
    required String first_name,
    required String last_name,
    required String contact_number,
    required String role,
  }) async {
    try {
      isRegisterLoading(true);
      Modal.showProgressDialog(context: context);
      update();
      UserCredential userCredential = await auth.createUserWithEmailAndPassword(
          email: email, password: password);

      UserAccount new_user = UserAccount(
        uid: userCredential.user!.uid,
        email: userCredential.user!.email,
        first_name: first_name,
        last_name: last_name,
        contact_number: contact_number,
        role: role,
        profile_image: Asset.avatarDefault,
        created_at: DateTime.now().toString(),
      );

      await users.doc(userCredential.user!.uid).set(new_user.toMap());
      user(new_user);
      isRegisterLoading(false);
      update();
      Get.back();
      final isEmailVerified = auth.currentUser!.emailVerified;

      if(!isEmailVerified) {
        Get.offAll(() => EmailVerificationScreen());

      } else  if (user.value.role == 'Admin') {
        Get.offAll(() => AdminHomeScreen());
      } else if (user.value.role == 'Car Owner') {
        Get.offAll(() => RentalHomeScreen());
      } else {
        Get.offAll(() => ClientHomeScreen());
      }
    } on SocketException catch (e) {
      handleError(context, e.message);
    } on PlatformException catch (e) {
      handleError(context, e.message);
    } on FirebaseException catch (e) {
      handleError(context, e.message);
    } on FirebaseAuthException catch (e) {
      if (e.code == 'weak-password') {
        throw 'The password provided is too weak.';
      } else if (e.code == 'email-already-in-use') {
        throw 'The account already exists for that email';
      } else {
        handleError(context, e.message);
      }
    } catch (e) {
      handleError(context, e);
    }
  }

  void logout(BuildContext context) async {
    Modal.showProgressDialog(context: context, message: 'Signing out...');

    await FirebaseAuth.instance.signOut();
    Get.back();
    Get.offAll(() => LoginScreen());
  }

  void getUserDetails(String uid) async {
    DocumentSnapshot userDoc = await users.doc(uid).get();
    if (!userDoc.exists) {}

    UserAccount userAccount =
        UserAccount.fromMap(userDoc.data() as Map<String, dynamic>);
    user(userAccount);
    update();
  }

  Future<void> sendVerification() async {
    try {
      final authuser = FirebaseAuth.instance.currentUser;
      await authuser?.sendEmailVerification();
      print('email verification link sent');
    } catch (e) {
      Modal.errorToast(message: e.toString());
    }
  }
}
