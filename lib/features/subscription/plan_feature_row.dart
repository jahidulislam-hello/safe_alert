import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../core/utils/app_colors.dart';
import '../../core/utils/app_styles.dart';

/// One line in a plan's feature list — a green check or red cross,
/// then the feature label.
class PlanFeatureRow extends StatelessWidget {
  final String label;
  final bool included;

  const PlanFeatureRow({super.key, required this.label, required this.included});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(vertical: 3.h),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Icon(
            included ? Icons.check_circle : Icons.cancel,
            size: 16.sp,
            color: included ? AppColors.success500 : AppColors.alarm400,
          ),
          SizedBox(width: 8.w),
          Expanded(
            child: Text(
              label,
              style: AppTextStyles.body3Regular.copyWith(color: AppColors.neutral800),
            ),
          ),
        ],
      ),
    );
  }
}
