import 'dart:async';
import 'package:safe_alert/core/utils/app_colors.dart';
import 'package:safe_alert/core/utils/app_styles.dart';
import 'package:flutter/material.dart';
import '../widgets/common_widgets.dart';
import 'alert_mode_screen.dart';

/// "Activate Emergency Alert?" confirmation screen with an auto-activating
/// countdown. Tapping "Create Now" skips straight to Alert Mode selection;
/// letting the timer hit zero does the same. "Cancel — I'm Safe" pops back.
class ActivateAlertScreen extends StatefulWidget {
  const ActivateAlertScreen({super.key});

  @override
  State<ActivateAlertScreen> createState() => _ActivateAlertScreenState();
}

class _ActivateAlertScreenState extends State<ActivateAlertScreen> {
  static const int _startSeconds = 4;
  int _secondsLeft = _startSeconds;
  Timer? _timer;

  @override
  void initState() {
    super.initState();
    _timer = Timer.periodic(const Duration(seconds: 1), (timer) {
      if (_secondsLeft <= 1) {
        timer.cancel();
        _proceed();
      } else {
        setState(() => _secondsLeft--);
      }
    });
  }

  @override
  void dispose() {
    _timer?.cancel();
    super.dispose();
  }

  void _proceed() {
    if (!mounted) return;
    Navigator.of(context).pushReplacement(
      MaterialPageRoute(builder: (_) => const AlertModeScreen()),
    );
  }

  void _cancel() {
    _timer?.cancel();
    Navigator.of(context).pop();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.fromLTRB(24, 24, 24, 32),
          child: Column(
            children: [
              const AppLogoMark(size: 40),
              const Spacer(flex: 3),
              Container(
                width: 88,
                height: 88,
                decoration: BoxDecoration(shape: BoxShape.circle, color: AppColors.alarm50),
                child: const Icon(Icons.warning_amber_rounded, color: AppColors.alarm500, size: 40),
              ),
              const SizedBox(height: 24),
              Text(
                'Activate Emergency Alert?',
                textAlign: TextAlign.center,
                style: AppTextStyles.h6Bold.copyWith(color: AppColors.brand900),
              ),
              const SizedBox(height: 8),
              Text(
                'This will immediately notify your emergency contacts and share your live location.',
                textAlign: TextAlign.center,
                style: AppTextStyles.body3Regular.copyWith(color: AppColors.neutral600),
              ),
              const SizedBox(height: 24),
              Container(
                width: double.infinity,
                padding: const EdgeInsets.symmetric(vertical: 14),
                decoration: BoxDecoration(
                  color: AppColors.alarm50,
                  borderRadius: BorderRadius.circular(28),
                  border: Border.all(color: AppColors.alarm200),
                ),
                child: Text(
                  'Auto-activating in $_secondsLeft seconds',
                  textAlign: TextAlign.center,
                  style: AppTextStyles.body3Medium.copyWith(color: AppColors.alarm600),
                ),
              ),
              const Spacer(flex: 4),
              AppFilledButton(
                label: 'Create Now',
                background: AppColors.brand600,
                onPressed: _proceed,
              ),
              const SizedBox(height: 16),
              TextButton(
                onPressed: _cancel,
                child: Text(
                  "Cancel — I'm Safe",
                  style: AppTextStyles.body3Medium.copyWith(color: AppColors.neutral600),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
