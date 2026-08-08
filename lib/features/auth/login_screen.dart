import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:safe_alert/core/routes/routes.dart';
import 'package:safe_alert/core/utils/app_colors.dart';
import 'package:safe_alert/core/utils/app_styles.dart';
import 'package:safe_alert/features/auth/face_id_scan.dart';
import 'package:safe_alert/features/widgets/app_buttons.dart';
import 'package:safe_alert/features/widgets/app_header.dart';
import 'package:safe_alert/features/widgets/app_text_field.dart';



/// Screen 5 — Log in with phone number + 1-digit PIN, with a Face ID
/// scan shortcut next to the PIN field.
class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final _phoneController = TextEditingController();
  final _pinController = TextEditingController();
  bool _obscurePin = true;
  bool _isLoggingIn = false;

  bool get _canSubmit =>
      _phoneController.text.trim().isNotEmpty && _pinController.text.trim().isNotEmpty;

  @override
  void initState() {
    super.initState();
    _phoneController.addListener(() => setState(() {}));
    _pinController.addListener(() => setState(() {}));
  }

  @override
  void dispose() {
    _phoneController.dispose();
    _pinController.dispose();
    super.dispose();
  }

  Future<void> _onLogin() async {
    if (!_canSubmit) return;
    setState(() => _isLoggingIn = true);
    await Future.delayed(const Duration(milliseconds: 900));
    if (!mounted) return;
    setState(() => _isLoggingIn = false);
    Get.offAllNamed(AppRoutes.bottomNavbar);
  }

  void _onBiometricLogin() {
    // TODO: trigger local_auth Face ID / fingerprint flow.
  }

  void _onResetPin() {
    Get.toNamed(AppRoutes.forgetPinScreen);
  }

  void _onCreateAccount() {
    Get.toNamed(AppRoutes.createAccountScreen);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: Column(
          children: [
            AppHeader(
              title: 'Log in',
              leading: AppHeaderLeading.close,
              onLeadingTap: () => Get.back(),
            ),
            Expanded(
              child: SingleChildScrollView(
                padding: EdgeInsets.symmetric(horizontal: 20.w),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    SizedBox(height: 4.h),
                    AppFieldLabel('Phone Number', color: AppColors.brand800),
                    AppTextField(
                      controller: _phoneController,
                      hintText: '+2(555) 0000 - 0000',
                      keyboardType: TextInputType.phone,
                    ),
                    SizedBox(height: 16.h),
                    AppFieldLabel('Pin', color: AppColors.brand800),
                    Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Expanded(
                          child: AppTextField(
                            controller: _pinController,
                            hintText: 'Enter your 1 digit pin',
                            keyboardType: TextInputType.number,
                            obscureText: _obscurePin,
                            suffixIcon: IconButton(
                              onPressed: () => setState(() => _obscurePin = !_obscurePin),
                              icon: Icon(
                                _obscurePin
                                    ? Icons.visibility_outlined
                                    : Icons.visibility_off_outlined,
                                color: AppColors.neutral500,
                                size: 20.sp,
                              ),
                              splashRadius: 8.r,
                            ),
                          ),
                        ),
                        SizedBox(width: 10.w),
                        FaceIdScanButton(onTap: _onBiometricLogin),
                      ],
                    ),
                    SizedBox(height: 10.h),
                    Row(
                      children: [
                        Text('Forget your Pin? ',
                            style: AppTextStyles.body3Regular.copyWith(color: AppColors.neutral800)),
                        GestureDetector(
                          onTap: _onResetPin,
                          child: Text(
                            'Reset Now',
                            style: AppTextStyles.body3Medium.copyWith(color: AppColors.brand600),
                          ),
                        ),
                      ],
                    ),
                    SizedBox(height: 26.h),
                    AppPrimaryButton(
                      label: 'Log in',
                      isLoading: _isLoggingIn,
                      onPressed: _canSubmit ? _onLogin : null,
                    ),
                    SizedBox(height: 14.h),
                    Center(
                      child: RichText(
                        text: TextSpan(
                          style: AppTextStyles.body3Regular.copyWith(color: AppColors.neutral800),
                          children: [
                            const TextSpan(text: "Don't have an Account? "),
                            TextSpan(
                              text: 'Create Account',
                              style: AppTextStyles.body3Medium.copyWith(color: AppColors.brand600),
                              recognizer: TapGestureRecognizer()..onTap = _onCreateAccount,
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