import '/core/utils/app_colors.dart';
import '/core/utils/app_styles.dart';
import 'package:flutter/material.dart';
import '../models/emergency_models.dart';


/// A single pending invitation row with Accept & Join / Decline actions.
class GroupInvitationCard extends StatelessWidget {
  const GroupInvitationCard({
    super.key,
    required this.invitation,
    required this.onAccept,
    required this.onDecline,
  });

  final GroupInvitation invitation;
  final VoidCallback onAccept;
  final VoidCallback onDecline;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(20),
        border: Border.all(color: AppColors.neutral100),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                width: 44,
                height: 44,
                decoration: BoxDecoration(
                  color: AppColors.brand50,
                  borderRadius: BorderRadius.circular(14),
                ),
                alignment: Alignment.center,
                child: Icon(Icons.groups_rounded, color: AppColors.brand500, size: 22),
              ),
              const SizedBox(width: 12),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(invitation.groupName, style: AppTextStyles.body2Bold.copyWith(color: AppColors.brand900)),
                    const SizedBox(height: 2),
                    Text.rich(
                      TextSpan(
                        style: AppTextStyles.body3Regular.copyWith(color: AppColors.neutral500),
                        children: [
                          const TextSpan(text: 'Invited by '),
                          TextSpan(
                            text: invitation.invitedBy,
                            style: AppTextStyles.body3Medium.copyWith(color: AppColors.neutral700),
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(height: 2),
                    Text(invitation.timeAgo, style: AppTextStyles.body4Regular.copyWith(color: AppColors.neutral400)),
                  ],
                ),
              ),
            ],
          ),
          const SizedBox(height: 14),
          Row(
            children: [
              Expanded(
                child: ElevatedButton(
                  onPressed: onAccept,
                  style: ElevatedButton.styleFrom(
                    backgroundColor: AppColors.brand500,
                    foregroundColor: Colors.white,
                    elevation: 0,
                    padding: const EdgeInsets.symmetric(vertical: 13),
                    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(14)),
                  ),
                  child: Text('Accept & Join', style: AppTextStyles.body3Bold),
                ),
              ),
              const SizedBox(width: 10),
              Expanded(
                child: OutlinedButton(
                  onPressed: onDecline,
                  style: OutlinedButton.styleFrom(
                    foregroundColor: AppColors.neutral600,
                    side: BorderSide(color: AppColors.neutral200),
                    padding: const EdgeInsets.symmetric(vertical: 13),
                    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(14)),
                  ),
                  child: Text('Decline', style: AppTextStyles.body3Medium),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
