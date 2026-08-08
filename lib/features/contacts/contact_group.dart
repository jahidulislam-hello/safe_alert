import 'contact.dart';

/// Free-plan limits shown on the Groups tab banner.
class PlanLimits {
  static const int maxGroups = 2;
  static const int maxMembersPerGroup = 5;
}

class ContactGroup {
  final String id;
  final String name;
  final List<Contact> members;

  const ContactGroup({
    required this.id,
    required this.name,
    required this.members,
  });

  int get memberCount => members.length;

  double get progress => (memberCount / PlanLimits.maxMembersPerGroup).clamp(0, 1);

  ContactGroup copyWith({String? name, List<Contact>? members}) {
    return ContactGroup(
      id: id,
      name: name ?? this.name,
      members: members ?? this.members,
    );
  }
}
