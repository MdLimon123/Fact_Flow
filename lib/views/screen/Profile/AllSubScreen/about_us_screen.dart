
import 'package:fact_flow/utils/app_colors.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class AboutUsScreen extends StatefulWidget {
  const AboutUsScreen({super.key});

  @override
  State<AboutUsScreen> createState() => _AboutUsScreenState();
}

class _AboutUsScreenState extends State<AboutUsScreen> {
final String text =
      "FactFlow is a mobile application designed to streamline the process of fact-checking content from text, URLs, PDFs, and images. The app extracts key claims from the content and generates a detailed report with the claim and conclusion, with a confidence score. The report also highlights counterevidence, extracts relevant quotes, and allows for easy sharing via social media, PDFs, or share cards. FactFlow aims to help users quickly and efficiently verify the accuracy of online information, providing a reliable tool for journalists, educators, community moderators, and anyone working to combat misinformation.";

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
                    "About Us",
                    style: TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.w500,
                      color: AppColors.subTextColor,
                    ),
                  ),
                ],
              ),
              SizedBox(height: 32),
              Image.asset('assets/image/app_logo.png', width: 50, height: 50),
              SizedBox(height: 16),
              Expanded(
                child: ListView(
                  children: [
                    Text(
                      text,
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.w400,
                        color: Color(0xFF696767),
                      ),
                    ),
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