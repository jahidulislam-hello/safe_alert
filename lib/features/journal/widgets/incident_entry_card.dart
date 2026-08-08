import 'package:safe_alert/core/utils/app_colors.dart';
import 'package:safe_alert/core/utils/app_styles.dart';
import 'package:flutter/material.dart';
import '../models/incident_entry.dart';


/// A single journal entry card: category chip + date on top, description
/// below. Chip color follows the entry's [IncidentCategory].
class IncidentEntryCard extends StatelessWidget {
  const IncidentEntryCard({super.key, required this.entry});

  final IncidentEntry entry;

  @override
  Widget build(BuildContext context) {
    final colors = _chipColors(entry.category);

    return Container(
      width: double.infinity,
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
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 5),
                decoration: BoxDecoration(
                  color: colors.background,
                  borderRadius: BorderRadius.circular(20),
                ),
                child: Text(
                  entry.category.label,
                  style: AppTextStyles.body4Medium.copyWith(color: colors.foreground),
                ),
              ),
              const Spacer(),
              Text(
                _formatDate(entry.date),
                style: AppTextStyles.body4Regular.copyWith(color: AppColors.neutral400),
              ),
            ],
          ),
          const SizedBox(height: 10),
          Text(
            entry.description,
            style: AppTextStyles.body3Regular.copyWith(color: AppColors.neutral700),
          ),
        ],
      ),
    );
  }

  _ChipColors _chipColors(IncidentCategory category) {
    switch (category) {
      case IncidentCategory.incident:
        return const _ChipColors(background: AppColors.alarm50, foreground: AppColors.alarm600);
      case IncidentCategory.test:
        return const _ChipColors(background: AppColors.brand100, foreground: AppColors.brand700);
      case IncidentCategory.update:
        return const _ChipColors(background: AppColors.success50, foreground: AppColors.success700);
    }
  }

  static String _formatDate(DateTime date) {
    const months = [
      'Jan', 'Feb', 'Mar', 'Apr', 'May', 'Jun',
      'Jul', 'Aug', 'Sep', 'Oct', 'Nov', 'Dec',
    ];
    return '${months[date.month - 1]} ${date.day}, ${date.year}';
  }
}

class _ChipColors {
  const _ChipColors({required this.background, required this.foreground});
  final Color background;
  final Color foreground;
}
