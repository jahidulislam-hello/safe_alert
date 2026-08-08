import '/core/utils/app_colors.dart';
import '/core/utils/app_styles.dart';
import 'package:flutter/material.dart';
import '../models/emergency_models.dart';


/// The full-bleed red "LIVE EMERGENCY / Sarah needs help!" banner shown at
/// the very top of the Home screen once an alert is live.
class LiveEmergencyTopBanner extends StatelessWidget {
  const LiveEmergencyTopBanner({super.key, required this.alert, required this.onTap});

  final EmergencyAlertModel alert;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        width: double.infinity,
        padding: const EdgeInsets.all(18),
        decoration: BoxDecoration(
          gradient: LinearGradient(
            colors: [AppColors.alarm600, AppColors.alarm500],
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
          ),
          borderRadius: BorderRadius.circular(22),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Container(
                  width: 7,
                  height: 7,
                  decoration: const BoxDecoration(color: Colors.white, shape: BoxShape.circle),
                ),
                const SizedBox(width: 6),
                Text(
                  'LIVE EMERGENCY',
                  style: AppTextStyles.caption1SemiBold.copyWith(color: Colors.white, letterSpacing: 0.6),
                ),
                const Spacer(),
                Container(
                  padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
                  decoration: BoxDecoration(
                    color: Colors.white.withValues(alpha: 0.18),
                    borderRadius: BorderRadius.circular(20),
                  ),
                  child: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Text('Tap to respond', style: AppTextStyles.caption1SemiBold.copyWith(color: Colors.white)),
                      const SizedBox(width: 3),
                      const Icon(Icons.arrow_forward, size: 12, color: Colors.white),
                    ],
                  ),
                ),
              ],
            ),
            const SizedBox(height: 10),
            Row(
              children: [
                const Icon(Icons.front_hand_rounded, size: 18, color: Colors.white),
                const SizedBox(width: 6),
                Expanded(
                  child: Text(
                    '${alert.personName.split(' ').first} needs help!',
                    style: AppTextStyles.h6Bold.copyWith(color: Colors.white),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 4),
            Text(
              '${alert.alertType} · ${alert.location} · ${alert.timeAgo}',
              style: AppTextStyles.body4Regular.copyWith(color: Colors.white.withValues(alpha: 0.9)),
            ),
          ],
        ),
      ),
    );
  }
}

/// The red-outlined alert-summary card with Join Call / Message / locate
/// actions, shown in the Active list once there's a live alert.
class LiveAlertSummaryCard extends StatelessWidget {
  const LiveAlertSummaryCard({
    super.key,
    required this.alert,
    required this.onJoinCall,
    required this.onMessage,
    this.onLocate,
  });

  final EmergencyAlertModel alert;
  final VoidCallback onJoinCall;
  final VoidCallback onMessage;
  final VoidCallback? onLocate;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: AppColors.alarm50.withValues(alpha: 0.35),
        borderRadius: BorderRadius.circular(20),
        border: Border.all(color: AppColors.alarm100),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              _Avatar(initials: alert.personInitials, background: AppColors.alarm50, foreground: AppColors.alarm600),
              const SizedBox(width: 12),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(alert.personName, style: AppTextStyles.body2Bold.copyWith(color: AppColors.brand900)),
                    const SizedBox(height: 2),
                    Row(
                      children: [
                        Text(alert.alertType, style: AppTextStyles.body4Medium.copyWith(color: AppColors.alarm600)),
                        Text(' · ', style: AppTextStyles.body4Medium.copyWith(color: AppColors.alarm600)),
                        Text(
                          alert.modeLabel ?? '',
                          style: AppTextStyles.body4Medium.copyWith(color: AppColors.alarm600),
                        ),
                      ],
                    ),
                    const SizedBox(height: 2),
                    Text(
                      '${alert.location} · ${alert.timeAgo}',
                      style: AppTextStyles.body4Regular.copyWith(color: AppColors.neutral500),
                    ),
                  ],
                ),
              ),
              Row(
                children: [
                  Container(
                    width: 6,
                    height: 6,
                    margin: const EdgeInsets.only(right: 4),
                    decoration: const BoxDecoration(color: AppColors.alarm500, shape: BoxShape.circle),
                  ),
                  Text('LIVE', style: AppTextStyles.caption1SemiBold.copyWith(color: AppColors.alarm600)),
                ],
              ),
            ],
          ),
          const SizedBox(height: 14),
          Row(
            children: [
              Expanded(
                child: ElevatedButton.icon(
                  onPressed: onJoinCall,
                  icon: const Icon(Icons.videocam_rounded, size: 18),
                  label: Text('Join Call', style: AppTextStyles.body3Bold),
                  style: ElevatedButton.styleFrom(
                    backgroundColor: AppColors.brand500,
                    foregroundColor: Colors.white,
                    elevation: 0,
                    padding: const EdgeInsets.symmetric(vertical: 12),
                    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(14)),
                  ),
                ),
              ),
              const SizedBox(width: 10),
              Expanded(
                child: ElevatedButton.icon(
                  onPressed: onMessage,
                  icon: const Icon(Icons.chat_bubble_outline_rounded, size: 16),
                  label: Text('Message', style: AppTextStyles.body3Bold),
                  style: ElevatedButton.styleFrom(
                    backgroundColor: AppColors.brand100,
                    foregroundColor: AppColors.brand700,
                    elevation: 0,
                    padding: const EdgeInsets.symmetric(vertical: 12),
                    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(14)),
                  ),
                ),
              ),
              const SizedBox(width: 10),
              Container(
                width: 44,
                height: 44,
                decoration: BoxDecoration(
                  color: AppColors.neutral50,
                  borderRadius: BorderRadius.circular(14),
                ),
                child: IconButton(
                  padding: EdgeInsets.zero,
                  onPressed: onLocate,
                  icon: Icon(Icons.location_on_outlined, color: AppColors.neutral400, size: 20),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}

class _Avatar extends StatelessWidget {
  const _Avatar({required this.initials, required this.background, required this.foreground});

  final String initials;
  final Color background;
  final Color foreground;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 44,
      height: 44,
      decoration: BoxDecoration(color: background, borderRadius: BorderRadius.circular(14)),
      alignment: Alignment.center,
      child: Text(initials, style: AppTextStyles.body3Bold.copyWith(color: foreground)),
    );
  }
}
