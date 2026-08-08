import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:safe_alert/features/auth/forget/otp_verify_panel.dart';
import 'package:safe_alert/features/widgets/app_header.dart';



/// Step 2 of the forget-pin flow — verify the OTP sent to the phone
/// number entered on ForgetPinScreen, then move to Set New Pin.
class EnterOtpScreen extends StatefulWidget {
  const EnterOtpScreen({super.key});

  @override
  State<EnterOtpScreen> createState() => _EnterOtpScreenState();
}

class _EnterOtpScreenState extends State<EnterOtpScreen> {
  String _code = '';
  bool _isVerifying = false;

  String get _phoneNumber {
    final arg = Get.arguments;
    return arg is String && arg.isNotEmpty ? arg : '+1 (555) 000-0000';
  }

  Future<void> _onSetNewPin() async {
    if (_code.length != 6) return;
    setState(() => _isVerifying = true);
    // TODO: call your OTP verification endpoint here.
    await Future.delayed(const Duration(milliseconds: 900));
    if (!mounted) return;
    setState(() => _isVerifying = false);
    // Get.toNamed(AppRoutes.setNewPinScreen);
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
            AppHeader(title: 'Enter OTP', onLeadingTap: () => Get.back()),
            Expanded(
              child: SingleChildScrollView(
                padding: EdgeInsets.symmetric(horizontal: 20.w),
                child: OtpVerifyPanel(
                  heading: 'Verify your phone',
                  phoneNumber: _phoneNumber,
                  buttonLabel: 'Set New Pin',
                  isSubmitting: _isVerifying,
                  onCodeChanged: (v) => setState(() => _code = v),
                  onSubmit: _code.length == 6 ? _onSetNewPin : null,
                  onResend: _onResend,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
