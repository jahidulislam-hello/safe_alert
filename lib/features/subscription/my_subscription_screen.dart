import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import '../../core/routes/routes.dart';
import '../../core/utils/app_colors.dart';
import '../../core/utils/app_styles.dart';
import '../../features/widgets/app_header.dart';
import 'plan_card.dart';
import 'plan_feature_row.dart';



/// Subscription overview — current plan, the plan you can switch to,
/// and the entry point into the cancel flow.
class MySubscriptionScreen extends StatelessWidget {
  const MySubscriptionScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: Column(
          children: [
            AppHeader(title: 'My Subscription', onLeadingTap: () => Get.back()),
            Expanded(
              child: SingleChildScrollView(
                padding: EdgeInsets.symmetric(horizontal: 20.w),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    SizedBox(height: 4.h),
                    Text('Current Plan',
                        style: AppTextStyles.body3Medium.copyWith(color: AppColors.neutral700)),
                    SizedBox(height: 8.h),
                    const PlanCard(
                      planName: 'Free',
                      price: '\$0',
                      period: 'forever',
                      features: [
                        PlanFeatureRow(label: '2 emergency groups', included: true),
                        PlanFeatureRow(label: 'Up to 5 contacts per group', included: true),
                        PlanFeatureRow(label: 'SOS alerts', included: true),
                        PlanFeatureRow(label: 'Video calls', included: false),
                        PlanFeatureRow(label: 'Unlimited contacts', included: false),
                        PlanFeatureRow(label: 'Incident journal', included: false),
                      ],
                    ),
                    SizedBox(height: 20.h),
                    Text('Switch Plan',
                        style: AppTextStyles.body3Medium.copyWith(color: AppColors.neutral700)),
                    SizedBox(height: 8.h),
                    const PlanCard(
                      planName: 'Premium',
                      price: '\$5.00',
                      period: '/month',
                      features: [
                        PlanFeatureRow(label: 'Unlimited groups', included: true),
                        PlanFeatureRow(label: 'Unlimited Contacts per group', included: true),
                        PlanFeatureRow(label: 'SOS alerts', included: true),
                        PlanFeatureRow(label: 'Group video calls', included: true),
                        PlanFeatureRow(label: 'Incident journal', included: true),
                        PlanFeatureRow(label: 'Wearable integration (coming soon)', included: true),
                      ],
                    ),
                    SizedBox(height: 16.h),
                    _CancelSubscriptionTile(
                      onTap: () => Get.toNamed(AppRoutes.cancelSubscriptionScreen),
                    ),
                    SizedBox(height: 24.h),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _CancelSubscriptionTile extends StatelessWidget {
  final VoidCallback onTap;
  const _CancelSubscriptionTile({required this.onTap});

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(14.r),
      child: Container(
        width: double.infinity,
        padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 16.h),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(14.r),
          border: Border.all(color: AppColors.neutral200),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text('Cancel Subscription',
                style: AppTextStyles.body2Medium.copyWith(color: AppColors.neutral900)),
            Icon(Icons.chevron_right, color: AppColors.neutral400, size: 20.sp),
          ],
        ),
      ),
    );
  }
}
