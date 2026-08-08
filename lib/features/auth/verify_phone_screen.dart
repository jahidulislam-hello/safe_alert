import '/core/routes/routes.dart';
import '/core/utils/app_colors.dart';
import '/core/utils/app_styles.dart';
import '/features/widgets/app_buttons.dart';
import '/features/widgets/app_header.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import '../widgets/otp_input_row.dart';


class VerifyPhoneScreen extends StatefulWidget {
  const VerifyPhoneScreen({super.key});

  @override
  State<VerifyPhoneScreen> createState() => _VerifyPhoneScreenState();
}

class _VerifyPhoneScreenState extends State<VerifyPhoneScreen> {
  String _code = '';
  bool _isVerifying = false;

  String get _phoneNumber {
    final arg = Get.arguments;
    return arg is String && arg.isNotEmpty ? arg : '+1 (555) 000-0000';
  }

  Future<void> _onVerify() async {
    if (_code.length != 6) return;
    setState(() => _isVerifying = true);
    // TODO: call your OTP verification endpoint here.
    await Future.delayed(const Duration(milliseconds: 900));
    if (!mounted) return;
    setState(() => _isVerifying = false);
    Get.toNamed(AppRoutes.secureAccountScreen);
  }

  void _onResend() {
    // TODO: trigger resend via your AuthController.
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: Column(
          children: [
            AppHeader(title: 'Verify', onLeadingTap: () => Get.back()),
            Expanded(
              child: SingleChildScrollView(
                padding: EdgeInsets.symmetric(horizontal: 20.w),
                child: Column(
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
                      child: Icon(Icons.phone_outlined,
                          color: AppColors.brand600, size: 22.sp),
                    ),
                    SizedBox(height: 20.h),
                    Text('Verify your phone',
                        style: AppTextStyles.h5Bold.copyWith(color: AppColors.brand800)),
                    SizedBox(height: 8.h),
                    RichText(
                      text: TextSpan(
                        style: AppTextStyles.body3Regular.copyWith(color: AppColors.neutral600),
                        children: [
                          const TextSpan(text: 'We sent a 6-digit code to '),
                          TextSpan(
                            text: _phoneNumber,
                            style: AppTextStyles.body3Medium.copyWith(color: AppColors.brand600),
                          ),
                        ],
                      ),
                    ),
                    SizedBox(height: 28.h),
                    OtpInputRow(
                      length: 6,
                      onChanged: (v) => setState(() => _code = v),
                      onCompleted: (v) => setState(() => _code = v),
                    ),
                    SizedBox(height: 28.h),
                    AppPrimaryButton(
                      label: 'Verify & Continue',
                      isLoading: _isVerifying,
                      onPressed: _code.length == 6 ? _onVerify : null,
                    ),
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
                              recognizer: TapGestureRecognizer()..onTap = _onResend,
                            ),
                          ],
                        ),
                      ),
                    ),
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
