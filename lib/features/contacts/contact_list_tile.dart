import 'package:safe_alert/core/utils/app_colors.dart';
import 'package:safe_alert/core/utils/app_styles.dart';
import 'package:safe_alert/features/contacts/contact.dart';
import 'package:flutter/material.dart';


/// A single row in the All Contacts list: colored initials avatar, name +
/// relation, and a Family/Work tag pill on the right.
class ContactListTile extends StatelessWidget {
  const ContactListTile({super.key, required this.contact, this.onTap});

  final Contact contact;
  final VoidCallback? onTap;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 12),
        child: Row(
          children: [
            Container(
              width: 44,
              height: 44,
              decoration: BoxDecoration(color: contact.avatarColor, shape: BoxShape.circle),
              alignment: Alignment.center,
              child: Text(contact.initials, style: AppTextStyles.body3Bold.copyWith(color: Colors.white)),
            ),
            const SizedBox(width: 14),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(contact.name, style: AppTextStyles.body2Bold.copyWith(color: AppColors.brand900)),
                  const SizedBox(height: 2),
                  Text(contact.relation, style: AppTextStyles.body4Regular.copyWith(color: AppColors.neutral500)),
                ],
              ),
            ),
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
              decoration: BoxDecoration(color: AppColors.brand100, borderRadius: BorderRadius.circular(20)),
              child: Text(contact.tag.label, style: AppTextStyles.body4Medium.copyWith(color: AppColors.brand700)),
            ),
          ],
        ),
      ),
    );
  }
}
