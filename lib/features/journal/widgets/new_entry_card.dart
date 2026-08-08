import 'package:safe_alert/core/utils/app_colors.dart';
import 'package:safe_alert/core/utils/app_styles.dart';
import 'package:flutter/material.dart';



/// The "New Entry" card shown when composing: a multiline textfield plus
/// Save / Cancel actions. Save is disabled (dimmed) until there's text.
class NewEntryCard extends StatelessWidget {
  const NewEntryCard({
    super.key,
    required this.controller,
    required this.canSave,
    required this.onSave,
    required this.onCancel,
    required this.onChanged,
  });

  final TextEditingController controller;
  final bool canSave;
  final VoidCallback onSave;
  final VoidCallback onCancel;
  final ValueChanged<String> onChanged;

  @override
  Widget build(BuildContext context) {
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
          Text(
            'New Entry',
            style: AppTextStyles.body2Bold.copyWith(color: AppColors.brand900),
          ),
          const SizedBox(height: 12),
          TextField(
            controller: controller,
            onChanged: onChanged,
            minLines: 3,
            maxLines: 6,
            style: AppTextStyles.body3Regular.copyWith(color: AppColors.brand900),
            decoration: InputDecoration(
              hintText: 'Describe the incident or update...',
              hintStyle: AppTextStyles.body3Regular.copyWith(color: AppColors.neutral400),
              filled: true,
              fillColor: AppColors.brand50.withValues(alpha: 0.5),
              contentPadding: const EdgeInsets.all(14),
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(14),
                borderSide: BorderSide.none,
              ),
              enabledBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(14),
                borderSide: BorderSide.none,
              ),
              focusedBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(14),
                borderSide: BorderSide(color: AppColors.brand300, width: 1.4),
              ),
            ),
          ),
          const SizedBox(height: 14),
          Row(
            children: [
              Expanded(
                child: ElevatedButton(
                  onPressed: canSave ? onSave : null,
                  style: ElevatedButton.styleFrom(
                    backgroundColor: AppColors.brand500,
                    disabledBackgroundColor: AppColors.brand200,
                    foregroundColor: Colors.white,
                    elevation: 0,
                    padding: const EdgeInsets.symmetric(vertical: 14),
                    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(14)),
                  ),
                  child: Text('Save', style: AppTextStyles.body3Bold),
                ),
              ),
              const SizedBox(width: 10),
              Expanded(
                child: OutlinedButton(
                  onPressed: onCancel,
                  style: OutlinedButton.styleFrom(
                    foregroundColor: AppColors.neutral500,
                    side: BorderSide(color: AppColors.neutral200),
                    padding: const EdgeInsets.symmetric(vertical: 14),
                    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(14)),
                  ),
                  child: Text('Cancel', style: AppTextStyles.body3Medium),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
