import '/core/utils/app_colors.dart';
import '/core/utils/app_styles.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';


/// One of the two selectable cards on Secure Account — "Face ID" or
/// "1-digit pin" — highlighting with a brand border/fill when selected.
class SecureAccessOptionCard extends StatelessWidget {
  final IconData icon;
  final String title;
  final String subtitle;
  final bool selected;
  final VoidCallback onTap;

  const SecureAccessOptionCard({
    super.key,
    required this.icon,
    required this.title,
    required this.subtitle,
    required this.selected,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: GestureDetector(
        onTap: onTap,
        child: Container(
          padding: EdgeInsets.symmetric(vertical: 18.h, horizontal: 12.w),
          decoration: BoxDecoration(
            color: selected ? AppColors.brand50 : AppColors.neutral50,
            borderRadius: BorderRadius.circular(14.r),
            border: Border.all(
              color: selected ? AppColors.brand500 : AppColors.neutral200,
              width: selected ? 1.6 : 1,
            ),
          ),
          child: Column(
            children: [
              Icon(icon, size: 28.sp, color: AppColors.brand700),
              SizedBox(height: 10.h),
              Text(
                title,
                style: AppTextStyles.body3Medium.copyWith(color: AppColors.neutral900),
              ),
              SizedBox(height: 2.h),
              Text(
                subtitle,
                textAlign: TextAlign.center,
                style: AppTextStyles.body4Regular.copyWith(color: AppColors.neutral500),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
