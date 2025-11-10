import 'package:fact_flow/utils/app_colors.dart';
import 'package:fact_flow/views/base/custom_button.dart';
import 'package:fact_flow/views/screen/Home/home_screen.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/state_manager.dart';

class SubscriptionScreen extends StatefulWidget {
  const SubscriptionScreen({super.key});

  @override
  State<SubscriptionScreen> createState() => _SubscriptionScreenState();
}

class _SubscriptionScreenState extends State<SubscriptionScreen> {
  bool isYearly = true;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.backgroundColor,
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 20),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              /// --- Top Toggle Buttons ---
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Image.asset(
                    'assets/image/app_logo.png',
                    width: 50,
                    height: 50,
                  ),
                  Container(
                    decoration: BoxDecoration(
                      color: Color(0xFFE6EBF0).withValues(alpha: 0.50),
                      borderRadius: BorderRadius.circular(24),
                    ),
                    padding: const EdgeInsets.symmetric(
                      horizontal: 8,
                      vertical: 10,
                    ),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        _buildToggleButton("Monthly", !isYearly),
                        const SizedBox(width: 10),
                        _buildToggleButton("Yearly", isYearly),
                      ],
                    ),
                  ),
                ],
              ),

              const SizedBox(height: 25),

              /// --- Monthly & Yearly Cards (Both Visible) ---
              Column(
                children: [
                  _buildMonthlyCard(),
                  const SizedBox(height: 15),
                  _buildYearlyCard(),
                ],
              ),

              const SizedBox(height: 32),

              /// --- Features List ---
              Text(
                "Feature",
                style: TextStyle(
                  fontSize: 24,
                  fontWeight: FontWeight.w500,
                  color: AppColors.textColor,
                ),
              ),
              _buildFeatures(),

              const SizedBox(height: 30),

              Center(
                child: Text(
                  "Start 7 Day’s Free Trial",
                  style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.w400,
                    color: AppColors.textColor,
                  ),
                ),
              ),

              const SizedBox(height: 16),

              /// --- Buy Now Button ---
              CustomButton(
                onTap: () {
                  Get.to(() => HomeScreen());
                },
                text: "Buy Now",
              ),
            ],
          ),
        ),
      ),
    );
  }

  /// --- Toggle Button Builder ---
  Widget _buildToggleButton(String text, bool selected) {
    return GestureDetector(
      onTap: () {
        setState(() {
          isYearly = (text == "Yearly");
        });
      },
      child: Container(
        width: 100,
        padding: const EdgeInsets.symmetric(vertical: 10),
        decoration: BoxDecoration(
          color: selected ? Color(0xFF54C2D1) : Colors.transparent,
          borderRadius: BorderRadius.circular(24),
        ),
        alignment: Alignment.center,
        child: Text(
          text,
          style: TextStyle(
            color: selected ? Colors.white : AppColors.textColor,
            fontSize: 16,
            fontWeight: FontWeight.w400,
          ),
        ),
      ),
    );
  }

  /// --- Monthly Card ---
  Widget _buildMonthlyCard() {
    final bool selected = !isYearly;
    return GestureDetector(
      onTap: () {
        setState(() {
          isYearly = false;
        });
      },
      child: Container(
        padding: const EdgeInsets.all(20),
        width: double.infinity,
        decoration: BoxDecoration(
          color: selected
              ? Colors.teal.shade50
              : Color(0xFFE6EBF0).withValues(alpha: .50),
          borderRadius: BorderRadius.circular(16),
          border: Border.all(
            color: selected ? Colors.teal : Color(0xFFB0B0B0),
            width: selected ? 1 : 0.5,
          ),
          boxShadow: selected
              ? [
                  BoxShadow(
                    color: Color(0xFFB0B0B0).withValues(alpha: .2),
                    blurRadius: 3,
                    offset: const Offset(0, 3),
                  ),
                ]
              : [],
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: const [
            Text(
              "Monthly",
              style: TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.w400,
                color: Color(0xFF545454),
              ),
            ),
            SizedBox(height: 8),
            Text(
              "\$9.9 /mo",
              style: TextStyle(
                fontSize: 40,
                fontWeight: FontWeight.w400,
                color: Color(0xFF545454),
              ),
            ),
          ],
        ),
      ),
    );
  }

  /// --- Yearly Card ---
  Widget _buildYearlyCard() {
    final bool selected = isYearly;
    return GestureDetector(
      onTap: () {
        setState(() {
          isYearly = true;
        });
      },
      child: Container(
        padding: const EdgeInsets.all(20),
        decoration: BoxDecoration(
          color: selected
              ? Colors.teal.shade50
              : Color(0xFFE6EBF0).withValues(alpha: .50),
          borderRadius: BorderRadius.circular(16),
          border: Border.all(
            color: selected ? Colors.teal : Color(0xFFB0B0B0),
            width: selected ? 1 : 0.5,
          ),
          boxShadow: selected
              ? [
                  BoxShadow(
                    color: Color(0xFFB0B0B0).withValues(alpha: .2),
                    blurRadius: 3,
                    offset: const Offset(0, 3),
                  ),
                ]
              : [],
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                const Text(
                  "Yearly",
                  style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.w400,
                    color: Color(0xFF545454),
                  ),
                ),
                const SizedBox(width: 35),
                Container(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 8,
                    vertical: 4,
                  ),
                  decoration: BoxDecoration(
                    color: Color(0xFFD8AA2B),
                    borderRadius: BorderRadius.circular(100),
                  ),
                  child: const Text(
                    "Best Value",
                    style: TextStyle(
                      fontSize: 14,
                      color: Colors.white,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 8),
            const Text(
              "\$59.99 /yr",
              style: TextStyle(
                fontSize: 40,
                fontWeight: FontWeight.w400,
                color: Color(0xFF545454),
              ),
            ),
            const SizedBox(height: 4),
            const Text(
              "Just \$4.49 per month",
              style: TextStyle(
                color: Color(0xFF545454),
                fontSize: 16,
                fontWeight: FontWeight.w400,
              ),
            ),
          ],
        ),
      ),
    );
  }

  /// --- Features List ---
  Widget _buildFeatures() {
    final features = [
      "Unlimited fact check",
      "Upload text, pdf, jpg, png",
      "AI evidence verification",
      "History Access",
      "Share Card / PDF",
    ];

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: features
          .map(
            (f) => Padding(
              padding: const EdgeInsets.symmetric(vertical: 6),
              child: Row(
                children: [
                  const Icon(Icons.circle, color: Color(0xFF00A4BB), size: 12),
                  const SizedBox(width: 10),
                  Text(
                    f,
                    style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.w400,
                      color: AppColors.textColor,
                    ),
                  ),
                ],
              ),
            ),
          )
          .toList(),
    );
  }
}
