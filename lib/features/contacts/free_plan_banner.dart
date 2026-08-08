import 'package:safe_alert/core/utils/app_colors.dart';
import 'package:safe_alert/core/utils/app_styles.dart';
import 'package:safe_alert/features/contacts/contact_group.dart';
import 'package:flutter/material.dart';


/// The "FREE PLAN — x/2 groups · Upgrade" header row plus the amber
/// warning banner shown at the top of the Groups tab.
class FreePlanBanner extends StatelessWidget {
  const FreePlanBanner({super.key, required this.groupCount, this.onUpgrade});

  final int groupCount;
  final VoidCallback? onUpgrade;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            Text(
              'FREE PLAN — $groupCount/${PlanLimits.maxGroups} groups',
              style: AppTextStyles.body4Medium.copyWith(color: AppColors.neutral500, letterSpacing: 0.3),
            ),
            const Spacer(),
            GestureDetector(
              onTap: onUpgrade,
              child: Text('Upgrade', style: AppTextStyles.body2Bold.copyWith(color: AppColors.brand600)),
            ),
          ],
        ),
        const SizedBox(height: 10),
        Container(
          width: double.infinity,
          padding: const EdgeInsets.all(12),
          decoration: BoxDecoration(
            color: AppColors.warning50,
            borderRadius: BorderRadius.circular(14),
            border: Border.all(color: AppColors.warning100),
          ),
          child: Row(
            children: [
              Icon(Icons.warning_amber_rounded, size: 18, color: AppColors.warning600),
              const SizedBox(width: 8),
              Expanded(
                child: Text(
                  'Free plan: max ${PlanLimits.maxGroups} groups, ${PlanLimits.maxMembersPerGroup} members each',
                  style: AppTextStyles.body4Medium.copyWith(color: AppColors.warning700),
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}
