import 'package:safe_alert/core/utils/app_colors.dart';
import 'package:safe_alert/core/utils/app_styles.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';



/// Full-width filled pill button — "Create Account", "Verify & Continue",
/// "Complete Setup", "Log in", etc. Handles its own disabled look.
class AppPrimaryButton extends StatelessWidget {
  final String label;
  final VoidCallback? onPressed;
  final Color? backgroundColor;
  final Color? disabledColor;
  final Color? textColor;
  final bool isLoading;

  const AppPrimaryButton({
    super.key,
    required this.label,
    required this.onPressed,
    this.backgroundColor,
    this.disabledColor,
    this.textColor,
    this.isLoading = false,
  });

  @override
  Widget build(BuildContext context) {
    final enabled = onPressed != null && !isLoading;
    return SizedBox(
      width: double.infinity,
      height: 52.h,
      child: ElevatedButton(
        onPressed: enabled ? onPressed : null,
        style: ElevatedButton.styleFrom(
          backgroundColor: backgroundColor ?? AppColors.brand500,
          disabledBackgroundColor: disabledColor ?? AppColors.neutral200,
          elevation: 0,
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(28.r)),
        ),
        child: isLoading
            ? SizedBox(
                width: 22.w,
                height: 22.w,
                child: const CircularProgressIndicator(strokeWidth: 2.4, color: Colors.white),
              )
            : Text(
                label,
                style: AppTextStyles.body1Medium.copyWith(
                  color: textColor ?? (enabled ? Colors.white : AppColors.neutral500),
                ),
              ),
      ),
    );
  }
}

/// Full-width outlined pill button — "Log in" on the welcome screen, etc.
class AppOutlinedButton extends StatelessWidget {
  final String label;
  final VoidCallback? onPressed;
  final Color borderColor;
  final Color textColor;

  const AppOutlinedButton({
    super.key,
    required this.label,
    required this.onPressed,
    this.borderColor = Colors.white,
    this.textColor = Colors.white,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: double.infinity,
      height: 52.h,
      child: OutlinedButton(
        onPressed: onPressed,
        style: OutlinedButton.styleFrom(
          foregroundColor: textColor,
          side: BorderSide(color: borderColor, width: 1.4),
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(28.r)),
        ),
        child: Text(label, style: AppTextStyles.body1Medium.copyWith(color: textColor)),
      ),
    );
  }
}

/// Small text link — "Resend code", "Reset Now", "Create Account", etc.
class AppTextLink extends StatelessWidget {
  final String text;
  final VoidCallback onTap;
  final TextStyle? style;

  const AppTextLink({super.key, required this.text, required this.onTap, this.style});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Text(
        text,
        style: style ?? AppTextStyles.body3Medium.copyWith(color: AppColors.brand600),
      ),
    );
  }
}
