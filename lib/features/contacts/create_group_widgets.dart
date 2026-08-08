import 'package:safe_alert/core/utils/app_colors.dart';
import 'package:safe_alert/core/utils/app_styles.dart';
import 'package:flutter/material.dart';

import 'contact.dart';


/// A removable chip for a member already added to the group being created.
class MemberChip extends StatelessWidget {
  const MemberChip({super.key, required this.contact, required this.onRemove});

  final Contact contact;
  final VoidCallback onRemove;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.only(left: 12, right: 6, top: 6, bottom: 6),
      decoration: BoxDecoration(color: AppColors.brand100, borderRadius: BorderRadius.circular(20)),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Text(contact.name, style: AppTextStyles.body4Medium.copyWith(color: AppColors.brand700)),
          const SizedBox(width: 4),
          InkWell(
            borderRadius: BorderRadius.circular(12),
            onTap: onRemove,
            child: Padding(
              padding: const EdgeInsets.all(4),
              child: Icon(Icons.close_rounded, size: 14, color: AppColors.brand700),
            ),
          ),
        ],
      ),
    );
  }
}

/// A row in the "Suggested from contacts" list, with a circular "+" to
/// add that contact as a member.
class SuggestedContactTile extends StatelessWidget {
  const SuggestedContactTile({super.key, required this.contact, required this.onAdd});

  final Contact contact;
  final VoidCallback onAdd;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8),
      child: Row(
        children: [
          Container(
            width: 38,
            height: 38,
            decoration: BoxDecoration(color: contact.avatarColor, shape: BoxShape.circle),
            alignment: Alignment.center,
            child: Text(contact.initials, style: AppTextStyles.body4Medium.copyWith(color: Colors.white)),
          ),
          const SizedBox(width: 12),
          Expanded(
            child: Text(contact.name, style: AppTextStyles.body2Medium.copyWith(color: AppColors.brand900)),
          ),
          InkWell(
            borderRadius: BorderRadius.circular(20),
            onTap: onAdd,
            child: Padding(
              padding: const EdgeInsets.all(4),
              child: Icon(Icons.add_circle_outline_rounded, color: AppColors.brand500, size: 22),
            ),
          ),
        ],
      ),
    );
  }
}
