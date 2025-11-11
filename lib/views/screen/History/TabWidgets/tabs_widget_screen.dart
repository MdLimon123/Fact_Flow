import 'package:fact_flow/utils/app_colors.dart';
import 'package:flutter/material.dart';

class TabsWidgetScreen extends StatelessWidget {
  final bool isSelected;
  final String tabName;
  final VoidCallback onTap;

  const TabsWidgetScreen({
    super.key,
    required this.isSelected,
    required this.tabName,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 300),
        margin: const EdgeInsets.symmetric(horizontal: 6),
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 8),
        decoration: BoxDecoration(
          color: isSelected ? Color(0xFF33B6C9) : AppColors.backgroundColor,
          borderRadius: BorderRadius.circular(12),
          border: Border.all(color: Color(0xFFE6EBF0), width: 1),
          boxShadow: [
            if (isSelected)
              BoxShadow(
                color: Color(0xFF000000).withValues(alpha: .04),
                blurRadius: 4,
                offset: const Offset(0, 4),
              ),
          ],
        ),
        child: Center(
          child: tabName == 'Calendar'
              ? Icon(
                  Icons.calendar_today_outlined,
                  color: isSelected ? Colors.white : AppColors.subTextColor,
                  size: 20,
                )
              : Text(
                  tabName,
                  style: TextStyle(
                    color: isSelected ? Colors.white : AppColors.subTextColor,
                    fontSize: 14,
                    fontWeight: FontWeight.w400,
                  ),
                ),
        ),
      ),
    );
  }
}
