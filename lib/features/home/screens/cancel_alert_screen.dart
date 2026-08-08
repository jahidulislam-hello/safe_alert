import 'package:safe_alert/core/utils/app_colors.dart';
import 'package:safe_alert/core/utils/app_styles.dart';
import 'package:flutter/material.dart';
import '../widgets/common_widgets.dart';
import 'home_screen.dart';

enum CancelReason { safe, falseAlert, test }

class _ReasonOption {
  final CancelReason reason;
  final String title;
  final String subtitle;
  final IconData icon;
  final Color iconColor;
  const _ReasonOption(this.reason, this.title, this.subtitle, this.icon, this.iconColor);
}

const _reasons = [
  _ReasonOption(CancelReason.safe, "I'm Safe", 'Situation resolved, I am safe',
      Icons.check_circle_outline, AppColors.success500),
  _ReasonOption(CancelReason.falseAlert, 'False Alert', 'Accidentally triggered the alert',
      Icons.warning_amber_rounded, AppColors.warning400),
  _ReasonOption(CancelReason.test, 'Test', 'This was a test alert',
      Icons.science_outlined, AppColors.brand500),
];

/// "Why are you Cancelling?" reason-selection screen shown when ending
/// an active alert. Confirming returns the user to the home screen.
class CancelAlertScreen extends StatefulWidget {
  const CancelAlertScreen({super.key});

  @override
  State<CancelAlertScreen> createState() => _CancelAlertScreenState();
}

class _CancelAlertScreenState extends State<CancelAlertScreen> {
  CancelReason? _selected;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppTopBar(title: 'Cancel Alert', onBack: () => Navigator.of(context).pop()),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.fromLTRB(24, 24, 24, 24),
          child: Column(
            children: [
              const AppLogoMark(size: 40),
              const SizedBox(height: 28),
              Text('Why are you Cancelling ?',
                  style: AppTextStyles.h6Bold.copyWith(color: AppColors.brand900)),
              const SizedBox(height: 4),
              Text('your Contacts will be notified',
                  style: AppTextStyles.body3Regular.copyWith(color: AppColors.neutral600)),
              const SizedBox(height: 28),
              ..._reasons.map((r) => Padding(
                    padding: const EdgeInsets.only(bottom: 14),
                    child: _ReasonTile(
                      option: r,
                      selected: _selected == r.reason,
                      onTap: () => setState(() => _selected = r.reason),
                    ),
                  )),
              const Spacer(),
              AppFilledButton(
                label: 'Confirm Cancellation',
                background: _selected != null ? AppColors.brand600 : AppColors.neutral300,
                onPressed: _selected != null
                    ? () => Navigator.of(context).pushAndRemoveUntil(
                          MaterialPageRoute(
                            builder: (_) => const HomeScreen(hasActivity: true),
                          ),
                          (route) => false,
                        )
                    : null,
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class _ReasonTile extends StatelessWidget {
  final _ReasonOption option;
  final bool selected;
  final VoidCallback onTap;

  const _ReasonTile({required this.option, required this.selected, required this.onTap});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 150),
        width: double.infinity,
        padding: const EdgeInsets.all(16),
        decoration: BoxDecoration(
          color: selected ? AppColors.brand50 : Colors.white,
          borderRadius: BorderRadius.circular(16),
          border: Border.all(
            color: selected ? AppColors.brand400 : AppColors.neutral100,
            width: selected ? 1.5 : 1,
          ),
        ),
        child: Row(
          children: [
            Icon(option.icon, color: option.iconColor, size: 22),
            const SizedBox(width: 14),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(option.title,
                      style: AppTextStyles.body2Bold.copyWith(color: AppColors.neutral900)),
                  const SizedBox(height: 2),
                  Text(option.subtitle,
                      style: AppTextStyles.body4Regular.copyWith(color: AppColors.neutral500)),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
