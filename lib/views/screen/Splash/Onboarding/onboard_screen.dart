import 'package:fact_flow/helpers/route.dart';
import 'package:fact_flow/utils/app_colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:get/instance_manager.dart';

class OnboardScreen extends StatefulWidget {
  const OnboardScreen({super.key});

  @override
  State<OnboardScreen> createState() => _OnboardScreenState();
}

class _OnboardScreenState extends State<OnboardScreen> {
  final PageController _pageController = PageController();
  int _currentPage = 0;

  final List<Map<String, String>> _onboardingData = [
    {
      "image": "assets/image/image1.png",
      "text": "Upload Any to Content to Begin",
      "subText":
          "Fact check articles, images, web links or text simply by uploading them to FackFlow",
    },
    {
      "image": "assets/image/image2.png",
      "text": "Ai Powered Verification",
      "subText":
          "FactFlow’s AI automatically scans articles, extracts factual claims and cross-references them with reliable sources.",
    },
    {
      "image": "assets/image/image3.png",
      "text": "Verified, Cited and Shareable",
      "subText":
          "FactFlow provides detailed results, include link to original sources, make it easy to share..",
    },
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Image.asset(
                        'assets/image/app_logo.png',
                        width: 50,
                        height: 50,
                      ),
                      Column(
                        // Wrap the text in a column to stack them vertically
                        children: [
                          Text(
                            "${_currentPage + 1} of 3",
                            style: TextStyle(
                              fontSize: 14,
                              fontWeight: FontWeight.w400,
                              color: Color(0xFF333333),
                            ),
                          ),
                          SizedBox(
                            height: 8,
                          ), // Add space between the text and the progress bar
                          Container(
                            width: 100,
                            child: LinearProgressIndicator(
                              value:
                                  (_currentPage + 1) / _onboardingData.length,
                              minHeight: 5,
                              backgroundColor: Color(0xFFE6EEF7),
                              borderRadius: BorderRadius.circular(8),
                              valueColor: AlwaysStoppedAnimation<Color>(
                                AppColors.primaryColor,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ],
              ),
            ),
            Expanded(
              child: PageView.builder(
                controller: _pageController,
                itemCount: _onboardingData.length,
                onPageChanged: (int page) {
                  setState(() {
                    _currentPage = page;
                  });
                },
                itemBuilder: (context, index) {
                  return SingleChildScrollView(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        SizedBox(height: 120),
                        Center(
                          child: Container(
                            height: 130,
                            width: 130,
                            decoration: BoxDecoration(
                              shape: BoxShape.circle,
                              image: DecorationImage(
                                image: AssetImage(
                                  _onboardingData[index]["image"] ?? "",
                                ),
                                fit: BoxFit.cover,
                              ),
                            ),
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.symmetric(
                            horizontal: 20,
                            vertical: 16,
                          ),
                          child: Text(
                            _onboardingData[index]["text"] ?? "",
                            textAlign: TextAlign.center,
                            style: TextStyle(
                              fontSize: 32,
                              fontWeight: FontWeight.w500,
                              color: AppColors.subTextColor,
                            ),
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 20),
                          child: Text(
                            _onboardingData[index]["subText"] ?? "",
                            textAlign: TextAlign.center,
                            style: TextStyle(
                              fontSize: 18,
                              fontWeight: FontWeight.w400,
                              color: AppColors.subTextColor,
                            ),
                          ),
                        ),
                      ],
                    ),
                  );
                },
              ),
            ),

            // Bottom Dots (Now with padding for positioning)
            Padding(
              padding: const EdgeInsets.only(
                bottom: 100,
              ), // 50px below the subText
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: List.generate(
                  _onboardingData.length,
                  (index) => Container(
                    margin: const EdgeInsets.symmetric(horizontal: 5),
                    height: 8,
                    width: 8,
                    decoration: BoxDecoration(
                      color: _currentPage == index ? Colors.blue : Colors.grey,
                      shape: BoxShape.circle,
                    ),
                  ),
                ),
              ),
            ),

            // Action Button (Next or Start)
            Padding(
              padding: const EdgeInsets.only(left: 40, right: 40, bottom: 100),
              child: GestureDetector(
                onTap: () {
                  if (_currentPage == _onboardingData.length - 1) {
                    Get.offNamed(AppRoutes.loginScreen);
                  } else {
                    _pageController.nextPage(
                      duration: const Duration(milliseconds: 300),
                      curve: Curves.easeIn,
                    );
                  }
                },
                child: Container(
                  height: 56,
                  width: _currentPage == _onboardingData.length - 1 ? 200 : 140,
                  alignment: Alignment.center,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(24),
                    color: AppColors.primaryColor,
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        _currentPage == _onboardingData.length - 1
                            ? "Get Start"
                            : "Next",
                        style: TextStyle(
                          color: AppColors.backgroundColor,
                          fontSize: 18,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                      SizedBox(width: 12),
                      Container(
                        height: 24,
                        width: 24,
                        decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          color: AppColors.backgroundColor,
                        ),
                        child: Padding(
                          padding: const EdgeInsets.all(5.0),
                          child: SvgPicture.asset('assets/icons/next.svg'),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
