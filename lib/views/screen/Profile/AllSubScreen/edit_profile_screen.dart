import 'package:fact_flow/utils/app_colors.dart';
import 'package:fact_flow/views/base/custom_button.dart';
import 'package:fact_flow/views/base/custom_text_field.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/route_manager.dart';

class EditProfileScreen extends StatefulWidget {
  const EditProfileScreen({super.key});

  @override
  State<EditProfileScreen> createState() => _EditProfileScreenState();
}

class _EditProfileScreenState extends State<EditProfileScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.backgroundColor,
      body: SafeArea(
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 20, vertical: 16),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  InkWell(
                    onTap: () {
                      Get.back();
                    },
                    child: Icon(Icons.arrow_back, color: Color(0xFF0D1C12)),
                  ),
                  SizedBox(width: 12),
                  Text(
                    "Edit Prifle",
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
                    Stack(
                      alignment: Alignment.center,
                      children: [
                        Container(
                          height: 160,
                          width: 160,
                          decoration: BoxDecoration(shape: BoxShape.circle),
                          child: Image.asset(
                            'assets/image/dummy.png',
                            fit: BoxFit.cover,
                          ),
                        ),
                        Positioned(
                          child: SvgPicture.asset(
                            'assets/icons/image_fram.svg',
                          ),
                        ),
                      ],
                    ),
                    SizedBox(height: 40),
                    CustomTextField(
                      isEmail: true,
                      hintText: "Mark Wood",
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
                          child: SvgPicture.asset('assets/icons/fill.svg'),
                        ),
                      ),
                    ),
                    SizedBox(height: 80),
                    CustomButton(onTap: () {}, text: "Save"),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
