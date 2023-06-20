import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:gocar/controllers/auth/auth_controller.dart';
import 'package:gocar/utils/helpers/asset.dart';
import 'package:gocar/utils/themes/app_color.dart';
import 'package:gocar/views/auth/select_type_screen.dart';
import 'package:gocar/widgets/h.dart';
import 'package:gocar/widgets/v.dart';
import 'package:heroicons/heroicons.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({Key? key}) : super(key: key);

  @override
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final authcontroller = Get.find<AuthController>();

  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();

  final _emailFocusNode = FocusNode();
  final _passwordFocusNode = FocusNode();
  final _key = GlobalKey<FormState>();

  final _focusScopeNode = FocusScopeNode();
  bool obscure = false;

  @override
  void dispose() {
    _emailController.dispose();
    _passwordController.dispose();

    _emailFocusNode.dispose();
    _passwordFocusNode.dispose();
    _focusScopeNode.dispose();
    super.dispose();
  }

  void _login(BuildContext context) {
    // Unfocus the current input field
    _focusScopeNode.unfocus();

    // Validate the form
    if (_key.currentState!.validate()) {
      authcontroller.login(
          context: context,
          email: _emailController.text.trim(),
          password: _passwordController.text.trim());
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: SafeArea(
      child: SingleChildScrollView(
        child: Container(
          padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 20),
          child: Form(
            key: _key,
            child: FocusScope(
              node: _focusScopeNode,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.center,
                mainAxisSize: MainAxisSize.max,
                children: [
                  Container(),
                  SvgPicture.asset(
                    Asset.image('front.svg'),
                    height: MediaQuery.of(context).size.height * 0.33,
                    fit: BoxFit.cover,
                  ),
                  const V(20),
                  Text(
                    'GO CAR',
                    style: TextStyle(
                        color: AppColor.primary,
                        fontWeight: FontWeight.bold,
                        fontSize: 40),
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
                  const V(16),
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
                  const V(24.0),
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
                                : _login(context),
                            child: const Center(
                              child: Text(
                                'Login',
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
                          text: "Dont have an account? ",
                          style: TextStyle(color: Colors.black),
                        ),
                        TextSpan(
                          text: "Register",
                          style: const TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
                            color: AppColor.primary,
                            decoration: TextDecoration.underline,
                          ),
                          recognizer: TapGestureRecognizer()
                            ..onTap = () {
                              Get.to(() => const SelectTypeScreen());
                            },
                        ),
                      ],
                    ),
                  ),
                  const V(16.0),
                  const V(16.0),
                ],
              ),
            ),
          ),
        ),
      ),
    ));
  }
}
