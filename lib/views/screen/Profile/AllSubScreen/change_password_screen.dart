import 'package:fact_flow/controllers/profile_controller.dart';
import 'package:fact_flow/utils/app_colors.dart';
import 'package:fact_flow/views/base/custom_button.dart';
import 'package:fact_flow/views/base/custom_text_field.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';

class ChangePasswordScreen extends StatefulWidget {
  const ChangePasswordScreen({super.key});

  @override
  State<ChangePasswordScreen> createState() => _ChangePasswordScreenState();
}

class _ChangePasswordScreenState extends State<ChangePasswordScreen> {
  final _profileController = Get.put(ProfileController());

  final oldPasswordController = TextEditingController();
  final newPasswordController = TextEditingController();
  final confirmPasswordController = TextEditingController();
  final _fromKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.backgroundColor,
      body: SafeArea(
        child: Form(
          key: _fromKey,
          child: Padding(
            padding: EdgeInsets.symmetric(horizontal: 20, vertical: 16),
            child: Column(
              children: [
                Row(
                  children: [
                    InkWell(
                      onTap: () {
                          Navigator.pop(context);
                      },
                      child: Icon(Icons.arrow_back, color: Color(0xFF0D1C12)),
                    ),
                    SizedBox(width: 12),
                    Text(
                      "Change Password",
                      style: TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.w500,
                        color: AppColors.subTextColor,
                      ),
                    ),
                  ],
                ),

                SizedBox(height: 32),
                Expanded(
                  child: ListView(
                    children: [
                      CustomTextField(
                        isPassword: true,
                        controller: oldPasswordController,
                        hintText: "Enter old password",
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
                      SizedBox(height: 16),
                      CustomTextField(
                        controller: newPasswordController,
                        isPassword: true,
                        hintText: "Enter new password",
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
                      SizedBox(height: 16),
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
                      SizedBox(height: 80),
                      Obx(
                        () => CustomButton(
                          loading:
                              _profileController.changePasswordLoading.value,
                          onTap: () {
                            if (_fromKey.currentState!.validate()) {
                              _profileController.changePassword(
                                oldPassword: oldPasswordController.text.trim(),
                                newPassword: newPasswordController.text.trim(),
                              );
                            }
                          },
                          text: "Save",
                        ),
                      ),
                    ],
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
