import '/core/utils/app_colors.dart';
import '/core/utils/app_styles.dart';
import 'package:flutter/material.dart';
import '../models/emergency_models.dart';


/// Small uppercase gray label used above list sections, e.g. "MY GROUPS"
/// or "Past 7 Days".
class SectionLabel extends StatelessWidget {
  const SectionLabel(this.text, {super.key});

  final String text;

  @override
  Widget build(BuildContext context) {
    return Text(
      text,
      style: AppTextStyles.caption1SemiBold.copyWith(color: AppColors.neutral400, letterSpacing: 0.4),
    );
  }
}

/// A row for one of the user's joined groups, with member/online counts.
class EmergencyGroupTile extends StatelessWidget {
  const EmergencyGroupTile({super.key, required this.group, this.onTap});

  final EmergencyGroup group;
  final VoidCallback? onTap;

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(bottom: 12),
      padding: const EdgeInsets.all(14),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(18),
        border: Border.all(color: AppColors.neutral100),
      ),
      child: InkWell(
        borderRadius: BorderRadius.circular(18),
        onTap: onTap,
        child: Row(
          children: [
            Container(
              width: 44,
              height: 44,
              decoration: BoxDecoration(color: AppColors.brand50, borderRadius: BorderRadius.circular(14)),
              alignment: Alignment.center,
              child: Icon(Icons.groups_rounded, color: AppColors.brand500, size: 22),
            ),
            const SizedBox(width: 12),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(group.name, style: AppTextStyles.body2Bold.copyWith(color: AppColors.brand900)),
                  const SizedBox(height: 2),
                  Text(
                    '${group.memberCount} members · ${group.onlineCount} online',
                    style: AppTextStyles.body4Regular.copyWith(color: AppColors.neutral500),
                  ),
                ],
              ),
            ),
            if (group.hasOnlineMembers)
              Container(
                width: 8,
                height: 8,
                decoration: const BoxDecoration(color: AppColors.success500, shape: BoxShape.circle),
              ),
          ],
        ),
      ),
    );
  }
}

/// A row for a resolved historical alert, shown under the Past alerts tab.
class PastAlertTile extends StatelessWidget {
  const PastAlertTile({super.key, required this.alert, this.onTap});

  final EmergencyAlertModel alert;
  final VoidCallback? onTap;

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(bottom: 12),
      padding: const EdgeInsets.all(14),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(18),
        border: Border.all(color: AppColors.neutral100),
      ),
      child: InkWell(
        borderRadius: BorderRadius.circular(18),
        onTap: onTap,
        child: Row(
          children: [
            Icon(Icons.check_circle_outline_rounded, color: AppColors.neutral400, size: 24),
            const SizedBox(width: 12),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(alert.personName, style: AppTextStyles.body2Bold.copyWith(color: AppColors.brand900)),
                  const SizedBox(height: 2),
                  Text(
                    '${alert.alertType} · ${alert.timeAgo}',
                    style: AppTextStyles.body4Regular.copyWith(color: AppColors.neutral500),
                  ),
                ],
              ),
            ),
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
              decoration: BoxDecoration(color: AppColors.success50, borderRadius: BorderRadius.circular(20)),
              child: Text(
                'Resolved',
                style: AppTextStyles.body4Medium.copyWith(color: AppColors.success700),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
