import 'package:safe_alert/core/utils/app_colors.dart';
import 'package:safe_alert/core/utils/app_styles.dart';
import 'package:safe_alert/features/contacts/add_contact_controller.dart';
import 'package:flutter/material.dart';

import 'status_dropdown_field.dart';

/// The "Add Contact" popup shown as a modal dialog: name field, status
/// dropdown, phone field, and the Add Contacts button.
class AddContactDialog extends StatefulWidget {
  const AddContactDialog({super.key, required this.controller});

  final AddContactController controller;

  @override
  State<AddContactDialog> createState() => _AddContactDialogState();
}

class _AddContactDialogState extends State<AddContactDialog> {
  AddContactController get controller => widget.controller;

  @override
  void initState() {
    super.initState();
    controller.addListener(_onChange);
  }

  @override
  void dispose() {
    controller.removeListener(_onChange);
    super.dispose();
  }

  void _onChange() => setState(() {});

  @override
  Widget build(BuildContext context) {
    return Dialog(
      backgroundColor: Colors.white,
      insetPadding: const EdgeInsets.symmetric(horizontal: 24),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(22)),
      child: Padding(
        padding: const EdgeInsets.all(20),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Expanded(
                  child: Text('Add Contact', style: AppTextStyles.h6Bold.copyWith(color: AppColors.brand900)),
                ),
                InkWell(
                  onTap: () => Navigator.of(context).maybePop(),
                  borderRadius: BorderRadius.circular(20),
                  child: Padding(
                    padding: const EdgeInsets.all(4),
                    child: Icon(Icons.close_rounded, color: AppColors.neutral500, size: 22),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 18),
            _FieldWrapper(
              child: TextField(
                controller: controller.nameController,
                onChanged: (_) => controller.refresh(),
                style: AppTextStyles.body3Regular.copyWith(color: AppColors.brand900),
                decoration: _inputDecoration('Contact Name'),
              ),
            ),
            const SizedBox(height: 12),
            StatusDropdownField(value: controller.selectedStatus, onChanged: controller.setStatus),
            const SizedBox(height: 12),
            _FieldWrapper(
              child: TextField(
                controller: controller.phoneController,
                onChanged: (_) => controller.refresh(),
                keyboardType: TextInputType.phone,
                style: AppTextStyles.body3Regular.copyWith(color: AppColors.brand900),
                decoration: _inputDecoration('Enter Phone Number'),
              ),
            ),
            const SizedBox(height: 18),
            SizedBox(
              width: double.infinity,
              child: ElevatedButton(
                onPressed: () {
                  final added = controller.submit();
                  if (added) Navigator.of(context).maybePop();
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: AppColors.brand500,
                  foregroundColor: Colors.white,
                  elevation: 0,
                  padding: const EdgeInsets.symmetric(vertical: 15),
                  shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
                ),
                child: Text('Add Contacts', style: AppTextStyles.body2Bold),
              ),
            ),
          ],
        ),
      ),
    );
  }

  InputDecoration _inputDecoration(String hint) {
    return InputDecoration(
      hintText: hint,
      hintStyle: AppTextStyles.body3Regular.copyWith(color: AppColors.neutral400),
      contentPadding: const EdgeInsets.symmetric(horizontal: 14, vertical: 14),
      border: InputBorder.none,
    );
  }
}

class _FieldWrapper extends StatelessWidget {
  const _FieldWrapper({required this.child});
  final Widget child;

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(14),
        border: Border.all(color: AppColors.neutral200),
      ),
      child: child,
    );
  }
}
