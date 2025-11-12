import 'package:fact_flow/controllers/history_controller.dart';
import 'package:fact_flow/utils/app_colors.dart';
import 'package:fact_flow/views/screen/History/TabWidgets/tabs_widget_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:get/get_core/get_core.dart';

class HistoryScreen extends StatefulWidget {
  const HistoryScreen({super.key});

  @override
  State<HistoryScreen> createState() => _HistoryScreenState();
}

class _HistoryScreenState extends State<HistoryScreen> {
  final _historyController = Get.put(HistoryController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.backgroundColor,
      body: SafeArea(
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 20, vertical: 26),
          child: Column(
            children: [
              
              Row(
                children: [
                  InkWell(
                    onTap: () {
                      Get.back();
                    },
                    child: Icon(Icons.arrow_back, color: Color(0xFF0D1C12)),
                  ),
                  SizedBox(width: 20),
                  Text(
                    "History",
                    style: TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.w500,
                      color: AppColors.subTextColor,
                    ),
                  ),
                  Spacer(),
                  buildCircleIcon('assets/icons/user.svg'),
                ],
              ),
            
              SizedBox(height: 20),
              SizedBox(
                height: 36,
                child: ListView.builder(
                  scrollDirection: Axis.horizontal,
                  shrinkWrap: true,
                  itemCount: _historyController.tabList.length,
                  itemBuilder: (context, index) {
                    return Obx(
                      () => TabsWidgetScreen(
                        onTap: () {
                          _historyController.tabIndex.value = index;
                        },
                        isSelected: _historyController.isTabSelected(index),
                        tabName: _historyController.tabList[index],
                      ),
                    );
                  },
                ),
              ),

              SizedBox(height: 24),

              Expanded(
                child: Obx(() {
                  final index = _historyController.tabIndex.value;

                  switch (index) {
                    case 0:
                      return buildTrueList();
                    case 1:
                      return buildFalseList();
                    case 2:
                      return buildMixList();
                    case 3:
                      return buildCalendarList();
                    default:
                      return const SizedBox.shrink();
                  }
                }),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget buildTrueList() {
    return ListView.separated(
      physics: AlwaysScrollableScrollPhysics(),
      shrinkWrap: true,
      itemBuilder: (context, index) {
        return Container(
          width: double.infinity,
          padding: EdgeInsets.symmetric(horizontal: 16, vertical: 20),
          decoration: BoxDecoration(
            color: Color(0xFFFFFFFF),
            borderRadius: BorderRadius.circular(16),
            border: Border.all(
              color: Color(0xFFE6EBF0).withValues(alpha: 0.50),
            ),
            boxShadow: [
              BoxShadow(
                color: Colors.black.withValues(alpha: 0.02),
                blurRadius: 2,
                offset: Offset(0, 4),
              ),
            ],
          ),
          child: Column(
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Container(
                    height: 30,
                    width: 62,
                    decoration: BoxDecoration(
                      color: Color(0xFFD3F4DE).withValues(alpha: 0.50),

                      borderRadius: BorderRadius.circular(12),
                    ),
                    child: Center(
                      child: Text(
                        "True",
                        style: TextStyle(
                          fontSize: 14,
                          fontWeight: FontWeight.w400,
                          color: Color(0xFF1AA146),
                        ),
                      ),
                    ),
                  ),
                  Text(
                    "Checked: Nov 15, 2025",
                    style: TextStyle(
                      fontSize: 14,
                      fontWeight: FontWeight.w400,
                      color: AppColors.subTextColor,
                    ),
                  ),
                  SvgPicture.asset('assets/icons/delete.svg'),
                ],
              ),
              SizedBox(height: 12),
              Text(
                "Calim: FactFlow’s AI automatically scans articles, extracts factual claims and cross-references them with reliable sources.",

                style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.w400,
                  color: AppColors.subTextColor,
                ),
              ),
            ],
          ),
        );
      },
      separatorBuilder: (_, _) => SizedBox(height: 12),
      itemCount: 10,
    );
  }

  /// 🔴 False Tab List
  Widget buildFalseList() {
    return ListView.separated(
      physics: AlwaysScrollableScrollPhysics(),
      shrinkWrap: true,
      itemBuilder: (context, index) {
        return Container(
          width: double.infinity,
          padding: EdgeInsets.symmetric(horizontal: 16, vertical: 20),
          decoration: BoxDecoration(
            color: Color(0xFFFFFFFF),
            borderRadius: BorderRadius.circular(16),
            border: Border.all(
              color: Color(0xFFE6EBF0).withValues(alpha: 0.50),
            ),
            boxShadow: [
              BoxShadow(
                color: Colors.black.withValues(alpha: 0.02),
                blurRadius: 2,
                offset: Offset(0, 4),
              ),
            ],
          ),
          child: Column(
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Container(
                    height: 30,
                    width: 62,
                    decoration: BoxDecoration(
                      color: Color(0xFFF8C1C1).withValues(alpha: 0.50),

                      borderRadius: BorderRadius.circular(12),
                    ),
                    child: Center(
                      child: Text(
                        "False",
                        style: TextStyle(
                          fontSize: 14,
                          fontWeight: FontWeight.w400,
                          color: Color(0xFFC93C2A),
                        ),
                      ),
                    ),
                  ),
                  Text(
                    "Checked: Nov 15, 2025",
                    style: TextStyle(
                      fontSize: 14,
                      fontWeight: FontWeight.w400,
                      color: AppColors.subTextColor,
                    ),
                  ),
                  SvgPicture.asset('assets/icons/delete.svg'),
                ],
              ),
              SizedBox(height: 12),
              Text(
                "Calim: FactFlow’s AI automatically scans articles, extracts factual claims and cross-references them with reliable sources.",

                style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.w400,
                  color: AppColors.subTextColor,
                ),
              ),
            ],
          ),
        );
      },
      separatorBuilder: (_, _) => SizedBox(height: 12),
      itemCount: 10,
    );
  }

  /// 🟡 Mix Tab List
  Widget buildMixList() {
    return ListView.separated(
      physics: AlwaysScrollableScrollPhysics(),
      shrinkWrap: true,
      itemBuilder: (context, index) {
        return Container(
          width: double.infinity,
          padding: EdgeInsets.symmetric(horizontal: 16, vertical: 20),
          decoration: BoxDecoration(
            color: Color(0xFFFFFFFF),
            borderRadius: BorderRadius.circular(16),
            border: Border.all(
              color: Color(0xFFE6EBF0).withValues(alpha: 0.50),
            ),
            boxShadow: [
              BoxShadow(
                color: Colors.black.withValues(alpha: 0.02),
                blurRadius: 2,
                offset: Offset(0, 4),
              ),
            ],
          ),
          child: Column(
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Container(
                    height: 30,
                    width: 62,
                    decoration: BoxDecoration(
                      color: Color(0xFFD3F4DE).withValues(alpha: 0.50),

                      borderRadius: BorderRadius.circular(12),
                    ),
                    child: Center(
                      child: Text(
                        "True",
                        style: TextStyle(
                          fontSize: 14,
                          fontWeight: FontWeight.w400,
                          color: Color(0xFF1AA146),
                        ),
                      ),
                    ),
                  ),
                  Text(
                    "Checked: Nov 15, 2025",
                    style: TextStyle(
                      fontSize: 14,
                      fontWeight: FontWeight.w400,
                      color: AppColors.subTextColor,
                    ),
                  ),
                  SvgPicture.asset('assets/icons/delete.svg'),
                ],
              ),
              SizedBox(height: 12),
              Text(
                "Calim: FactFlow’s AI automatically scans articles, extracts factual claims and cross-references them with reliable sources.",

                style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.w400,
                  color: AppColors.subTextColor,
                ),
              ),
            ],
          ),
        );
      },
      separatorBuilder: (_, _) => SizedBox(height: 12),
      itemCount: 10,
    );
  }

  /// 🔵 Calendar Tab List
  Widget buildCalendarList() {
    return ListView.separated(
      physics: AlwaysScrollableScrollPhysics(),
      shrinkWrap: true,
      itemBuilder: (context, index) {
        return Container(
          width: double.infinity,
          padding: EdgeInsets.symmetric(horizontal: 16, vertical: 20),
          decoration: BoxDecoration(
            color: Color(0xFFFFFFFF),
            borderRadius: BorderRadius.circular(16),
            border: Border.all(
              color: Color(0xFFE6EBF0).withValues(alpha: 0.50),
            ),
            boxShadow: [
              BoxShadow(
                color: Colors.black.withValues(alpha: 0.02),
                blurRadius: 2,
                offset: Offset(0, 4),
              ),
            ],
          ),
          child: Column(
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Container(
                    height: 30,
                    width: 62,
                    decoration: BoxDecoration(
                      color: Color(0xFFD3F4DE).withValues(alpha: 0.50),

                      borderRadius: BorderRadius.circular(12),
                    ),
                    child: Center(
                      child: Text(
                        "True",
                        style: TextStyle(
                          fontSize: 14,
                          fontWeight: FontWeight.w400,
                          color: Color(0xFF1AA146),
                        ),
                      ),
                    ),
                  ),
                  Text(
                    "Checked: Nov 15, 2025",
                    style: TextStyle(
                      fontSize: 14,
                      fontWeight: FontWeight.w400,
                      color: AppColors.subTextColor,
                    ),
                  ),
                  SvgPicture.asset('assets/icons/delete.svg'),
                ],
              ),
              SizedBox(height: 12),
              Text(
                "Calim: FactFlow’s AI automatically scans articles, extracts factual claims and cross-references them with reliable sources.",

                style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.w400,
                  color: AppColors.subTextColor,
                ),
              ),
            ],
          ),
        );
      },
      separatorBuilder: (_, _) => SizedBox(height: 12),
      itemCount: 10,
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
