import 'package:fact_flow/controllers/auth_controller.dart';
import 'package:fact_flow/views/base/custom_button.dart';
import 'package:fact_flow/views/base/custom_text_field.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';

class ForgetPasswordScreen extends StatefulWidget {
  const ForgetPasswordScreen({super.key});

  @override
  State<ForgetPasswordScreen> createState() => _ForgetPasswordScreenState();
}

class _ForgetPasswordScreenState extends State<ForgetPasswordScreen> {
  final _authController = Get.put(AuthController());
  final emailController = TextEditingController();

  final _fromKey = GlobalKey<FormState>();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          padding: EdgeInsets.symmetric(horizontal: 24, vertical: 28),
          child: Form(
            key: _fromKey,
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
                  controller: emailController,
                  hintText: "Enter your email",
                  validator: (value) {
                    if (value!.isEmpty) {
                      return "Please enter your email";
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
                      child: SvgPicture.asset('assets/icons/phone.svg'),
                    ),
                  ),
                ),
                SizedBox(height: 100),
                Obx(
                  () => CustomButton(
                    loading: _authController.isForgetLoading.value,
                    onTap: () {
                      if (_fromKey.currentState!.validate()) {
                        _authController.forgetPassword(
                          email: emailController.text.trim(),
                        );
                      }
                    },
                    text: "Send Code",
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
