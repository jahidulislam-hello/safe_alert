import 'package:flutter/foundation.dart';
import '../models/emergency_models.dart';

/// Drives the Home screen: the Active/Past pill toggle, the list of pending
/// group invitations, the user's groups, and whichever alert (if any) is
/// currently live. Swap the demo data / TODOs for real API calls.
class AlertController extends ChangeNotifier {
  AlertController({required this.userName});

  final String userName;

  AlertTab _currentTab = AlertTab.active;
  AlertTab get currentTab => _currentTab;

  final List<GroupInvitation> _pendingInvitations = const [
    GroupInvitation(
      id: 'inv_family',
      groupName: 'Family',
      invitedBy: 'Sarah Johnson',
      timeAgo: '2 min ago',
    ),
    GroupInvitation(
      id: 'inv_work',
      groupName: 'Work Emergency',
      invitedBy: 'Sarah Johnson',
      timeAgo: '2 min ago',
    ),
  ];
  List<GroupInvitation> _invitations = [];

  final List<EmergencyGroup> myGroups = const [
    EmergencyGroup(id: 'g_family', name: 'Family', memberCount: 4, onlineCount: 2),
    EmergencyGroup(id: 'g_work', name: 'Work Emergency', memberCount: 4, onlineCount: 2),
  ];

  final List<EmergencyAlertModel> pastAlerts = const [
    EmergencyAlertModel(
      id: 'past_1',
      personName: 'Sarah Johnson',
      personInitials: 'SJ',
      alertType: 'Test Alert',
      location: '',
      timeAgo: '2 days ago',
      status: AlertStatus.resolved,
    ),
    EmergencyAlertModel(
      id: 'past_2',
      personName: 'Sarah Johnson',
      personInitials: 'SJ',
      alertType: 'Test Alert',
      location: '',
      timeAgo: '2 days ago',
      status: AlertStatus.resolved,
    ),
  ];

  /// Null when nobody currently has a live SOS out.
  EmergencyAlertModel? liveAlert;

  bool _initialized = false;

  void init() {
    if (_initialized) return;
    _initialized = true;
    _invitations = List.of(_pendingInvitations);
    notifyListeners();
  }

  List<GroupInvitation> get invitations => List.unmodifiable(_invitations);
  int get activeAlertCount => liveAlert != null ? 1 : 0;

  void setTab(AlertTab tab) {
    if (_currentTab == tab) return;
    _currentTab = tab;
    notifyListeners();
  }

  void acceptInvitation(String id) {
    _invitations.removeWhere((i) => i.id == id);
    // TODO: call API to join group, then add it to myGroups.
    notifyListeners();
  }

  void declineInvitation(String id) {
    _invitations.removeWhere((i) => i.id == id);
    notifyListeners();
  }

  /// Demo helper so you can preview the "live emergency" state without a
  /// backend — call this to simulate Sarah triggering an SOS.
  void simulateIncomingAlert() {
    liveAlert = const EmergencyAlertModel(
      id: 'live_1',
      personName: 'Sarah Johnson',
      personInitials: 'SJ',
      alertType: 'Assault',
      modeLabel: 'Emergency Mode',
      location: '123 Main St, New York',
      timeAgo: '4 min ago',
      status: AlertStatus.live,
      groupRelation: 'Family · Daughter',
    );
    notifyListeners();
  }

  void clearLiveAlert() {
    liveAlert = null;
    notifyListeners();
  }
}
