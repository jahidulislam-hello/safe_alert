import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:safe_alert/features/widgets/app_buttons.dart';
import 'package:safe_alert/features/widgets/app_header.dart';
import 'package:safe_alert/features/widgets/app_text_field.dart';


/// Step 1 of the forget-pin flow — collect the phone number, then
/// request an OTP.
class ForgetPinScreen extends StatefulWidget {
  const ForgetPinScreen({super.key});

  @override
  State<ForgetPinScreen> createState() => _ForgetPinScreenState();
}

class _ForgetPinScreenState extends State<ForgetPinScreen> {
  final _phoneController = TextEditingController();
  bool _isSending = false;

  bool get _canSubmit => _phoneController.text.trim().isNotEmpty;

  @override
  void initState() {
    super.initState();
    _phoneController.addListener(() => setState(() {}));
  }

  @override
  void dispose() {
    _phoneController.dispose();
    super.dispose();
  }

  Future<void> _onGetOtp() async {
    if (!_canSubmit) return;
    setState(() => _isSending = true);
    // TODO: call your AuthController's request-OTP endpoint here.
    await Future.delayed(const Duration(milliseconds: 900));
    if (!mounted) return;
    setState(() => _isSending = false);
    // Get.toNamed(AppRoutes.enterOtpForgetPinScreen, arguments: _phoneController.text);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: Column(
          children: [
            AppHeader(title: 'Forget Pin', onLeadingTap: () => Get.back()),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 20.w),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  SizedBox(height: 8.h),
                  const AppFieldLabel('Phone Number'),
                  AppTextField(
                    controller: _phoneController,
                    hintText: '+2(555) 0000 - 0000',
                    keyboardType: TextInputType.phone,
                  ),
                  SizedBox(height: 20.h),
                  AppPrimaryButton(
                    label: 'Get OTP',
                    isLoading: _isSending,
                    onPressed: _canSubmit ? _onGetOtp : null,
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
