import 'package:safe_alert/core/utils/app_colors.dart';
import 'package:safe_alert/core/utils/app_styles.dart';
import 'package:safe_alert/features/contacts/add_contact_controller.dart';
import 'package:safe_alert/features/contacts/add_contact_dialog.dart';
import 'package:safe_alert/features/contacts/contact_group.dart';
import 'package:safe_alert/features/contacts/contact_list_tile.dart';
import 'package:safe_alert/features/contacts/contacts_app_bar.dart';
import 'package:safe_alert/features/contacts/contacts_controller.dart';
import 'package:safe_alert/features/contacts/contacts_tab_toggle.dart';
import 'package:safe_alert/features/contacts/free_plan_banner.dart';
import 'package:safe_alert/features/contacts/group_card.dart';
import 'package:flutter/material.dart';

import 'create_group_screen.dart';
import 'group_chat_screen.dart';

/// The Contacts screen: All Contacts list on one tab, Groups list (with
/// free-plan banner + progress bars) on the other. The "+" opens the Add
/// Contact popup; "Add New Group" and each card's "Edit" push
/// CreateGroupScreen; "Chat" pushes GroupChatScreen.
class ContactsScreen extends StatefulWidget {
  const ContactsScreen({super.key, required this.controller});

  final ContactsController controller;

  @override
  State<ContactsScreen> createState() => _ContactsScreenState();
}

class _ContactsScreenState extends State<ContactsScreen> {
  ContactsController get controller => widget.controller;

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

  void _openAddContactDialog() {
    showDialog(
      context: context,
      builder: (_) => AddContactDialog(
        controller: AddContactController(onSubmit: controller.addContact),
      ),
    );
  }

  void _openCreateGroup() {
    Navigator.of(context).push(
      MaterialPageRoute(
        builder: (_) => CreateGroupScreen(
          contactsController: controller,
          editingGroup: null,
        ),
      ),
    );
  }

  void _openEditGroup(ContactGroup group) {
    Navigator.of(context).push(
      MaterialPageRoute(
        builder: (_) => CreateGroupScreen(
          contactsController: controller,
          editingGroup: group,
        ),
      ),
    );
  }

  void _openChat(ContactGroup group) {
    Navigator.of(context).push(
      MaterialPageRoute(builder: (_) => GroupChatScreen(group: group)),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.neutral50,
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.fromLTRB(20, 12, 20, 0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              ContactsAppBar(onAddPressed: _openAddContactDialog),
              const SizedBox(height: 18),
              ContactsTabToggle(currentTab: controller.currentTab, onChanged: controller.setTab),
              const SizedBox(height: 20),
              Expanded(
                child: controller.currentTab == ContactsTab.all
                    ? _AllContactsList(controller: controller)
                    : _GroupsList(
                        controller: controller,
                        onAddNewGroup: _openCreateGroup,
                        onEditGroup: _openEditGroup,
                        onChatGroup: _openChat,
                      ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class _AllContactsList extends StatelessWidget {
  const _AllContactsList({required this.controller});
  final ContactsController controller;

  @override
  Widget build(BuildContext context) {
    final contacts = controller.contacts;
    return ListView.separated(
      itemCount: contacts.length,
      separatorBuilder: (_, __) => Divider(height: 1, color: AppColors.neutral100),
      itemBuilder: (_, i) => ContactListTile(contact: contacts[i]),
    );
  }
}

class _GroupsList extends StatelessWidget {
  const _GroupsList({
    required this.controller,
    required this.onAddNewGroup,
    required this.onEditGroup,
    required this.onChatGroup,
  });

  final ContactsController controller;
  final VoidCallback onAddNewGroup;
  final ValueChanged<ContactGroup> onEditGroup;
  final ValueChanged<ContactGroup> onChatGroup;

  @override
  Widget build(BuildContext context) {
    final groups = controller.groups;
    final canCreate = controller.canCreateMoreGroups;
    final barColors = [AppColors.brand500, AppColors.success500];

    return ListView(
      padding: const EdgeInsets.only(bottom: 24),
      children: [
        FreePlanBanner(groupCount: groups.length, onUpgrade: () {}),
        const SizedBox(height: 16),
        for (int i = 0; i < groups.length; i++) ...[
          GroupCard(
            group: groups[i],
            progressColor: barColors[i % barColors.length],
            onChat: () => onChatGroup(groups[i]),
            onEdit: () => onEditGroup(groups[i]),
          ),
          const SizedBox(height: 12),
        ],
        Material(
          color: AppColors.neutral100,
          borderRadius: BorderRadius.circular(16),
          child: InkWell(
            borderRadius: BorderRadius.circular(16),
            onTap: canCreate ? onAddNewGroup : null,
            child: Padding(
              padding: const EdgeInsets.symmetric(vertical: 16),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(Icons.add_rounded, color: AppColors.neutral500, size: 18),
                  const SizedBox(width: 6),
                  Text(
                    canCreate ? 'Add New Group' : 'Add New Group (Upgrade Required)',
                    style: AppTextStyles.body3Medium.copyWith(color: AppColors.neutral500),
                  ),
                ],
              ),
            ),
          ),
        ),
      ],
    );
  }
}
