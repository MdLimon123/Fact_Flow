import 'package:fact_flow/controllers/ai_chat_result_controller.dart';
import 'package:fact_flow/utils/app_colors.dart';
import 'package:fact_flow/views/screen/History/history_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';

class AiResultScreen extends StatefulWidget {
  const AiResultScreen({super.key});

  @override
  State<AiResultScreen> createState() => _AiResultScreenState();
}

class _AiResultScreenState extends State<AiResultScreen> {
  final _aiChatResultController = Get.put(AiChatResultController());

  final double confidence = 70;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.backgroundColor,
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
                  buildCircleIcon('assets/icons/user.svg', () {}),
                  SizedBox(width: 12),
                  buildCircleIcon('assets/icons/clock.svg', () {
                    Get.to(() => HistoryScreen());
                  }),
                ],
              ),

              SizedBox(height: 20),
              Expanded(
                child: ListView(
                  children: [
                    Container(
                      width: double.infinity,

                      padding: EdgeInsets.symmetric(
                        horizontal: 20,
                        vertical: 16,
                      ),
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(16),
                        color: Colors.white,
                        boxShadow: [
                          BoxShadow(
                            color: Colors.black.withValues(alpha: 0.04),
                            blurRadius: 4,
                            offset: Offset(0, 4),
                          ),
                        ],
                      ),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            "VERDICT",
                            style: TextStyle(
                              fontSize: 14,
                              fontWeight: FontWeight.w400,
                              color: AppColors.subTextColor,
                            ),
                          ),
                          SizedBox(height: 12),
                          Column(
                            mainAxisAlignment: MainAxisAlignment.start,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                crossAxisAlignment: CrossAxisAlignment
                                    .start, // Ensure the row spaces the children
                                children: [
                                  Container(
                                    width: 112,
                                    padding: EdgeInsets.symmetric(
                                      horizontal: 10,
                                    ),
                                    height: 36,
                                    decoration: BoxDecoration(
                                      color: Color(0xFFD3F4DE),
                                      borderRadius: BorderRadius.circular(12),
                                    ),
                                    child: Row(
                                      children: [
                                        SvgPicture.asset(
                                          'assets/icons/true.svg', // Adjust path if needed
                                        ),
                                        SizedBox(width: 12),
                                        Text(
                                          "TRUE",
                                          style: TextStyle(
                                            fontSize: 18,
                                            fontWeight: FontWeight.w600,
                                            color: Color(0xFF1AA146),
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                  SizedBox(
                                    width: 105,
                                    height: 105,
                                    child: Stack(
                                      children: [
                                        SizedBox.expand(
                                          // <--- WRAP IT HERE
                                          child: CircularProgressIndicator(
                                            value: confidence / 100,
                                            strokeWidth: 5,
                                            backgroundColor: Colors.grey[300],
                                            valueColor:
                                                AlwaysStoppedAnimation<Color>(
                                                  Color(0xFF33B6C9),
                                                ),
                                          ),
                                        ),

                                        Positioned(
                                          top: 25,
                                          left: 30,
                                          child: Text(
                                            '${confidence.toInt()}%',
                                            style: TextStyle(
                                              fontSize: 24,
                                              fontWeight: FontWeight.w600,
                                              color: AppColors.textColor,
                                            ),
                                          ),
                                        ),
                                        Positioned(
                                          top: 60,
                                          left: 30,
                                          child: Text(
                                            "Confident",
                                            style: TextStyle(
                                              fontSize: 12,
                                              fontWeight: FontWeight.w400,
                                              color: AppColors.subTextColor,
                                            ),
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                ],
                              ),
                              SizedBox(height: 12),
                              Text(
                                "CLAIM",
                                style: TextStyle(
                                  fontSize: 14,
                                  fontWeight: FontWeight.w400,
                                  color: AppColors.subTextColor,
                                ),
                              ),
                              SizedBox(height: 12),
                              Text(
                                "FactFlow’s AI automatically scans articles, extracts factual claims and cross-references them with reliable sources.",
                                style: TextStyle(
                                  fontSize: 16,
                                  fontWeight: FontWeight.w400,
                                  color: AppColors.textColor,
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),

                    SizedBox(height: 12),

                    /// conclusion
                    Obx(() {
                      return InkWell(
                        onTap: () {
                          _aiChatResultController.toggleExpansion(0);
                        },
                        child: Container(
                          width: double.infinity,

                          padding: EdgeInsets.symmetric(
                            horizontal: 20,
                            vertical: 16,
                          ),
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(16),
                            color: Colors.white,
                            boxShadow: [
                              BoxShadow(
                                color: Colors.black.withValues(alpha: 0.04),
                                blurRadius: 4,
                                offset: Offset(0, 4),
                              ),
                            ],
                          ),
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.start,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Row(
                                children: [
                                  Text(
                                    "CONCLUSION",
                                    style: TextStyle(
                                      fontSize: 14,
                                      fontWeight: FontWeight.w400,
                                      color: AppColors.subTextColor,
                                    ),
                                  ),
                                  Spacer(),
                                  AnimatedRotation(
                                    duration: Duration(milliseconds: 100),
                                    turns: _aiChatResultController.isExpanded[0]
                                        ? 0.5
                                        : 0,
                                    child: Icon(
                                      Icons.keyboard_arrow_down,
                                      color: Colors.black,
                                    ),
                                  ),
                                ],
                              ),
                              SizedBox(height: 12),
                              Obx(() {
                                return AnimatedSize(
                                  duration: Duration(milliseconds: 300),
                                  curve: Curves.easeInOut,
                                  child: _aiChatResultController.isExpanded[0]
                                      ? Column(
                                          mainAxisAlignment:
                                              MainAxisAlignment.start,
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          children: [
                                            Text(
                                              "FactFlow’s AI automatically scans articles, extracts factual claims and cross-references them with reliable sources.",
                                              style: TextStyle(
                                                fontSize: 16,
                                                fontWeight: FontWeight.w400,
                                                color: AppColors.textColor,
                                              ),
                                            ),
                                          ],
                                        )
                                      : SizedBox(
                                          width: double.infinity,
                                          height: 0,
                                        ),
                                );
                              }),
                            ],
                          ),
                        ),
                      );
                    }),

                    SizedBox(height: 12),

                    /// evidence
                    Obx(() {
                      return InkWell(
                        onTap: () {
                          _aiChatResultController.toggleExpansion(1);
                        },
                        child: Container(
                          width: double.infinity,

                          padding: EdgeInsets.symmetric(
                            horizontal: 20,
                            vertical: 16,
                          ),
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(16),
                            color: Colors.white,
                            boxShadow: [
                              BoxShadow(
                                color: Colors.black.withValues(alpha: 0.04),
                                blurRadius: 4,
                                offset: Offset(0, 4),
                              ),
                            ],
                          ),
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.start,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Row(
                                children: [
                                  Text(
                                    "EVIDENCE",
                                    style: TextStyle(
                                      fontSize: 14,
                                      fontWeight: FontWeight.w400,
                                      color: AppColors.subTextColor,
                                    ),
                                  ),
                                  Spacer(),
                                  AnimatedRotation(
                                    duration: Duration(milliseconds: 100),
                                    turns: _aiChatResultController.isExpanded[1]
                                        ? 0.5
                                        : 0,
                                    child: Icon(
                                      Icons.keyboard_arrow_down,
                                      color: Colors.black,
                                    ),
                                  ),
                                ],
                              ),
                              SizedBox(height: 12),

                              Obx(() {
                                return AnimatedSize(
                                  duration: Duration(milliseconds: 300),
                                  curve: Curves.easeInOut,
                                  child: _aiChatResultController.isExpanded[1]
                                      ? Column(
                                          mainAxisAlignment:
                                              MainAxisAlignment.start,
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          children: [
                                            Text(
                                              "Supporting Evidence",
                                              style: TextStyle(
                                                fontSize: 16,
                                                fontWeight: FontWeight.w500,
                                                color: AppColors.textColor,
                                              ),
                                            ),
                                            SizedBox(height: 8),
                                            Text(
                                              "FactFlow’s AI automatically scans articles, extracts factual claims and cross-references them with reliable sources.",
                                              style: TextStyle(
                                                fontSize: 14,
                                                fontWeight: FontWeight.w400,
                                                color: AppColors.textColor,
                                              ),
                                            ),
                                            SizedBox(height: 20),
                                            Text(
                                              "Quotes from Source",
                                              style: TextStyle(
                                                fontSize: 16,
                                                fontWeight: FontWeight.w500,
                                                color: AppColors.textColor,
                                              ),
                                            ),
                                            SizedBox(height: 8),
                                            Container(
                                              width: double.infinity,
                                              padding: EdgeInsets.symmetric(
                                                horizontal: 16,
                                                vertical: 16,
                                              ),
                                              decoration: BoxDecoration(
                                                color: Color(
                                                  0xFFE6F6F8,
                                                ).withValues(alpha: 0.50),
                                                borderRadius:
                                                    BorderRadius.circular(8),
                                              ),
                                              child: Column(
                                                children: [
                                                  Text(
                                                    "“The Data is unequivocal and supports the conclusion that...”",
                                                    style: TextStyle(
                                                      fontSize: 14,
                                                      fontWeight:
                                                          FontWeight.w400,
                                                      color: AppColors
                                                          .subTextColor,
                                                    ),
                                                  ),
                                                  SizedBox(height: 10),
                                                  Align(
                                                    alignment:
                                                        Alignment.centerRight,
                                                    child: Text(
                                                      "Dr. Evalen Rayed",
                                                      style: TextStyle(
                                                        fontSize: 14,
                                                        fontWeight:
                                                            FontWeight.w400,
                                                        color: AppColors
                                                            .subTextColor,
                                                      ),
                                                    ),
                                                  ),
                                                ],
                                              ),
                                            ),
                                            SizedBox(height: 20),
                                            Text(
                                              "Counter Evidence",
                                              style: TextStyle(
                                                fontSize: 16,
                                                fontWeight: FontWeight.w500,
                                                color: AppColors.textColor,
                                              ),
                                            ),
                                            SizedBox(height: 8),
                                            Text(
                                              "No significant counter-evidence was found our analysis.",
                                              style: TextStyle(
                                                fontSize: 14,
                                                fontWeight: FontWeight.w400,
                                                color: AppColors.subTextColor,
                                              ),
                                            ),
                                          ],
                                        )
                                      : SizedBox(
                                          width: double.infinity,
                                          height: 0,
                                        ),
                                );
                              }),
                            ],
                          ),
                        ),
                      );
                    }),

                    /// contitations
                    SizedBox(height: 12),
                    Obx(() {
                      return InkWell(
                        onTap: () {
                          _aiChatResultController.toggleExpansion(2);
                        },
                        child: Container(
                          width: double.infinity,

                          padding: EdgeInsets.symmetric(
                            horizontal: 20,
                            vertical: 16,
                          ),
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(16),
                            color: Colors.white,
                            boxShadow: [
                              BoxShadow(
                                color: Colors.black.withValues(alpha: 0.04),
                                blurRadius: 4,
                                offset: Offset(0, 4),
                              ),
                            ],
                          ),
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.start,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Row(
                                children: [
                                  Text(
                                    "CITITATIONS",
                                    style: TextStyle(
                                      fontSize: 14,
                                      fontWeight: FontWeight.w400,
                                      color: AppColors.subTextColor,
                                    ),
                                  ),
                                  Spacer(),
                                  AnimatedRotation(
                                    duration: Duration(milliseconds: 100),
                                    turns: _aiChatResultController.isExpanded[2]
                                        ? 0.5
                                        : 0,
                                    child: Icon(
                                      Icons.keyboard_arrow_down,
                                      color: Colors.black,
                                    ),
                                  ),
                                ],
                              ),
                              SizedBox(height: 12),

                              Obx(() {
                                return AnimatedSize(
                                  duration: Duration(milliseconds: 300),
                                  curve: Curves.easeInOut,
                                  child: _aiChatResultController.isExpanded[2]
                                      ? Column(
                                          mainAxisAlignment:
                                              MainAxisAlignment.start,
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          children: [
                                            Text(
                                              "Global Health Institute - “Annual Health Report 2025”",
                                              style: TextStyle(
                                                fontSize: 14,
                                                fontWeight: FontWeight.w400,
                                                color: AppColors.subTextColor,
                                              ),
                                            ),
                                            SizedBox(height: 4),
                                            Text(
                                              "globalhealth.org/study-results",
                                              style: TextStyle(
                                                fontSize: 14,
                                                fontWeight: FontWeight.w400,
                                                color: Color(0xFF1180FF),
                                              ),
                                            ),
                                            SizedBox(height: 16),
                                            Text(
                                              "National Statistics Bureau -“Economic Data Release”",
                                              style: TextStyle(
                                                fontSize: 14,
                                                fontWeight: FontWeight.w400,
                                                color: AppColors.subTextColor,
                                              ),
                                            ),

                                            SizedBox(height: 4),
                                            Text(
                                              "data.gov/report-xyz",
                                              style: TextStyle(
                                                fontSize: 14,
                                                fontWeight: FontWeight.w400,
                                                color: Color(0xFF1180FF),
                                              ),
                                            ),
                                          ],
                                        )
                                      : SizedBox(
                                          width: double.infinity,
                                          height: 0,
                                        ),
                                );
                              }),
                            ],
                          ),
                        ),
                      );
                    }),
                  ],
                ),
              ),

              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Column(
                    children: [
                      Padding(
                        padding: const EdgeInsets.all(5.0),
                        child: SvgPicture.asset('assets/icons/share.svg'),
                      ),

                      Text(
                        "Share Card",
                        style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.w400,
                          color: AppColors.subTextColor,
                        ),
                      ),
                    ],
                  ),
                  Column(
                    children: [
                      Padding(
                        padding: const EdgeInsets.all(5.0),
                        child: SvgPicture.asset('assets/icons/download.svg'),
                      ),

                      Text(
                        "Download PDF",
                        style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.w400,
                          color: AppColors.subTextColor,
                        ),
                      ),
                    ],
                  ),
                  Column(
                    children: [
                      Padding(
                        padding: const EdgeInsets.all(5.0),
                        child: SvgPicture.asset('assets/icons/save.svg'),
                      ),

                      Text(
                        "Save History",
                        style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.w400,
                          color: AppColors.subTextColor,
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget buildCircleIcon(String asset, Function()? onTap) {
    return InkWell(
      onTap: onTap,
      child: Container(
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
      ),
    );
  }
}
