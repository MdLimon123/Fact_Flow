import 'package:fact_flow/controllers/auth_controller.dart';
import 'package:fact_flow/helpers/route.dart';
import 'package:fact_flow/utils/app_colors.dart';
import 'package:fact_flow/views/base/custom_button.dart';
import 'package:fact_flow/views/base/custom_text_field.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';

class SignupScreen extends StatefulWidget {
  const SignupScreen({super.key});

  @override
  State<SignupScreen> createState() => _SignupScreenState();
}

class _SignupScreenState extends State<SignupScreen> {
  final _authController = Get.put(AuthController());
  final emailTextController = TextEditingController();
  final passwordTextController = TextEditingController();
  final confirmPasswordController = TextEditingController();

  final _fromKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.backgroundColor,
      body: SafeArea(
        child: SingleChildScrollView(
          padding: EdgeInsets.symmetric(horizontal: 20, vertical: 20),
          child: Form(
            key: _fromKey,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Image.asset('assets/image/app_logo.png', width: 50, height: 50),

                SizedBox(height: 32),
                Text(
                  "Sign Up in \nSeconds",
                  style: TextStyle(
                    fontSize: 28,
                    fontWeight: FontWeight.w400,
                    color: Color(0xFF413E3E),
                  ),
                ),
                SizedBox(height: 20),
                Text(
                  "Create an account to capture and share real reactions",
                  style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.w400,
                    color: Color(0xFF413E3E),
                  ),
                ),
                SizedBox(height: 40),
                CustomTextField(
                  controller: emailTextController,
                  validator: (value) {
                    if (value!.isEmpty) {
                      return "Please enter your email";
                    }
                    return null;
                  },
                  isEmail: true,
                  hintText: "Enter your email",
                  prefixIcon: Container(
                    height: 24,
                    margin: EdgeInsets.symmetric(horizontal: 10),
                    width: 24,
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      color: Color(0xFF00A4BB),
                    ),
                    child: Padding(
                      padding: const EdgeInsets.all(5.0),
                      child: SvgPicture.asset('assets/icons/phone.svg'),
                    ),
                  ),
                ),
                SizedBox(height: 20),
                CustomTextField(
                  controller: passwordTextController,
                  isPassword: true,
                  hintText: "Enter your password",
                  validator: (value) {
                    if (value!.isEmpty) {
                      return "Please enter your password";
                    } else if (value.length < 6) {
                      return "Password must be at least 6 characters";
                    }
                    return null;
                  },
                  prefixIcon: Container(
                    height: 24,
                    margin: EdgeInsets.symmetric(horizontal: 10),
                    width: 24,
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      color: Color(0xFF00A4BB),
                    ),
                    child: Padding(
                      padding: const EdgeInsets.all(5.0),
                      child: SvgPicture.asset('assets/icons/lock.svg'),
                    ),
                  ),
                ),
                SizedBox(height: 20),
                CustomTextField(
                  controller: confirmPasswordController,
                  isPassword: true,
                  hintText: "Confirm password",
                  validator: (value) {
                    if (value!.isEmpty) {
                      return "Please enter your password";
                    } else if (value.length < 6) {
                      return "Password must be at least 6 characters";
                    }
                    return null;
                  },
                  prefixIcon: Container(
                    height: 24,
                    margin: EdgeInsets.symmetric(horizontal: 10),
                    width: 24,
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      color: Color(0xFF00A4BB),
                    ),
                    child: Padding(
                      padding: const EdgeInsets.all(5.0),
                      child: SvgPicture.asset('assets/icons/lock.svg'),
                    ),
                  ),
                ),
                SizedBox(height: 20),
                Row(
                  children: [
                    Obx(
                      () => Checkbox(
                        value: _authController.isAgree.value,
                        onChanged: (value) {
                          _authController.isAgree.value = value!;
                        },
                        activeColor: AppColors.primaryColor,
                        side: BorderSide(color: Color(0xFF676565)),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(4),
                        ),
                      ),
                    ),
                    RichText(
                      text: TextSpan(
                        text: "I agree to the ",
                        style: TextStyle(
                          color: Color(0xFF676565),
                          fontSize: 14,
                          fontWeight: FontWeight.w400,
                        ),
                        children: [
                          TextSpan(
                            text: "Terms of Service",
                            style: TextStyle(
                              color: Color(0xFF00A4BB),
                              fontSize: 14,
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                          TextSpan(
                            text: " and  ",
                            style: TextStyle(
                              color: Color(0xFF676565),
                              fontSize: 14,
                              fontWeight: FontWeight.w400,
                            ),
                          ),
                          TextSpan(
                            text: "\n acknowledge you have read this  ",
                            style: TextStyle(
                              color: Color(0xFF676565),
                              fontSize: 14,
                              fontWeight: FontWeight.w400,
                            ),
                          ),
                          TextSpan(
                            text: "Privacy Policy",
                            style: TextStyle(
                              color: Color(0xFF00A4BB),
                              fontSize: 14,
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
                SizedBox(height: 100),
                Obx(
                  () => CustomButton(
                    loading: _authController.isLoading.value,
                    onTap: () {
                      if (_fromKey.currentState!.validate()) {
                        _authController.signup(
                          email: emailTextController.text.trim(),
                          password: passwordTextController.text.trim(),
                        );
                      }
                    },
                    text: "Agree And Continue",
                  ),
                ),
                SizedBox(height: 20),
                Center(
                  child: RichText(
                    text: TextSpan(
                      text: "Already Have an Account?",
                      style: TextStyle(
                        color: Color(0xFF545454),
                        fontSize: 14,
                        fontWeight: FontWeight.w400,
                      ),
                      children: [
                        TextSpan(
                          text: " Login",
                          style: TextStyle(
                            color: Color(0xFF00A4BB),
                            fontSize: 14,
                            fontWeight: FontWeight.w400,
                          ),
                          recognizer: TapGestureRecognizer()
                            ..onTap = () {
                              Get.offNamed(AppRoutes.loginScreen);
                            },
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
