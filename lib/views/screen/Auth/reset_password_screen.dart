import 'package:fact_flow/views/base/custom_button.dart';
import 'package:fact_flow/views/base/custom_text_field.dart';
import 'package:fact_flow/views/screen/Auth/login_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:get/state_manager.dart';

class ResetPasswordScreen extends StatefulWidget {
  const ResetPasswordScreen({super.key});

  @override
  State<ResetPasswordScreen> createState() => _ResetPasswordScreenState();
}

class _ResetPasswordScreenState extends State<ResetPasswordScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
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
                "Set New \nPassword",
                style: TextStyle(
                  fontSize: 28,
                  fontWeight: FontWeight.w500,
                  color: Color(0xFF413E3E),
                ),
              ),
              SizedBox(height: 20),
              Text(
                "Your new password should be at least 8 characters long",
                style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.w400,
                  color: Color(0xFF413E3E),
                ),
              ),
              SizedBox(height: 40),
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
                hintText: "Enter confirm password",
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
              SizedBox(height: 100),
              CustomButton(
                onTap: () {
                  Get.to(() => LoginScreen());
                },
                text: "Save and Continue",
              ),
            ],
          ),
        ),
      ),
    );
  }
}
