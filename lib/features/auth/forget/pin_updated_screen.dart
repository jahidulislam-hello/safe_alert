import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:safe_alert/core/utils/app_colors.dart';
import 'package:safe_alert/core/utils/app_styles.dart';
import 'package:safe_alert/features/auth/forget/seal_badge.dart';
import 'package:safe_alert/features/widgets/app_buttons.dart';


/// Step 4 of the forget-pin flow — success confirmation, then back
/// to the Log in screen.
class PinUpdatedScreen extends StatelessWidget {
  const PinUpdatedScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: Column(
          children: [
            Expanded(
              child: Center(
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    SealBadge(size: 110.w, color: AppColors.success600),
                    SizedBox(height: 24.h),
                    Text('Pin Updated!',
                        style: AppTextStyles.h5Bold.copyWith(color: AppColors.brand800)),
                    SizedBox(height: 6.h),
                    Text(
                      'Your Emergency Support starts here',
                      style: AppTextStyles.body3Regular.copyWith(color: AppColors.neutral600),
                    ),
                  ],
                ),
              ),
            ),
            Padding(
              padding: EdgeInsets.fromLTRB(20.w, 0, 20.w, 24.h),
              child: AppPrimaryButton(
                label: 'Back to Login',
                onPressed: () {
                  // Get.offAllNamed(AppRoutes.loginScreen);
                  Get.back();
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
