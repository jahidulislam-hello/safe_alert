/// Which segment of the top pill toggle is selected on the Home screen.
enum AlertTab { active, past }

/// Status of a historical / live alert.
enum AlertStatus { live, resolved }

/// A pending invitation to join an emergency group (Family, Work Emergency…).
class GroupInvitation {
  final String id;
  final String groupName;
  final String invitedBy;
  final String timeAgo;

  const GroupInvitation({
    required this.id,
    required this.groupName,
    required this.invitedBy,
    required this.timeAgo,
  });
}

/// A group the user already belongs to, shown under "My Groups".
class EmergencyGroup {
  final String id;
  final String name;
  final int memberCount;
  final int onlineCount;

  const EmergencyGroup({
    required this.id,
    required this.name,
    required this.memberCount,
    required this.onlineCount,
  });

  bool get hasOnlineMembers => onlineCount > 0;
}

/// A single SOS / emergency alert, either currently live or resolved history.
class EmergencyAlertModel {
  final String id;
  final String personName;
  final String personInitials;
  final String alertType; // e.g. "Assault", "Test Alert"
  final String? modeLabel; // e.g. "Emergency Mode"
  final String location;
  final String timeAgo;
  final AlertStatus status;
  final String? groupRelation; // e.g. "Family · Daughter"

  const EmergencyAlertModel({
    required this.id,
    required this.personName,
    required this.personInitials,
    required this.alertType,
    this.modeLabel,
    required this.location,
    required this.timeAgo,
    required this.status,
    this.groupRelation,
  });

  bool get isLive => status == AlertStatus.live;
}

/// A participant in a group emergency call.
enum CallParticipantStatus { joined, calling }

class CallParticipant {
  final String id;
  final String name;
  final String initials;
  final CallParticipantStatus status;

  const CallParticipant({
    required this.id,
    required this.name,
    required this.initials,
    required this.status,
  });
}
