import 'dart:async';
import 'package:safe_alert/core/utils/app_colors.dart';
import 'package:safe_alert/core/utils/app_styles.dart';
import 'package:flutter/material.dart';
import '../widgets/common_widgets.dart';
import 'alert_mode_screen.dart';
import 'live_call_screen.dart';
import 'live_tracking_screen.dart';
import 'cancel_alert_screen.dart';

/// "Alert Sent!" confirmation screen with a live active-alert timer,
/// notified groups list, and actions to start a call, view the live
/// session (tracking map), or cancel the alert.
class AlertSentScreen extends StatefulWidget {
  final EmergencyAlertMode mode;
  final String emergencyType;

  const AlertSentScreen({super.key, required this.mode, required this.emergencyType});

  @override
  State<AlertSentScreen> createState() => _AlertSentScreenState();
}

class _AlertSentScreenState extends State<AlertSentScreen> {
  int _elapsedSeconds = 2;
  Timer? _timer;

  @override
  void initState() {
    super.initState();
    _timer = Timer.periodic(const Duration(seconds: 1), (_) {
      setState(() => _elapsedSeconds++);
    });
  }

  @override
  void dispose() {
    _timer?.cancel();
    super.dispose();
  }

  String get _formattedTime {
    final m = (_elapsedSeconds ~/ 60).toString().padLeft(2, '0');
    final s = (_elapsedSeconds % 60).toString().padLeft(2, '0');
    return '$m:$s';
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.fromLTRB(24, 24, 24, 24),
          child: Column(
            children: [
              Container(
                width: 72,
                height: 72,
                decoration: const BoxDecoration(shape: BoxShape.circle, color: AppColors.success50),
                child: const Icon(Icons.check, color: AppColors.success600, size: 36),
              ),
              const SizedBox(height: 16),
              Text('Alert Sent!', style: AppTextStyles.h6Bold.copyWith(color: AppColors.success700)),
              const SizedBox(height: 4),
              Text('Your contacts are being notified',
                  style: AppTextStyles.body3Regular.copyWith(color: AppColors.neutral600)),
              const SizedBox(height: 24),
              Container(
                width: double.infinity,
                padding: const EdgeInsets.symmetric(vertical: 14),
                decoration: BoxDecoration(
                  color: AppColors.alarm50,
                  borderRadius: BorderRadius.circular(28),
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const Icon(Icons.circle, size: 8, color: AppColors.alarm500),
                    const SizedBox(width: 8),
                    Text(_formattedTime,
                        style: AppTextStyles.body2Bold.copyWith(color: AppColors.alarm600)),
                    const SizedBox(width: 8),
                    Text('Active Alert',
                        style: AppTextStyles.body3Medium.copyWith(color: AppColors.alarm600)),
                  ],
                ),
              ),
              const SizedBox(height: 16),
              Container(
                width: double.infinity,
                padding: const EdgeInsets.all(14),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(14),
                  border: Border.all(color: AppColors.neutral100),
                ),
                child: Row(
                  children: [
                    const Icon(Icons.location_on_outlined, color: AppColors.brand600, size: 20),
                    const SizedBox(width: 10),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text('Live Location Active',
                              style: AppTextStyles.body3Bold.copyWith(color: AppColors.neutral900)),
                          Text('123 Main St, New York, NY 10001',
                              style: AppTextStyles.body4Regular.copyWith(color: AppColors.neutral500)),
                        ],
                      ),
                    ),
                    Container(
                      width: 8,
                      height: 8,
                      decoration: const BoxDecoration(color: AppColors.success500, shape: BoxShape.circle),
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 20),
              Align(
                alignment: Alignment.centerLeft,
                child: Text('NOTIFIED GROUPS',
                    style: AppTextStyles.caption1SemiBold.copyWith(
                      color: AppColors.neutral500,
                      letterSpacing: 0.5,
                    )),
              ),
              const SizedBox(height: 12),
              _groupRow(label: 'Family', memberCount: 4, colorSeed: AppColors.brand400),
              const SizedBox(height: 10),
              _groupRow(label: 'Work Emergency', memberCount: 3, colorSeed: AppColors.warning300),
              const Spacer(),
              AppFilledButton(
                label: 'Start Group Video Call',
                background: AppColors.brand600,
                icon: Icons.videocam_outlined,
                onPressed: () => Navigator.of(context).push(
                  MaterialPageRoute(builder: (_) => const LiveCallScreen()),
                ),
              ),
              const SizedBox(height: 12),
              AppOutlinedButton(
                label: 'View Live Session',
                borderColor: AppColors.brand600,
                foreground: AppColors.brand600,
                onPressed: () => Navigator.of(context).push(
                  MaterialPageRoute(
                    builder: (_) => LiveTrackingScreen(
                      mode: widget.mode,
                      emergencyType: widget.emergencyType,
                    ),
                  ),
                ),
              ),
              const SizedBox(height: 8),
              TextButton(
                onPressed: () => Navigator.of(context).push(
                  MaterialPageRoute(builder: (_) => const CancelAlertScreen()),
                ),
                child: Text('Cancel Alert',
                    style: AppTextStyles.body3Medium.copyWith(color: AppColors.neutral600)),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _groupRow({required String label, required int memberCount, required Color colorSeed}) {
    return Row(
      children: [
        InitialsAvatar(initials: label[0], background: colorSeed, radius: 18),
        const SizedBox(width: 12),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(label, style: AppTextStyles.body3Bold.copyWith(color: AppColors.neutral900)),
              Text('$memberCount members',
                  style: AppTextStyles.body4Regular.copyWith(color: AppColors.neutral500)),
            ],
          ),
        ),
        Row(
          children: [
            const Icon(Icons.check_circle, size: 14, color: AppColors.success500),
            const SizedBox(width: 4),
            Text('Delivered',
                style: AppTextStyles.body4Medium.copyWith(color: AppColors.success600)),
          ],
        ),
      ],
    );
  }
}
