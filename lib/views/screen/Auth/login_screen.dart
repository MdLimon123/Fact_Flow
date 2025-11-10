import 'package:fact_flow/helpers/route.dart';
import 'package:fact_flow/utils/app_colors.dart';
import 'package:fact_flow/views/base/custom_button.dart';
import 'package:fact_flow/views/base/custom_text_field.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:get/utils.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.backgroundColor,
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.symmetric(horizontal: 25, vertical: 28),

          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Image.asset('assets/image/app_logo.png', width: 50, height: 50),

              SizedBox(height: 32),
              Text(
                "Glad to See You \nAgain!",
                style: TextStyle(
                  fontSize: 28,
                  fontWeight: FontWeight.w400,
                  color: Color(0xFF413E3E),
                ),
              ),
              SizedBox(height: 40),
              CustomTextField(
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
                isPassword: true,
                hintText: "Enter your password",
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

              SizedBox(height: 16),
              Align(
                alignment: Alignment.centerRight,
                child: InkWell(
                  onTap: () {
                    Get.offNamed(AppRoutes.forgetPasswordScreen);
                  },
                  child: Text(
                    "Forgot Password",
                    style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.w400,
                      color: Color(0xFF00A4BB),
                    ),
                  ),
                ),
              ),
              SizedBox(height: 50),
              CustomButton(onTap: () {}, text: "Log In"),
              SizedBox(height: 16),
              Center(
                child: RichText(
                  text: TextSpan(
                    text: "Don't Have Account?",
                    style: TextStyle(
                      color: Color(0xFF545454),
                      fontSize: 14,
                      fontWeight: FontWeight.w400,
                    ),
                    children: [
                      TextSpan(
                        text: " Sign Up",
                        style: TextStyle(
                          color: Color(0xFF00A4BB),
                          fontSize: 14,
                          fontWeight: FontWeight.w400,
                        ),
                        recognizer: TapGestureRecognizer()
                          ..onTap = () {
                            Get.offNamed(AppRoutes.signupScreen);
                          },
                      ),
                    ],
                  ),
                ),
              ),

              SizedBox(height: 50),
              Center(
                child: Text(
                  "Or",
                  style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.w400,
                    color: AppColors.subTextColor,
                  ),
                ),
              ),

              SizedBox(height: 50),
              Container(
                width: double.infinity,
                height: 56,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(24),
                  color: Color(0xFFE6EBF0),
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    SvgPicture.asset('assets/icons/google.svg'),
                    SizedBox(width: 12),
                    Text(
                      "Continue with google",
                      style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.w500,
                        color: AppColors.textColor,
                      ),
                    ),
                  ],
                ),
              ),

              SizedBox(height: 16),
              Center(
                child: Text(
                  "Start with 7 day free trial",
                  style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.w400,
                    color: Color(0xFF00A4BB),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
