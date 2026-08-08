import 'package:safe_alert/core/utils/app_colors.dart';
import 'package:safe_alert/core/utils/app_styles.dart';
import 'package:safe_alert/features/contacts/contact_group.dart';
import 'package:flutter/material.dart';


/// A single group card on the Groups tab: icon, name, member count,
/// Chat/Edit buttons, and a progress bar toward the member cap.
class GroupCard extends StatelessWidget {
  const GroupCard({
    super.key,
    required this.group,
    required this.onChat,
    required this.onEdit,
    this.progressColor,
  });

  final ContactGroup group;
  final VoidCallback onChat;
  final VoidCallback onEdit;

  /// Lets the caller vary the bar color per group (design shows blue for
  /// one group and green for another).
  final Color? progressColor;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(18),
        border: Border.all(color: AppColors.neutral100),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
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
                      '${group.memberCount}/${PlanLimits.maxMembersPerGroup} members',
                      style: AppTextStyles.body4Regular.copyWith(color: AppColors.neutral500),
                    ),
                  ],
                ),
              ),
              _PillButton(label: 'Chat', onTap: onChat),
              const SizedBox(width: 8),
              _PillButton(label: 'Edit', onTap: onEdit, filled: false),
            ],
          ),
          const SizedBox(height: 14),
          ClipRRect(
            borderRadius: BorderRadius.circular(6),
            child: LinearProgressIndicator(
              value: group.progress,
              minHeight: 6,
              backgroundColor: AppColors.neutral100,
              valueColor: AlwaysStoppedAnimation<Color>(progressColor ?? AppColors.brand500),
            ),
          ),
        ],
      ),
    );
  }
}

class _PillButton extends StatelessWidget {
  const _PillButton({required this.label, required this.onTap, this.filled = true});

  final String label;
  final VoidCallback onTap;
  final bool filled;

  @override
  Widget build(BuildContext context) {
    return Material(
      color: filled ? AppColors.brand100 : AppColors.neutral100,
      borderRadius: BorderRadius.circular(20),
      child: InkWell(
        borderRadius: BorderRadius.circular(20),
        onTap: onTap,
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 8),
          child: Text(
            label,
            style: AppTextStyles.body4Medium.copyWith(
              color: filled ? AppColors.brand700 : AppColors.neutral600,
            ),
          ),
        ),
      ),
    );
  }
}
