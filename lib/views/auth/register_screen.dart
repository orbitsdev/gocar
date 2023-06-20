import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:gocar/controllers/auth/auth_controller.dart';

import 'package:gocar/models/account_type.dart';
import 'package:gocar/utils/helpers/asset.dart';
import 'package:gocar/utils/themes/app_color.dart';
import 'package:gocar/views/auth/login_screen.dart';
import 'package:gocar/widgets/h.dart';
import 'package:gocar/widgets/v.dart';
import 'package:heroicons/heroicons.dart';

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
  final authcontroller = Get.find<AuthController>();

// controllers
  final _firstNameController = TextEditingController();
  final _lastNameController = TextEditingController();

  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();

  final _contactNumberController = TextEditingController();
//focus node
  final _firstNameFocusNode = FocusNode();
  final _lastNameFocusNode = FocusNode();
  final _contactNumberFocusNode = FocusNode();

  final _emailFocusNode = FocusNode();
  final _passwordFocusNode = FocusNode();
  final _key = GlobalKey<FormState>();

  final _focusScopeNode = FocusScopeNode();

  bool obscure = false;

  @override
  void dispose() {
    _firstNameController.dispose();
    _lastNameController.dispose();

    _contactNumberController.dispose();

    _emailController.dispose();
    _passwordController.dispose();

    _firstNameFocusNode.dispose();
    _lastNameFocusNode.dispose();

    _contactNumberFocusNode.dispose();

    _emailFocusNode.dispose();
    _passwordFocusNode.dispose();
    _focusScopeNode.dispose();
    super.dispose();
  }

  void _register(BuildContext context) async {
    // Unfocus the current input field
    _focusScopeNode.unfocus();

    // Validate the form
    if (_key.currentState!.validate()) {
      authcontroller.register(
        context: context,
        email: _emailController.text.trim(),
        password: _passwordController.text.trim(),
        first_name: _firstNameController.text.trim(),
        last_name: _lastNameController.text.trim(),
        role: widget.account_type!.name,
        contact_number: _contactNumberController.text.trim(),
      ); // authcontroller.registerWithEmailAndPassword(
      //   context: context,
      //    email: _emailController.text.trim(),
      //     password: _passwordController.text.trim(),
      //     first_name: _firstNameController.text.trim(),
      //      last_name: _lastNameController.text.trim(), role: widget.name ?? 'tourist',
      //      contact_number: _contactNumberController.text.trim(),
      //       address: _addressController.text.trim());

      // final isAgree =  await Get.to(()=> PrivacyAndPolicy());

      // if(isAgree){
      // }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Register',
          style: TextStyle(color: AppColor.primary),
        ),
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.symmetric(
          vertical: 8.0,
          horizontal: 20,
        ),
        child: Form(
          key: _key,
          child: FocusScope(
            node: _focusScopeNode,
            child: Column(
              mainAxisSize: MainAxisSize.max,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Hero(
                  tag: widget.account_type!.name,
                  child: SvgPicture.asset(
                    Asset.image('${widget.account_type!.image}'),
                    height: 160,
                    fit: BoxFit.cover,
                  ),
                ),
                const V(2),
                Text(
                  '${widget.account_type!.name}'.toUpperCase(),
                  style: TextStyle(fontSize: 24, color: AppColor.primary),
                ),
                const V(16.0),
                Container(),
                const V(20),
                TextFormField(
                  decoration: InputDecoration(
                    prefixIcon: HeroIcon(
                      HeroIcons.user,
                      style: HeroIconStyle
                          .outline, // Outlined icons are used by default.
                      color: AppColor.primary,
                      size: 30,
                    ),
                    contentPadding:
                        EdgeInsets.symmetric(vertical: 14, horizontal: 10),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(24),
                    ),
                    labelText: 'First name',
                    filled: true,
                    fillColor: AppColor.gray1,
                  ),
                  controller: _firstNameController,
                  focusNode: _firstNameFocusNode,
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Please enter your first name';
                    }
                    return null;
                  },
                ),
                const V(20),
                TextFormField(
                  decoration: InputDecoration(
                    prefixIcon: HeroIcon(
                      HeroIcons.user,
                      style: HeroIconStyle
                          .outline, // Outlined icons are used by default.
                      color: AppColor.primary,
                      size: 30,
                    ),
                    contentPadding:
                        EdgeInsets.symmetric(vertical: 14, horizontal: 10),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(24),
                    ),
                    labelText: 'Last name',
                    filled: true,
                    fillColor: AppColor.gray1,
                  ),
                  controller: _lastNameController,
                  focusNode: _lastNameFocusNode,
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Please enter your last name';
                    }
                    return null;
                  },
                ),
                const V(20),
                TextFormField(
                  decoration: InputDecoration(
                    prefixIcon: HeroIcon(
                      HeroIcons.phone,
                      style: HeroIconStyle
                          .outline, // Outlined icons are used by default.
                      color: AppColor.primary,
                      size: 30,
                    ),
                    contentPadding:
                        EdgeInsets.symmetric(vertical: 14, horizontal: 10),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(24),
                    ),
                    labelText: 'Contact Number',
                    filled: true,
                    fillColor: AppColor.gray1,
                  ),
                  controller: _contactNumberController,
                  focusNode: _contactNumberFocusNode,
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Please enter your contact number';
                    }
                    return null;
                  },
                ),
                const V(20),
                TextFormField(
                  decoration: InputDecoration(
                    prefixIcon: HeroIcon(
                      HeroIcons.envelope,
                      style: HeroIconStyle
                          .outline, // Outlined icons are used by default.
                      color: AppColor.primary,
                      size: 30,
                    ),
                    contentPadding:
                        EdgeInsets.symmetric(vertical: 14, horizontal: 10),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(24),
                    ),
                    labelText: 'Email Address',
                    filled: true,
                    fillColor: AppColor.gray1,
                  ),
                  controller: _emailController,
                  focusNode: _emailFocusNode,
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Please enter your email address';
                    }
                    return null;
                  },
                ),
                const V(10),
                const V(10),
                TextFormField(
                  obscureText: !obscure,
                  decoration: InputDecoration(
                    prefixIcon: HeroIcon(
                      HeroIcons.key,
                      style: HeroIconStyle
                          .outline, // Outlined icons are used by default.
                      color: AppColor.primary,
                      size: 30,
                    ),
                    contentPadding:
                        EdgeInsets.symmetric(vertical: 14, horizontal: 10),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(24),
                    ),
                    labelText: 'Password',
                    filled: true,
                    fillColor: AppColor.gray1,
                  ),
                  controller: _passwordController,
                  focusNode: _passwordFocusNode,
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Please enter your password';
                    }
                    return null;
                  },
                ),
                const V(14),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    SizedBox(
                      width: 24,
                      height: 24,
                      child: Checkbox(
                        side: BorderSide(color: AppColor.primary),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(
                              4.0), // Set the desired border radius here
                        ),
                        value: obscure,
                        onChanged: (newValue) {
                          setState(() {
                            obscure = newValue!;
                          });
                        },
                        activeColor: AppColor
                            .primary, // Set the active color to AppTheme.ORANGE
                      ),
                    ),
                    H(10),
                    Text(
                      'Show Password',
                      style: TextStyle(
                        color: AppColor
                            .primary, // Set the text color to AppTheme.ORANGE
                      ),
                    ),
                  ],
                ),
                const V(14),
                GetBuilder<AuthController>(
                  builder: (controller) => SizedBox(
                    width: double.infinity,
                    child: Builder(builder: (context) {
                      return SizedBox(
                        height: 50,
                        child: ElevatedButton(
                          style: ElevatedButton.styleFrom(
                            backgroundColor: AppColor.primary,
                            foregroundColor: Colors.white,
                          ),
                          onPressed: () => controller.isRegisterLoading.value
                              ? null
                              : _register(context),
                          child: const Center(
                            child: Text(
                              'Register',
                              style: TextStyle(fontSize: 16),
                            ),
                          ),
                        ),
                      );
                    }),
                  ),
                ),
                const V(10),
                const V(24.0),
                RichText(
                  text: TextSpan(
                    children: [
                      const TextSpan(
                        text: "Already have an account? ",
                        style: TextStyle(color: Colors.black),
                      ),
                      TextSpan(
                        text: "Login",
                        style: const TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                          color: AppColor.primary,
                          decoration: TextDecoration.underline,
                        ),
                        recognizer: TapGestureRecognizer()
                          ..onTap = () {
                            Get.to(() => const LoginScreen());
                          },
                      ),
                    ],
                  ),
                ),
                const V(16.0),
                Divider(
                  color: AppColor.primary,
                ),
                const V(10.0),
                RichText(
                  textAlign: TextAlign.center,
                  text: TextSpan(
                    children: [
                      TextSpan(
                        text: 'By continuing, you agree to Dirita\'s ',
                        style: TextStyle(
                            fontSize: 12, color: Colors.grey.shade600),
                      ),
                      TextSpan(
                        text: 'Terms of Use',
                        style: TextStyle(
                          fontSize: 12,
                          color: Colors.blue.shade800,
                          decoration: TextDecoration.underline,
                        ),
                        recognizer: TapGestureRecognizer()
                          ..onTap = () {
                            // Get.to(()=>TermsAndCondition());
                          },
                      ),
                      TextSpan(
                        text: '. Read our ',
                        style: TextStyle(
                            fontSize: 12, color: Colors.grey.shade600),
                      ),
                      TextSpan(
                        text: 'Privacy Policy',
                        style: TextStyle(
                          fontSize: 12,
                          color: Colors.blue.shade800,
                          decoration: TextDecoration.underline,
                        ),
                        recognizer: TapGestureRecognizer()
                          ..onTap = () {
                            // Get.to(()=>PrivacyAndPolicy());
                            // Add your functionality for Privacy Policy here
                            // For example, navigate to the Privacy Policy screen or open a web page
                          },
                      ),
                      TextSpan(
                        text: '.',
                        style: TextStyle(
                            fontSize: 12, color: Colors.grey.shade600),
                      ),
                    ],
                  ),
                ),
                const V(16.0),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
