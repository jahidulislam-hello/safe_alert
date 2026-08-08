import 'package:safe_alert/core/utils/app_colors.dart';
import 'package:safe_alert/core/utils/app_styles.dart';
import 'package:flutter/material.dart';
import '../widgets/common_widgets.dart';
import 'emergency_type_screen.dart';

enum EmergencyAlertMode { emergency, silent }

/// "How Should we alert?" mode-selection screen.
/// Selecting a mode highlights that card; Silent Mode additionally reveals
/// a caution banner. "Continue" is disabled until a mode is chosen.
class AlertModeScreen extends StatefulWidget {
  const AlertModeScreen({super.key});

  @override
  State<AlertModeScreen> createState() => _AlertModeScreenState();
}

class _AlertModeScreenState extends State<AlertModeScreen> {
  EmergencyAlertMode? _selected;

  @override
  Widget build(BuildContext context) {
    final canContinue = _selected != null;

    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppTopBar(title: 'Alert Mode', onBack: () => Navigator.of(context).pop()),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.fromLTRB(24, 8, 24, 24),
          child: Column(
            children: [
              const SizedBox(height: 8),
              const AppLogoMark(size: 40),
              const SizedBox(height: 20),
              Text('How Should we alert?',
                  style: AppTextStyles.h6Bold.copyWith(color: AppColors.brand900)),
              const SizedBox(height: 4),
              Text('Choose your emergency mode',
                  style: AppTextStyles.body3Regular.copyWith(color: AppColors.neutral600)),
              const SizedBox(height: 28),
              _ModeCard(
                icon: Icons.campaign_rounded,
                iconBg: AppColors.alarm50,
                iconFg: AppColors.alarm500,
                title: 'Emergency Mode',
                description: 'Loud siren, visible alert, full notification to all contacts',
                tags: const ['Siren', 'Full Alert', 'Visible'],
                tagBg: AppColors.alarm50,
                tagFg: AppColors.alarm600,
                selected: _selected == EmergencyAlertMode.emergency,
                selectedBorder: AppColors.alarm400,
                selectedBg: AppColors.alarm50,
                onTap: () => setState(() => _selected = EmergencyAlertMode.emergency),
              ),
              const SizedBox(height: 16),
              _ModeCard(
                icon: Icons.person_outline_rounded,
                iconBg: AppColors.neutral100,
                iconFg: AppColors.neutral700,
                title: 'Silent Mode',
                description: 'Discreet alert. No sound. Contacts are notified quietly.',
                tags: const ['No Sound', 'Discreet', 'Safe'],
                tagBg: AppColors.brand50,
                tagFg: AppColors.brand700,
                selected: _selected == EmergencyAlertMode.silent,
                selectedBorder: AppColors.brand400,
                selectedBg: AppColors.brand50,
                onTap: () => setState(() => _selected = EmergencyAlertMode.silent),
              ),
              if (_selected == EmergencyAlertMode.silent) ...[
                const SizedBox(height: 16),
                InlineBanner(
                  text:
                      'Starting a video call in Silent Mode may reveal your location to nearby threats. Proceed with caution.',
                  background: AppColors.warning50,
                  foreground: AppColors.warning700,
                ),
              ],
              const Spacer(),
              AppFilledButton(
                label: 'Continue',
                background: canContinue ? AppColors.brand600 : AppColors.neutral300,
                onPressed: canContinue
                    ? () => Navigator.of(context).push(
                          MaterialPageRoute(
                            builder: (_) => EmergencyTypeScreen(mode: _selected!),
                          ),
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

class _ModeCard extends StatelessWidget {
  final IconData icon;
  final Color iconBg;
  final Color iconFg;
  final String title;
  final String description;
  final List<String> tags;
  final Color tagBg;
  final Color tagFg;
  final bool selected;
  final Color selectedBorder;
  final Color selectedBg;
  final VoidCallback onTap;

  const _ModeCard({
    required this.icon,
    required this.iconBg,
    required this.iconFg,
    required this.title,
    required this.description,
    required this.tags,
    required this.tagBg,
    required this.tagFg,
    required this.selected,
    required this.selectedBorder,
    required this.selectedBg,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 150),
        width: double.infinity,
        padding: const EdgeInsets.all(16),
        decoration: BoxDecoration(
          color: selected ? selectedBg : Colors.white,
          borderRadius: BorderRadius.circular(16),
          border: Border.all(
            color: selected ? selectedBorder : AppColors.neutral100,
            width: selected ? 1.5 : 1,
          ),
        ),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              width: 40,
              height: 40,
              decoration: BoxDecoration(color: iconBg, shape: BoxShape.circle),
              child: Icon(icon, size: 20, color: iconFg),
            ),
            const SizedBox(width: 12),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(title, style: AppTextStyles.body2Bold.copyWith(color: AppColors.neutral900)),
                  const SizedBox(height: 2),
                  Text(description,
                      style: AppTextStyles.body4Regular.copyWith(color: AppColors.neutral500)),
                  const SizedBox(height: 10),
                  Wrap(
                    spacing: 6,
                    runSpacing: 6,
                    children: tags
                        .map((t) => Container(
                              padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
                              decoration: BoxDecoration(
                                color: tagBg,
                                borderRadius: BorderRadius.circular(12),
                              ),
                              child: Text(t,
                                  style: AppTextStyles.caption1Medium.copyWith(color: tagFg)),
                            ))
                        .toList(),
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
