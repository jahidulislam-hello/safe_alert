import '/core/utils/app_colors.dart';
import '/core/utils/app_styles.dart';
import 'package:flutter/material.dart';


/// The centered "No Active Alert yet" illustration + caption shown when the
/// Active tab has nothing to display.
class NoActiveAlertPlaceholder extends StatelessWidget {
  const NoActiveAlertPlaceholder({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Container(
          width: 96,
          height: 96,
          decoration: BoxDecoration(
            color: AppColors.brand50,
            borderRadius: BorderRadius.circular(24),
          ),
          alignment: Alignment.center,
          // Swap for Image.asset('assets/no_alert.png') to match the
          // illustration exactly.
          child: Icon(
            Icons.phonelink_erase_rounded,
            size: 44,
            color: AppColors.brand400,
          ),
        ),
        const SizedBox(height: 16),
        Text(
          'No Active Alert yet',
          style: AppTextStyles.body2Medium.copyWith(color: AppColors.neutral600),
        ),
      ],
    );
  }
}
