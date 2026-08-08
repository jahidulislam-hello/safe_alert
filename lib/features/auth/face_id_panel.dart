import '/core/utils/app_colors.dart' show AppColors;
import '/core/utils/app_styles.dart';
import '/features/widgets/app_buttons.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';



enum FaceIdStatus { notRegistered, scanning, registered }

/// The card that appears under the option cards once "Face ID" is
/// selected — shows the scan prompt, a scanning state, then the
/// "Face ID registered!" confirmation.
class FaceIdPanel extends StatelessWidget {
  final FaceIdStatus status;
  final VoidCallback onScan;

  const FaceIdPanel({super.key, required this.status, required this.onScan});

  @override
  Widget build(BuildContext context) {
    final registered = status == FaceIdStatus.registered;
    final scanning = status == FaceIdStatus.scanning;

    return Container(
      width: double.infinity,
      padding: EdgeInsets.symmetric(vertical: 28.h, horizontal: 16.w),
      decoration: BoxDecoration(
        color: AppColors.neutral50,
        borderRadius: BorderRadius.circular(16.r),
        border: Border.all(color: AppColors.neutral200),
      ),
      child: Column(
        children: [
          Icon(
            Icons.face_retouching_natural,
            size: 56.sp,
            color: registered ? AppColors.success600 : AppColors.neutral700,
          ),
          SizedBox(height: 14.h),
          if (!registered)
            Text(
              scanning ? 'Scanning...' : 'Tap to register Face ID',
              style: AppTextStyles.body2Medium.copyWith(color: AppColors.neutral800),
            )
          else
            Text(
              'Face ID registered!',
              style: AppTextStyles.body2Medium.copyWith(color: AppColors.success600),
            ),
          SizedBox(height: 4.h),
          Text(
            'Position your face in the frame',
            style: AppTextStyles.body4Regular.copyWith(color: AppColors.neutral500),
          ),
          if (!registered) ...[
            SizedBox(height: 18.h),
            SizedBox(
              width: 160.w,
              child: AppPrimaryButton(
                label: 'Scan Face',
                isLoading: scanning,
                onPressed: scanning ? null : onScan,
              ),
            ),
          ],
        ],
      ),
    );
  }
}
