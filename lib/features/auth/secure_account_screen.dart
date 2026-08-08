import '/core/utils/app_colors.dart';
import '/core/utils/app_styles.dart';
import '/features/auth/face_id_panel.dart';
import '/features/widgets/app_buttons.dart';
import '/features/widgets/app_header.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

import 'pin_digit_grid.dart';
import 'secure_access_option_card.dart';


enum _SecureMethod { none, faceId, pin }

/// Screen 4 — "Secure your Account": choose Face ID or a 1-digit PIN
/// fallback, register it, then Complete Setup.
class SecureAccountScreen extends StatefulWidget {
  const SecureAccountScreen({super.key});

  @override
  State<SecureAccountScreen> createState() => _SecureAccountScreenState();
}

class _SecureAccountScreenState extends State<SecureAccountScreen> {
  _SecureMethod _method = _SecureMethod.none;
  int? _selectedPin;
  FaceIdStatus _faceIdStatus = FaceIdStatus.notRegistered;

  bool get _canComplete {
    if (_method == _SecureMethod.pin) return _selectedPin != null;
    if (_method == _SecureMethod.faceId) return _faceIdStatus == FaceIdStatus.registered;
    return false;
  }

  Future<void> _onScanFace() async {
    setState(() => _faceIdStatus = FaceIdStatus.scanning);
    // TODO: call your platform biometric enrollment here (local_auth, etc.)
    await Future.delayed(const Duration(milliseconds: 1200));
    if (!mounted) return;
    setState(() => _faceIdStatus = FaceIdStatus.registered);
  }

  void _onCompleteSetup() {
    // TODO: persist the chosen method via your AuthController, then
    // Get.offAllNamed(AppRoutes.homeScreen);
  }

  void _onSkip() {
    // TODO: Get.offAllNamed(AppRoutes.homeScreen);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: Column(
          children: [
            AppHeader(title: 'Secure Account', onLeadingTap: () => Get.back()),
            Expanded(
              child: SingleChildScrollView(
                padding: EdgeInsets.symmetric(horizontal: 20.w),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    SizedBox(height: 4.h),
                    Text('Secure your Account',
                        style: AppTextStyles.h5Bold.copyWith(color: AppColors.brand800)),
                    SizedBox(height: 6.h),
                    Text(
                      'Choose how to quickly access SafeGuard in emergencies',
                      style: AppTextStyles.body3Regular.copyWith(color: AppColors.neutral600),
                    ),
                    SizedBox(height: 18.h),
                    Row(
                      children: [
                        SecureAccessOptionCard(
                          icon: Icons.face_outlined,
                          title: 'Face ID',
                          subtitle: 'Fastest access',
                          selected: _method == _SecureMethod.faceId,
                          onTap: () => setState(() => _method = _SecureMethod.faceId),
                        ),
                        SizedBox(width: 12.w),
                        SecureAccessOptionCard(
                          icon: Icons.lock_outline,
                          title: '1-digit pin',
                          subtitle: 'Simple Fallback',
                          selected: _method == _SecureMethod.pin,
                          onTap: () => setState(() => _method = _SecureMethod.pin),
                        ),
                      ],
                    ),
                    SizedBox(height: 20.h),
                    if (_method == _SecureMethod.pin)
                      PinDigitGrid(
                        selectedDigit: _selectedPin,
                        onSelect: (d) => setState(() => _selectedPin = d),
                      ),
                    if (_method == _SecureMethod.faceId)
                      FaceIdPanel(status: _faceIdStatus, onScan: _onScanFace),
                    SizedBox(height: 28.h),
                  ],
                ),
              ),
            ),
            Padding(
              padding: EdgeInsets.fromLTRB(20.w, 0, 20.w, 16.h),
              child: Column(
                children: [
                  AppPrimaryButton(
                    label: 'Complete Setup',
                    onPressed: _canComplete ? _onCompleteSetup : null,
                  ),
                  SizedBox(height: 12.h),
                  GestureDetector(
                    onTap: _onSkip,
                    child: Text(
                      'Skip for now',
                      style: AppTextStyles.body3Medium.copyWith(color: AppColors.neutral600),
                    ),
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
