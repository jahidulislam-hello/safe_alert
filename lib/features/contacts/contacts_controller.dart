import 'package:safe_alert/features/contacts/contact.dart';
import 'package:safe_alert/features/contacts/contact_group.dart';
import 'package:flutter/material.dart';


enum ContactsTab { all, groups }

/// Drives the Contacts screen: the All Contacts / Groups pill toggle, the
/// contacts list, and the groups list (with free-plan limits). Also owns
/// the mutations that come back from the Add Contact dialog and the
/// Create/Edit Group screen.
class ContactsController extends ChangeNotifier {
  ContactsController() {
    _seed();
  }

  ContactsTab currentTab = ContactsTab.all;

  final List<Contact> _contacts = [];
  final List<ContactGroup> _groups = [];

  List<Contact> get contacts => List.unmodifiable(_contacts);
  List<ContactGroup> get groups => List.unmodifiable(_groups);

  bool get canCreateMoreGroups => _groups.length < PlanLimits.maxGroups;

  void _seed() {
    _contacts.addAll([
      Contact(id: 'c1', name: 'James Johnson', relation: 'Father', tag: ContactTag.family, avatarColor: kAvatarPalette[0]),
      Contact(id: 'c2', name: 'Emma Smith', relation: 'Sister', tag: ContactTag.family, avatarColor: kAvatarPalette[1]),
      Contact(id: 'c3', name: 'David Lee', relation: 'Friend', tag: ContactTag.work, avatarColor: kAvatarPalette[2]),
      Contact(id: 'c4', name: 'Rachel Kim', relation: 'Colleague', tag: ContactTag.work, avatarColor: kAvatarPalette[3]),
      Contact(id: 'c5', name: 'Tom Wilson', relation: 'Neighbor', tag: ContactTag.family, avatarColor: kAvatarPalette[4]),
    ]);

    _groups.addAll([
      ContactGroup(id: 'g_family', name: 'Family', members: _contacts.sublist(0, 3)),
      ContactGroup(id: 'g_work', name: 'Work Emergency', members: _contacts.sublist(2, 4)),
    ]);
  }

  void setTab(ContactsTab tab) {
    if (currentTab == tab) return;
    currentTab = tab;
    notifyListeners();
  }

  /// Called by AddContactController on submit.
  void addContact(Contact contact) {
    _contacts.insert(0, contact);
    notifyListeners();
  }

  /// Called by CreateGroupController on Save (new group).
  void addGroup(ContactGroup group) {
    _groups.insert(0, group);
    notifyListeners();
  }

  /// Called by CreateGroupController on Update (existing group).
  void updateGroup(ContactGroup group) {
    final index = _groups.indexWhere((g) => g.id == group.id);
    if (index == -1) return;
    _groups[index] = group;
    notifyListeners();
  }
}
