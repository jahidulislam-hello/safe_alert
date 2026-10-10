import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:safe_alert/core/utils/app_colors.dart';
import 'package:safe_alert/core/utils/app_styles.dart';
import 'package:safe_alert/features/widgets/app_buttons.dart';
import 'package:safe_alert/features/widgets/app_header.dart';
import 'plan_card.dart';
import 'plan_feature_row.dart';

/// Plan picker / upgrade paywall — Free vs Premium comparison, then
/// a single CTA to start the Premium subscription.
class ChoosePlanScreen extends StatefulWidget {
  const ChoosePlanScreen({super.key});

  @override
  State<ChoosePlanScreen> createState() => _ChoosePlanScreenState();
}

class _ChoosePlanScreenState extends State<ChoosePlanScreen> {
  bool _isSubmitting = false;

  Future<void> _onGetStandard() async {
    setState(() => _isSubmitting = true);
    // TODO: kick off your billing/subscription flow (e.g. RevenueCat, Stripe) here.
    await Future.delayed(const Duration(milliseconds: 900));
    if (!mounted) return;
    setState(() => _isSubmitting = false);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: Column(
          children: [
            AppHeader(title: 'Choose Plan', onLeadingTap: () => Get.back()),
            Expanded(
              child: SingleChildScrollView(
                padding: EdgeInsets.symmetric(horizontal: 20.w),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    SizedBox(height: 4.h),
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
                    SizedBox(height: 16.h),
                    PlanCard(
                      planName: 'Premium',
                      price: '\$5.00',
                      period: '/month',
                      priceColor: AppColors.brand600,
                      features: const [
                        PlanFeatureRow(label: 'Unlimited groups', included: true),
                        PlanFeatureRow(label: 'Unlimited Contacts per groups', included: true),
                        PlanFeatureRow(label: 'SOS alerts', included: true),
                        PlanFeatureRow(label: 'Group video calls', included: true),
                        PlanFeatureRow(label: 'Incident journal', included: true),
                        PlanFeatureRow(label: 'Wearable integration (coming soon)', included: true),
                      ],
                    ),
                    SizedBox(height: 20.h),
                  ],
                ),
              ),
            ),
            Padding(
              padding: EdgeInsets.fromLTRB(20.w, 0, 20.w, 20.h),
              child: Column(
                children: [
                  AppPrimaryButton(
                    label: 'Get Standard - \$5.00/mo',
                    isLoading: _isSubmitting,
                    onPressed: _onGetStandard,
                  ),
                  SizedBox(height: 10.h),
                  Text(
                    'Cancel anytime. 7-day free trial for Pro.',
                    style: AppTextStyles.body4Regular.copyWith(color: AppColors.neutral500),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
