import 'package:safe_alert/features/alerts/controllers/alert_controller.dart';

import '/core/utils/app_colors.dart';
import '/core/utils/app_styles.dart';
import 'package:flutter/material.dart';
import '../models/emergency_models.dart';
import '../widgets/alert_tab_toggle.dart';
import '../widgets/app_top_bar.dart';
import '../widgets/group_invitation_card.dart';
import '../widgets/list_tiles.dart';
import '../widgets/live_emergency_banner.dart';
import '../widgets/no_active_alert_placeholder.dart';
import 'live_alert_screen.dart';

/// Covers all three Home states from the design: no active alert + pending
/// invitations, a live emergency in progress, and the Past alerts list.
class AlertScreen extends StatefulWidget {
  const AlertScreen({super.key, required this.controller});

  final AlertController controller;

  @override
  State<AlertScreen> createState() => _AlertScreenState();
}

class _AlertScreenState extends State<AlertScreen> {
  AlertController get controller => widget.controller;

  @override
  void initState() {
    super.initState();
    controller.init();
    controller.addListener(_onChange);
  }

  @override
  void dispose() {
    controller.removeListener(_onChange);
    super.dispose();
  }

  void _onChange() => setState(() {});

  void _openLiveAlert() {
    final alert = controller.liveAlert;
    if (alert == null) return;
    Navigator.of(context).push(
      MaterialPageRoute(builder: (_) => LiveAlertScreen(alert: alert)),
    );
  }

  @override
  Widget build(BuildContext context) {
    final liveAlert = controller.liveAlert;

    return Scaffold(
      backgroundColor: AppColors.neutral50,
      body: SafeArea(
        child: ListView(
          padding: const EdgeInsets.fromLTRB(20, 12, 20, 24),
          children: [
            AppTopBar(userName: controller.userName, hasUnreadNotifications: liveAlert != null),
            const SizedBox(height: 18),
            if (liveAlert != null) ...[
              LiveEmergencyTopBanner(alert: liveAlert, onTap: _openLiveAlert),
              const SizedBox(height: 18),
            ],
            AlertTabToggle(
              currentTab: controller.currentTab,
              activeCount: controller.activeAlertCount,
              onChanged: controller.setTab,
            ),
            const SizedBox(height: 24),
            if (controller.currentTab == AlertTab.active)
              _ActiveTabBody(controller: controller, onOpenLiveAlert: _openLiveAlert)
            else
              _PastTabBody(controller: controller),
          ],
        ),
      ),
    );
  }
}

class _ActiveTabBody extends StatelessWidget {
  const _ActiveTabBody({required this.controller, required this.onOpenLiveAlert});

  final AlertController controller;
  final VoidCallback onOpenLiveAlert;

  @override
  Widget build(BuildContext context) {
    final liveAlert = controller.liveAlert;

    if (liveAlert != null) {
      return Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          LiveAlertSummaryCard(
            alert: liveAlert,
            onJoinCall: onOpenLiveAlert,
            onMessage: onOpenLiveAlert,
          ),
          const SizedBox(height: 28),
          const SectionLabel('MY GROUPS'),
          const SizedBox(height: 12),
          ...controller.myGroups.map((g) => EmergencyGroupTile(group: g)),
        ],
      );
    }

    return Column(
      children: [
        const SizedBox(height: 12),
        const NoActiveAlertPlaceholder(),
        const SizedBox(height: 40),
        Align(
          alignment: Alignment.centerLeft,
          child: Text(
            'Join an Emergency Group',
            style: AppTextStyles.h5Bold.copyWith(color: AppColors.brand900),
          ),
        ),
        const SizedBox(height: 6),
        Align(
          alignment: Alignment.centerLeft,
          child: Text(
            'please ! Accept or Reject the pending invitation',
            style: AppTextStyles.body3Regular.copyWith(color: AppColors.neutral500),
          ),
        ),
        const SizedBox(height: 20),
        ...controller.invitations.map(
          (inv) => Padding(
            padding: const EdgeInsets.only(bottom: 14),
            child: GroupInvitationCard(
              invitation: inv,
              onAccept: () => controller.acceptInvitation(inv.id),
              onDecline: () => controller.declineInvitation(inv.id),
            ),
          ),
        ),
        const SizedBox(height: 8),
        TextButton(
          onPressed: () {
            // TODO: route to "join a group later" flow / dismiss for session.
          },
          child: Text(
            'Skip for now — join a group later',
            style: AppTextStyles.body3Regular.copyWith(color: AppColors.neutral400),
          ),
        ),
      ],
    );
  }
}

class _PastTabBody extends StatelessWidget {
  const _PastTabBody({required this.controller});

  final AlertController controller;

  @override
  Widget build(BuildContext context) {
    if (controller.pastAlerts.isEmpty) {
      return const NoActiveAlertPlaceholder();
    }
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const SectionLabel('Past 7 Days'),
        const SizedBox(height: 12),
        ...controller.pastAlerts.map((a) => PastAlertTile(alert: a)),
      ],
    );
  }
}
