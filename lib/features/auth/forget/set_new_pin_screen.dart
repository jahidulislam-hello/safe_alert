import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:safe_alert/features/auth/forget/pin_digit_grid.dart';
import 'package:safe_alert/features/widgets/app_buttons.dart';
import 'package:safe_alert/features/widgets/app_header.dart';




class SetNewPinScreen extends StatefulWidget {
  const SetNewPinScreen({super.key});

  @override
  State<SetNewPinScreen> createState() => _SetNewPinScreenState();
}

class _SetNewPinScreenState extends State<SetNewPinScreen> {
  int? _selectedDigit;
  bool _isSaving = false;

  Future<void> _onSave() async {
    if (_selectedDigit == null) return;
    setState(() => _isSaving = true);
    // TODO: call your AuthController's set-new-pin endpoint here.
    await Future.delayed(const Duration(milliseconds: 900));
    if (!mounted) return;
    setState(() => _isSaving = false);
    // Get.offNamed(AppRoutes.pinUpdatedScreen);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: Column(
          children: [
            AppHeader(title: 'Set New Pin', onLeadingTap: () => Get.back()),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 20.w),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  SizedBox(height: 8.h),
                  PinDigitGrid(
                    selectedDigit: _selectedDigit,
                    onSelect: (d) => setState(() => _selectedDigit = d),
                  ),
                  SizedBox(height: 24.h),
                  AppPrimaryButton(
                    label: 'Save New Pin',
                    isLoading: _isSaving,
                    onPressed: _selectedDigit != null ? _onSave : null,
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
