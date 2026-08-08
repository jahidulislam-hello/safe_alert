import 'package:safe_alert/core/utils/app_colors.dart';
import 'package:safe_alert/core/utils/app_styles.dart';
import 'package:safe_alert/features/contacts/contact_group.dart';
import 'package:safe_alert/features/contacts/contacts_controller.dart';
import 'package:safe_alert/features/contacts/create_group_controller.dart';
import 'package:safe_alert/features/contacts/create_group_widgets.dart';
import 'package:flutter/material.dart';


/// Doubles as both "Create Group" and "Edit Group": when opened with
/// [editingGroup] non-null, the AppBar title reads "Edit Group" and the
/// primary button reads "Update Group" instead of "Save Group" — same
/// screen and controller, just driven by CreateGroupController.isEditing.
class CreateGroupScreen extends StatefulWidget {
  const CreateGroupScreen({
    super.key,
    required this.contactsController,
    this.editingGroup,
  });

  final ContactsController contactsController;
  final ContactGroup? editingGroup;

  @override
  State<CreateGroupScreen> createState() => _CreateGroupScreenState();
}

class _CreateGroupScreenState extends State<CreateGroupScreen> {
  late final CreateGroupController controller = CreateGroupController(
    allContacts: widget.contactsController.contacts,
    editingGroup: widget.editingGroup,
    onSave: (group) {
      widget.contactsController.addGroup(group);
      Navigator.of(context).maybePop();
    },
    onUpdate: (group) {
      widget.contactsController.updateGroup(group);
      Navigator.of(context).maybePop();
    },
  );

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
    final isEditing = controller.isEditing;

    return Scaffold(
      backgroundColor: AppColors.neutral50,
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.fromLTRB(20, 12, 20, 20),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  InkWell(
                    onTap: () => Navigator.of(context).maybePop(),
                    borderRadius: BorderRadius.circular(20),
                    child: Padding(
                      padding: const EdgeInsets.all(4),
                      child: Icon(Icons.arrow_back, color: AppColors.brand900),
                    ),
                  ),
                  const SizedBox(width: 4),
                  Text(
                    isEditing ? 'Edit Group' : 'Create Group',
                    style: AppTextStyles.h6Bold.copyWith(color: AppColors.brand900),
                  ),
                ],
              ),
              const SizedBox(height: 20),
              Expanded(
                child: ListView(
                  children: [
                    Text('Group Name', style: AppTextStyles.body3Medium.copyWith(color: AppColors.neutral600)),
                    const SizedBox(height: 8),
                    _FieldWrapper(
                      child: TextField(
                        controller: controller.groupNameController,
                        onChanged: controller.onNameChanged,
                        style: AppTextStyles.body3Regular.copyWith(color: AppColors.brand900),
                        decoration: InputDecoration(
                          hintText: 'e.g. Family , close friends...',
                          hintStyle: AppTextStyles.body3Regular.copyWith(color: AppColors.neutral400),
                          border: InputBorder.none,
                          contentPadding: const EdgeInsets.symmetric(horizontal: 14, vertical: 14),
                        ),
                      ),
                    ),
                    const SizedBox(height: 22),
                    Row(
                      children: [
                        Text(
                          'ADD MEMBERS',
                          style: AppTextStyles.caption1SemiBold.copyWith(color: AppColors.neutral500, letterSpacing: 0.4),
                        ),
                        const Spacer(),
                        Text(
                          '${controller.members.length}/${CreateGroupController.maxMembers}',
                          style: AppTextStyles.caption1SemiBold.copyWith(color: AppColors.brand600),
                        ),
                      ],
                    ),
                    const SizedBox(height: 10),
                    if (controller.members.isNotEmpty)
                      Wrap(
                        spacing: 8,
                        runSpacing: 8,
                        children: controller.members
                            .map((m) => MemberChip(contact: m, onRemove: () => controller.removeMember(m)))
                            .toList(),
                      ),
                    const SizedBox(height: 12),
                    Row(
                      crossAxisAlignment: CrossAxisAlignment.stretch,
                      children: [
                        Expanded(
                          child: _FieldWrapper(
                            child: TextField(
                              controller: controller.searchController,
                              onChanged: controller.onSearchChanged,
                              style: AppTextStyles.body3Regular.copyWith(color: AppColors.brand900),
                              decoration: InputDecoration(
                                hintText: 'Search or type a name...',
                                hintStyle: AppTextStyles.body3Regular.copyWith(color: AppColors.neutral400),
                                border: InputBorder.none,
                                contentPadding: const EdgeInsets.symmetric(horizontal: 14, vertical: 14),
                              ),
                            ),
                          ),
                        ),
                        const SizedBox(width: 10),
                        ElevatedButton(
                          onPressed: controller.isFull ? null : controller.addTypedMember,
                          style: ElevatedButton.styleFrom(
                            backgroundColor: AppColors.brand500,
                            foregroundColor: Colors.white,
                            elevation: 0,
                            padding: const EdgeInsets.symmetric(horizontal: 22),
                            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(14)),
                          ),
                          child: Text('Add', style: AppTextStyles.body3Bold),
                        ),
                      ],
                    ),
                    const SizedBox(height: 20),
                    Text(
                      'Suggested from contacts',
                      style: AppTextStyles.body3Medium.copyWith(color: AppColors.neutral500),
                    ),
                    for (final contact in controller.suggestedContacts)
                      SuggestedContactTile(
                        contact: contact,
                        onAdd: () => controller.addMember(contact),
                      ),
                  ],
                ),
              ),
              const SizedBox(height: 12),
              SizedBox(
                width: double.infinity,
                child: ElevatedButton(
                  onPressed: controller.canSave ? controller.submit : null,
                  style: ElevatedButton.styleFrom(
                    backgroundColor: AppColors.brand500,
                    disabledBackgroundColor: AppColors.brand200,
                    foregroundColor: Colors.white,
                    elevation: 0,
                    padding: const EdgeInsets.symmetric(vertical: 16),
                    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(30)),
                  ),
                  child: Text(isEditing ? 'Update Group' : 'Save Group', style: AppTextStyles.body2Bold),
                ),
              ),
            ],
          ),
        ),
      ),
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
        color: Colors.white,
        borderRadius: BorderRadius.circular(14),
        border: Border.all(color: AppColors.neutral200),
      ),
      child: child,
    );
  }
}
