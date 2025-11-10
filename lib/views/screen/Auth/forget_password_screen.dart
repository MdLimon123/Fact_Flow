import 'package:fact_flow/views/base/custom_button.dart';
import 'package:fact_flow/views/base/custom_text_field.dart';
import 'package:fact_flow/views/screen/Auth/otp_verification_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';

class ForgetPasswordScreen extends StatefulWidget {
  const ForgetPasswordScreen({super.key});

  @override
  State<ForgetPasswordScreen> createState() => _ForgetPasswordScreenState();
}

class _ForgetPasswordScreenState extends State<ForgetPasswordScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          padding: EdgeInsets.symmetric(horizontal: 24, vertical: 28),
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
              SizedBox(height: 100),
              CustomButton(
                onTap: () {
                  Get.to(() => OtpVerificationScreen());
                },
                text: "Send Code",
              ),
            ],
          ),
        ),
      ),
    );
  }
}
