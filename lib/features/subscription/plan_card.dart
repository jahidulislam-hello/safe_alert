import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:safe_alert/core/utils/app_colors.dart';
import 'package:safe_alert/core/utils/app_styles.dart';
import 'plan_feature_row.dart';



/// A single plan tile — "Free" / "Premium" — with price, billing
/// period, and a checklist of included/excluded features. Used for
/// both "Current Plan" and "Switch Plan" sections.
class PlanCard extends StatelessWidget {
  final String planName;
  final String price;
  final String period;
  final List<PlanFeatureRow> features;
  final Color? priceColor;

  const PlanCard({
    super.key,
    required this.planName,
    required this.price,
    required this.period,
    required this.features,
    this.priceColor,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: EdgeInsets.all(16.w),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(14.r),
        border: Border.all(color: AppColors.neutral200),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(planName,
                  style: AppTextStyles.body2Medium.copyWith(color: AppColors.brand700)),
              Column(
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                  Text(price,
                      style: AppTextStyles.h6Bold.copyWith(color: priceColor ?? AppColors.neutral900)),
                  Text(period,
                      style: AppTextStyles.body4Regular.copyWith(color: AppColors.neutral500)),
                ],
              ),
            ],
          ),
          SizedBox(height: 12.h),
          ...features,
        ],
      ),
    );
  }
}