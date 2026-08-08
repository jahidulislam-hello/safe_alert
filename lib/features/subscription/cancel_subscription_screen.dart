import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:safe_alert/core/utils/app_colors.dart';
import 'package:safe_alert/core/utils/app_styles.dart';
import 'package:safe_alert/features/widgets/app_header.dart';



/// Cancel-subscription feedback screen — optional comment, then the
/// destructive confirm action.
class CancelSubscriptionScreen extends StatefulWidget {
  const CancelSubscriptionScreen({super.key});

  @override
  State<CancelSubscriptionScreen> createState() => _CancelSubscriptionScreenState();
}

class _CancelSubscriptionScreenState extends State<CancelSubscriptionScreen> {
  final _commentController = TextEditingController();
  bool _isCancelling = false;

  @override
  void dispose() {
    _commentController.dispose();
    super.dispose();
  }

  Future<void> _onCancelSubscription() async {
    setState(() => _isCancelling = true);
    // TODO: call your subscription cancellation endpoint here, passing
    // _commentController.text as the optional feedback.
    await Future.delayed(const Duration(milliseconds: 900));
    if (!mounted) return;
    setState(() => _isCancelling = false);
    Get.back(); // returns to My Subscription; swap for a confirmation screen if you have one.
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: Column(
          children: [
            AppHeader(title: 'Cancel Subscription', onLeadingTap: () => Get.back()),
            Expanded(
              child: SingleChildScrollView(
                padding: EdgeInsets.symmetric(horizontal: 20.w),
                child: Column(
                  children: [
                    SizedBox(height: 24.h),
                    Text(
                      'Any Comments or Suggestions?',
                      textAlign: TextAlign.center,
                      style: AppTextStyles.h6Bold.copyWith(color: AppColors.brand800),
                    ),
                    SizedBox(height: 6.h),
                    Text(
                      "We're always looking for opportunities to improve",
                      textAlign: TextAlign.center,
                      style: AppTextStyles.body3Regular.copyWith(color: AppColors.neutral500),
                    ),
                    SizedBox(height: 20.h),
                    TextField(
                      controller: _commentController,
                      maxLines: 5,
                      minLines: 5,
                      style: AppTextStyles.body3Regular.copyWith(color: AppColors.neutral900),
                      decoration: InputDecoration(
                        hintText: 'Describe the incident or update...',
                        hintStyle:
                            AppTextStyles.body3Regular.copyWith(color: AppColors.neutral400),
                        filled: true,
                        fillColor: AppColors.neutral50,
                        contentPadding: EdgeInsets.all(16.w),
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(14.r),
                          borderSide: BorderSide.none,
                        ),
                        enabledBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(14.r),
                          borderSide: BorderSide.none,
                        ),
                        focusedBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(14.r),
                          borderSide: const BorderSide(color: AppColors.brand500, width: 1.5),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
            Padding(
              padding: EdgeInsets.fromLTRB(20.w, 0, 20.w, 24.h),
              child: SizedBox(
                width: double.infinity,
                height: 52.h,
                child: ElevatedButton(
                  onPressed: _isCancelling ? null : _onCancelSubscription,
                  style: ElevatedButton.styleFrom(
                    backgroundColor: AppColors.alarm500,
                    disabledBackgroundColor: AppColors.alarm200,
                    elevation: 0,
                    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(28.r)),
                  ),
                  child: _isCancelling
                      ? SizedBox(
                          width: 22.w,
                          height: 22.w,
                          child: const CircularProgressIndicator(
                              strokeWidth: 2.4, color: Colors.white),
                        )
                      : Text(
                          'Cancel Subscription',
                          style: AppTextStyles.body1Medium.copyWith(color: Colors.white),
                        ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
