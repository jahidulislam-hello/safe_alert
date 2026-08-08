import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:safe_alert/core/utils/app_colors.dart';
import 'package:safe_alert/core/utils/app_styles.dart';
import 'package:safe_alert/features/widgets/app_buttons.dart';
import 'package:safe_alert/features/widgets/otp_input_row.dart';



/// The phone-icon + heading + "we sent a code to X" + 6-digit boxes +
/// primary CTA + "Didn't receive it? Resend code" block. Shared by
/// Verify Phone (signup) and Enter OTP (forget-pin) so both stay
/// pixel-identical; only the heading and button label differ.
class OtpVerifyPanel extends StatelessWidget {
  final String heading;
  final String phoneNumber;
  final String buttonLabel;
  final bool isSubmitting;
  final ValueChanged<String> onCodeChanged;
  final VoidCallback? onSubmit;
  final VoidCallback onResend;

  const OtpVerifyPanel({
    super.key,
    required this.heading,
    required this.phoneNumber,
    required this.buttonLabel,
    required this.isSubmitting,
    required this.onCodeChanged,
    required this.onSubmit,
    required this.onResend,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        SizedBox(height: 8.h),
        Container(
          width: 48.w,
          height: 48.w,
          decoration: BoxDecoration(
            color: AppColors.brand50,
            borderRadius: BorderRadius.circular(12.r),
          ),
          alignment: Alignment.center,
          child: Icon(Icons.phone_outlined, color: AppColors.brand600, size: 22.sp),
        ),
        SizedBox(height: 20.h),
        Text(heading, style: AppTextStyles.h5Bold.copyWith(color: AppColors.brand800)),
        SizedBox(height: 8.h),
        RichText(
          text: TextSpan(
            style: AppTextStyles.body3Regular.copyWith(color: AppColors.neutral600),
            children: [
              const TextSpan(text: 'We sent a 6-digit code to '),
              TextSpan(
                text: phoneNumber,
                style: AppTextStyles.body3Medium.copyWith(color: AppColors.brand600),
              ),
            ],
          ),
        ),
        SizedBox(height: 28.h),
        OtpInputRow(length: 6, onChanged: onCodeChanged, onCompleted: onCodeChanged),
        SizedBox(height: 28.h),
        AppPrimaryButton(label: buttonLabel, isLoading: isSubmitting, onPressed: onSubmit),
        SizedBox(height: 16.h),
        Center(
          child: RichText(
            text: TextSpan(
              style: AppTextStyles.body3Regular.copyWith(color: AppColors.neutral600),
              children: [
                const TextSpan(text: "Didn't receive it? "),
                TextSpan(
                  text: 'Resend code',
                  style: AppTextStyles.body3Medium.copyWith(color: AppColors.brand600),
                  recognizer: TapGestureRecognizer()..onTap = onResend,
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }
}
