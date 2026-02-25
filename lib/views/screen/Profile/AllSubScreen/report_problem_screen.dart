import 'package:fact_flow/controllers/profile_controller.dart';
import 'package:fact_flow/utils/app_colors.dart';
import 'package:fact_flow/views/base/custom_button.dart';
import 'package:fact_flow/views/base/custom_text_field.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class ReportProblemScreen extends StatefulWidget {
  const ReportProblemScreen({super.key});

  @override
  State<ReportProblemScreen> createState() => _ReportProblemScreenState();
}

class _ReportProblemScreenState extends State<ReportProblemScreen> {
  final _fromKey = GlobalKey<FormState>();

  final nameController = TextEditingController();
  final emailController = TextEditingController();

  final commnetController = TextEditingController();

  final _profileController = Get.put(ProfileController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.backgroundColor,
      body: SafeArea(
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
                    "Report a Problem",
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
                child: Form(
                  key: _fromKey,
                  child: ListView(
                    children: [
                      CustomTextField(
                        controller: nameController,
                        hintText: "Enter your name",
                        validator: (value) {
                          if (value!.isEmpty) {
                            return "Please enter your name";
                          }
                          return null;
                        },
                      ),
                      SizedBox(height: 16),
                      CustomTextField(
                        controller: emailController,
                        hintText: "Enter your mail or phone number",
                        validator: (value) {
                          if (value!.isEmpty) {
                            return "Please enter your email or number";
                          }
                          return null;
                        },
                      ),
                      SizedBox(height: 16),
                      Container(
                        width: double.infinity,
                        padding: EdgeInsets.symmetric(
                          horizontal: 20,
                          vertical: 16,
                        ),
                        decoration: BoxDecoration(
                          color: AppColors.backgroundColor,
                          borderRadius: BorderRadius.circular(24),
                          boxShadow: [
                            BoxShadow(
                              color: Colors.black.withValues(alpha: 0.08),
                              blurRadius: 4,
                              offset: Offset(0, 4),
                            ),
                          ],
                          border: Border.all(
                            color: Color(0xFFE6E6E6),
                            width: 0.5,
                          ),
                        ),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.start,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              "Comment",
                              style: TextStyle(
                                fontSize: 16,
                                fontWeight: FontWeight.w400,
                                color: AppColors.subTextColor,
                              ),
                            ),
                            SizedBox(height: 8),
                            TextFormField(
                              controller: commnetController,
                              minLines: 2,
                              maxLines: 2,
                              validator: (value) {
                                if (value!.isEmpty) {
                                  return "Please enter your comment";
                                }
                                return null;
                              },
                              decoration: InputDecoration(
                                hint: Text(
                                  'Write your comment',
                                  style: TextStyle(
                                    fontSize: 14,
                                    fontWeight: FontWeight.w400,
                                    color: Color(0xFF807E7E),
                                  ),
                                ),
                                fillColor: Color(0xFFE6F6F8),
                                filled: true,
                                border: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(12),
                                  borderSide: BorderSide(
                                    color: Color(0xFFE6F6F8),
                                  ),
                                ),
                                enabledBorder: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(12),
                                  borderSide: BorderSide(
                                    color: Color(0xFFE6F6F8),
                                  ),
                                ),
                                focusedBorder: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(12),
                                  borderSide: BorderSide(
                                    color: Color(0xFFE6F6F8),
                                  ),
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                      SizedBox(height: 93),
                      Obx(
                        () => CustomButton(
                          loading: _profileController.isLaoding.value,
                          onTap: () {
                            if (_fromKey.currentState!.validate()) {
                              _profileController.submitComment(
                                name: nameController.text.trim(),
                                email: emailController.text.trim(),
                                commnet: commnetController.text.trim(),
                              );
                            }
                          },
                          text: "Submit Now",
                        ),
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
