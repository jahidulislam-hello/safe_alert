import 'package:safe_alert/core/utils/app_colors.dart';
import 'package:safe_alert/core/utils/app_styles.dart';
import 'package:safe_alert/features/contacts/contact.dart';
import 'package:flutter/material.dart';


/// Rounded-border dropdown for picking a [ContactStatus], styled to match
/// the plain text fields around it.
class StatusDropdownField extends StatelessWidget {
  const StatusDropdownField({super.key, required this.value, required this.onChanged});

  final ContactStatus? value;
  final ValueChanged<ContactStatus?> onChanged;

  @override
  Widget build(BuildContext context) {
    return DropdownButtonFormField<ContactStatus>(
      value: value,
      icon: Icon(Icons.keyboard_arrow_down_rounded, color: AppColors.neutral400),
      isExpanded: true,
      style: AppTextStyles.body3Regular.copyWith(color: AppColors.brand900),
      hint: Text('Status', style: AppTextStyles.body3Regular.copyWith(color: AppColors.neutral400)),
      decoration: InputDecoration(
        contentPadding: const EdgeInsets.symmetric(horizontal: 14, vertical: 14),
        filled: true,
        fillColor: Colors.white,
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(14),
          borderSide: BorderSide(color: AppColors.neutral200),
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(14),
          borderSide: BorderSide(color: AppColors.neutral200),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(14),
          borderSide: BorderSide(color: AppColors.brand300, width: 1.4),
        ),
      ),
      items: ContactStatus.values
          .map((status) => DropdownMenuItem(value: status, child: Text(status.label)))
          .toList(),
      onChanged: onChanged,
    );
  }
}
