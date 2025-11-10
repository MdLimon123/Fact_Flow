import 'package:fact_flow/helpers/route.dart';
import 'package:fact_flow/utils/app_colors.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';


class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    Future.delayed(Duration(seconds: 5), () {
      Get.offNamed(AppRoutes.onboardScreen);
    });

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.backgroundColor,
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Center(
            child: Image.asset(
              'assets/image/app_logo.png',
              width: 190,
              height: 150,
            ),
          ),

          Text(
            "Verify, Truth, Instantly",
            style: TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.w400,
              color: AppColors.textColor,
            ),
          ),
        ],
      ),
    );
  }
}
