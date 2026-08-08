import 'package:safe_alert/core/utils/app_colors.dart';
import 'package:flutter/material.dart';


/// The relationship options offered in the Add Contact dropdown.
enum ContactStatus { father, mother, brother, sister, others }

extension ContactStatusLabel on ContactStatus {
  String get label {
    switch (this) {
      case ContactStatus.father:
        return 'Father';
      case ContactStatus.mother:
        return 'Mother';
      case ContactStatus.brother:
        return 'Brother';
      case ContactStatus.sister:
        return 'Sister';
      case ContactStatus.others:
        return 'Others';
    }
  }
}

/// Which group tag a contact/group is filed under, driving the small
/// pill color on the contacts list.
enum ContactTag { family, work }

extension ContactTagLabel on ContactTag {
  String get label => this == ContactTag.family ? 'Family' : 'Work';
}

/// A rotating set of avatar colors so seeded contacts look distinct,
/// same idea as the initials-avatar chips in the mockup.
const List<Color> kAvatarPalette = [
  AppColors.brand600,
  Color(0xFF8B5CF6), // violet, matches "ES" avatar in the design
  Color(0xFF14B8A6), // teal, matches "DL" avatar
  AppColors.success600,
  Color(0xFFD97706), // amber/orange, matches "TW" avatar
];

class Contact {
  final String id;
  final String name;
  final String relation; // free-text subtitle, e.g. "Father", "Friend"
  final ContactTag tag;
  final Color avatarColor;

  const Contact({
    required this.id,
    required this.name,
    required this.relation,
    required this.tag,
    required this.avatarColor,
  });

  String get initials {
    final parts = name.trim().split(RegExp(r'\s+'));
    if (parts.isEmpty) return '';
    if (parts.length == 1) return parts.first.substring(0, 1).toUpperCase();
    return (parts.first.substring(0, 1) + parts.last.substring(0, 1)).toUpperCase();
  }
}
