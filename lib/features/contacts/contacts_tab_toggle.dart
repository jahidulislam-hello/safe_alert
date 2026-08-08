import 'package:safe_alert/core/utils/app_colors.dart';
import 'package:safe_alert/core/utils/app_styles.dart';
import 'package:safe_alert/features/contacts/contacts_controller.dart';
import 'package:flutter/material.dart';


/// The rounded "All Contacts / Groups" segmented control.
class ContactsTabToggle extends StatelessWidget {
  const ContactsTabToggle({super.key, required this.currentTab, required this.onChanged});

  final ContactsTab currentTab;
  final ValueChanged<ContactsTab> onChanged;

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 52,
      padding: const EdgeInsets.all(4),
      decoration: BoxDecoration(color: AppColors.neutral100, borderRadius: BorderRadius.circular(30)),
      child: Row(
        children: [
          _Segment(
            label: 'All Contacts',
            selected: currentTab == ContactsTab.all,
            onTap: () => onChanged(ContactsTab.all),
          ),
          _Segment(
            label: 'Groups',
            selected: currentTab == ContactsTab.groups,
            onTap: () => onChanged(ContactsTab.groups),
          ),
        ],
      ),
    );
  }
}

class _Segment extends StatelessWidget {
  const _Segment({required this.label, required this.selected, required this.onTap});

  final String label;
  final bool selected;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: GestureDetector(
        onTap: onTap,
        behavior: HitTestBehavior.opaque,
        child: AnimatedContainer(
          duration: const Duration(milliseconds: 180),
          curve: Curves.easeOut,
          alignment: Alignment.center,
          decoration: BoxDecoration(
            color: selected ? AppColors.brand500 : Colors.transparent,
            borderRadius: BorderRadius.circular(26),
          ),
          child: Text(
            label,
            style: AppTextStyles.body2Medium.copyWith(color: selected ? Colors.white : AppColors.neutral600),
          ),
        ),
      ),
    );
  }
}
