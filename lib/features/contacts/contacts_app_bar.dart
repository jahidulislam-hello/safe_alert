import 'package:safe_alert/core/utils/app_colors.dart';
import 'package:safe_alert/core/utils/app_styles.dart' show AppTextStyles;
import 'package:flutter/material.dart';


/// "Contacts" title + crest mark + round blue "+" button, used at the top
/// of the Contacts screen (both the All Contacts and Groups tabs).
class ContactsAppBar extends StatelessWidget {
  const ContactsAppBar({super.key, required this.onAddPressed});

  final VoidCallback onAddPressed;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Expanded(
          child: Text('Contacts', style: AppTextStyles.h6Bold.copyWith(color: AppColors.brand900)),
        ),
        SizedBox(
          width: 40,
          height: 40,
          child: Icon(Icons.shield_moon_outlined, size: 26, color: AppColors.neutral300),
        ),
        const SizedBox(width: 12),
        Material(
          color: AppColors.brand500,
          shape: const CircleBorder(),
          child: InkWell(
            customBorder: const CircleBorder(),
            onTap: onAddPressed,
            child: const SizedBox(
              width: 40,
              height: 40,
              child: Icon(Icons.add_rounded, color: Colors.white, size: 22),
            ),
          ),
        ),
      ],
    );
  }
}
