import 'package:safe_alert/core/utils/app_colors.dart';
import 'package:safe_alert/core/utils/app_styles.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';



/// Shared outlined input used on Create Account, Log in, etc.
class AppTextField extends StatelessWidget {
  final TextEditingController controller;
  final String hintText;
  final TextInputType? keyboardType;
  final bool obscureText;
  final Widget? suffixIcon;

  const AppTextField({
    super.key,
    required this.controller,
    required this.hintText,
    this.keyboardType,
    this.obscureText = false,
    this.suffixIcon,
  });

  @override
  Widget build(BuildContext context) {
    return TextField(
      controller: controller,
      keyboardType: keyboardType,
      obscureText: obscureText,
      style: AppTextStyles.body2Regular.copyWith(color: AppColors.neutral900),
      decoration: InputDecoration(
        hintText: hintText,
        hintStyle: AppTextStyles.body2Regular.copyWith(color: AppColors.neutral400),
        filled: true,
        fillColor: Colors.white,
        suffixIcon: suffixIcon,
        contentPadding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 14.h),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12.r),
          borderSide: const BorderSide(color: AppColors.neutral200),
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12.r),
          borderSide: const BorderSide(color: AppColors.neutral200),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12.r),
          borderSide: const BorderSide(color: AppColors.brand500, width: 1.5),
        ),
      ),
    );
  }
}

/// Label above a field — "Full name", "Race (Optional)", "Phone Number", etc.
class AppFieldLabel extends StatelessWidget {
  final String text;
  final bool optional;
  final Color? color;
  const AppFieldLabel(this.text, {super.key, this.optional = false, this.color});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(bottom: 6.h),
      child: RichText(
        text: TextSpan(
          style: AppTextStyles.body3Medium.copyWith(color: color ?? AppColors.neutral700),
          children: [
            TextSpan(text: text),
            if (optional)
              TextSpan(
                text: ' (Optional)',
                style: AppTextStyles.body3Regular.copyWith(color: AppColors.neutral400),
              ),
          ],
        ),
      ),
    );
  }
}
