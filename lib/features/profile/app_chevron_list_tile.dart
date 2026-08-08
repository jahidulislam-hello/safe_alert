import 'package:safe_alert/core/utils/app_colors.dart';
import 'package:safe_alert/core/utils/app_styles.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';



/// Row with a label and trailing chevron — "My Subscriptions",
/// "About Us", "Privacy Policy", "Terms & Conditions", etc.
class AppChevronListTile extends StatelessWidget {
  final String title;
  final VoidCallback onTap;

  const AppChevronListTile({super.key, required this.title, required this.onTap});

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      child: Padding(
        padding: EdgeInsets.symmetric(vertical: 14.h),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(title, style: AppTextStyles.body2Medium.copyWith(color: AppColors.neutral900)),
            Icon(Icons.chevron_right, color: AppColors.neutral400, size: 20.sp),
          ],
        ),
      ),
    );
  }
}
