import 'package:safe_alert/features/contacts/contact.dart';
import 'package:safe_alert/features/contacts/contact_group.dart';
import 'package:flutter/material.dart';


/// Drives the Create/Edit Group screen. The same controller powers both
/// modes — [isEditing] and [editingGroupId] are set when opened from a
/// group's Edit button, which flips the AppBar title and the primary
/// button label ("Save Group" → "Update Group") in the screen itself.
class CreateGroupController extends ChangeNotifier {
  CreateGroupController({
    required List<Contact> allContacts,
    required this.onSave,
    required this.onUpdate,
    ContactGroup? editingGroup,
  })  : _allContacts = allContacts,
        isEditing = editingGroup != null,
        editingGroupId = editingGroup?.id {
    groupNameController = TextEditingController(text: editingGroup?.name ?? '');
    if (editingGroup != null) {
      _members.addAll(editingGroup.members);
    }
  }

  final List<Contact> _allContacts;
  final ValueChanged<ContactGroup> onSave;
  final ValueChanged<ContactGroup> onUpdate;

  final bool isEditing;
  final String? editingGroupId;

  late final TextEditingController groupNameController;
  final TextEditingController searchController = TextEditingController();

  final List<Contact> _members = [];
  List<Contact> get members => List.unmodifiable(_members);

  static const int maxMembers = PlanLimits.maxMembersPerGroup;

  bool get isFull => _members.length >= maxMembers;

  /// Suggested contacts = all contacts not already added, filtered by the
  /// search box.
  List<Contact> get suggestedContacts {
    final query = searchController.text.trim().toLowerCase();
    return _allContacts.where((c) {
      final alreadyAdded = _members.any((m) => m.id == c.id);
      if (alreadyAdded) return false;
      if (query.isEmpty) return true;
      return c.name.toLowerCase().contains(query);
    }).toList();
  }

  bool get canSave => groupNameController.text.trim().isNotEmpty && _members.isNotEmpty;

  void addMember(Contact contact) {
    if (isFull) return;
    if (_members.any((m) => m.id == contact.id)) return;
    _members.add(contact);
    notifyListeners();
  }

  void removeMember(Contact contact) {
    _members.removeWhere((m) => m.id == contact.id);
    notifyListeners();
  }

  /// The "Add" button next to the search field: adds whatever name is
  /// typed as an ad-hoc member (for names not already in contacts).
  void addTypedMember() {
    final text = searchController.text.trim();
    if (text.isEmpty || isFull) return;
    _members.add(
      Contact(
        id: 'typed_${DateTime.now().microsecondsSinceEpoch}',
        name: text,
        relation: '',
        tag: ContactTag.family,
        avatarColor: kAvatarPalette[_members.length % kAvatarPalette.length],
      ),
    );
    searchController.clear();
    notifyListeners();
  }

  void onSearchChanged(String _) => notifyListeners();

  void onNameChanged(String _) => notifyListeners();

  void submit() {
    if (!canSave) return;
    final group = ContactGroup(
      id: editingGroupId ?? DateTime.now().microsecondsSinceEpoch.toString(),
      name: groupNameController.text.trim(),
      members: List.of(_members),
    );
    if (isEditing) {
      onUpdate(group);
    } else {
      onSave(group);
    }
  }

  @override
  void dispose() {
    groupNameController.dispose();
    searchController.dispose();
    super.dispose();
  }
}
