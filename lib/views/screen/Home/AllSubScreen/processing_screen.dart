import 'package:fact_flow/utils/app_colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';

class ProcessingScreen extends StatefulWidget {
  const ProcessingScreen({super.key});

  @override
  State<ProcessingScreen> createState() => _ProcessingScreenState();
}

class _ProcessingScreenState extends State<ProcessingScreen>
    with SingleTickerProviderStateMixin {
  late final AnimationController _controller;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 2),
    )..repeat();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 20),
          child: Column(
            children: [
              Row(
                children: [
                  Image.asset(
                    'assets/image/app_logo.png',
                    width: 50,
                    height: 50,
                  ),
                  Spacer(),
                  buildCircleIcon('assets/icons/user.svg'),
                  SizedBox(width: 12),
                  buildCircleIcon('assets/icons/clock.svg'),
                ],
              ),

              SizedBox(height: 200),
              Center(
                child: RotationTransition(
                  turns: _controller,
                  child: Image.asset(
                    'assets/image/load_image.png',
                    width: 200,
                    height: 200,
                  ),
                ),
              ),
              SizedBox(height: 43),
              Text(
                "Please wait while the AI analyzes the content",

                style: TextStyle(
                  fontSize: 24,
                  fontWeight: FontWeight.w400,
                  color: AppColors.subTextColor,
                ),
                textAlign: TextAlign.center,
              ),
              SizedBox(height: 52),

              InkWell(
                onTap: () {
                  Navigator.pop(context);
                },
                child: Container(
                  width: double.infinity,
                  height: 54,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(24),
                    color: Color(0xFFE6EBF0),
                  ),
                  child: Center(
                    child: Text(
                      "Cancel",
                      style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.w400,
                        color: AppColors.textColor,
                      ),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget buildCircleIcon(String asset) {
    return Container(
      height: 36,
      width: 36,
      decoration: BoxDecoration(
        shape: BoxShape.circle,
        color: AppColors.backgroundColor,
        border: Border.all(color: Color(0xFFE6EBF0)),
        boxShadow: [
          BoxShadow(
            color: Color(0xFF000000).withValues(alpha: .1),
            blurRadius: 4,
            offset: Offset(0, 4),
          ),
        ],
      ),
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: SvgPicture.asset(asset),
      ),
    );
  }
}
