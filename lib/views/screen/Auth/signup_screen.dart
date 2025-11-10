import 'package:fact_flow/helpers/route.dart';
import 'package:fact_flow/utils/app_colors.dart';
import 'package:fact_flow/views/base/custom_button.dart';
import 'package:fact_flow/views/base/custom_text_field.dart';
import 'package:fact_flow/views/screen/Auth/email_verification_screen.dart';
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
  bool isAgree = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.backgroundColor,
      body: SafeArea(
        child: SingleChildScrollView(
          padding: EdgeInsets.symmetric(horizontal: 20, vertical: 20),
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
              SizedBox(height: 20),
              CustomTextField(
                isPassword: true,
                hintText: "Confirm password",
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
                  Checkbox(
                    value: isAgree,
                    onChanged: (value) {
                      setState(() {
                        isAgree = value ?? false;
                      });
                    },
                    activeColor: AppColors.primaryColor,
                    side: BorderSide(color: Color(0xFF676565)),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(4),
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
              CustomButton(
                onTap: () {
                  Get.to(() => EmailVerificationScreen());
                },
                text: "Agree And Continue",
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
                            Get.offNamed(AppRoutes.signupScreen);
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
    );
  }
}
