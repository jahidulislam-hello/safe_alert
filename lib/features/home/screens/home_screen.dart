import 'package:safe_alert/core/utils/app_colors.dart';
import 'package:safe_alert/core/utils/app_styles.dart';
import 'package:flutter/material.dart';
import '../widgets/common_widgets.dart';
import 'activate_alert_screen.dart';

/// Home / Dashboard screen.
/// `hasActivity` toggles between the empty "No contacts yet" state
/// and the "Recent Activity" state once the user has contacts/history.
class HomeScreen extends StatefulWidget {
  final String userName;
  final bool hasActivity;

  const HomeScreen({
    super.key,
    this.userName = 'Sarah Johnson',
    this.hasActivity = false,
  });

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  void _goToActivate(BuildContext context) {
    Navigator.of(context).push(
      MaterialPageRoute(builder: (_) => const ActivateAlertScreen()),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.fromLTRB(20, 12, 20, 24),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              _buildHeader(),
              const SizedBox(height: 20),
              StatusBadge(
                label: 'Safe — No active alerts',
                background: AppColors.success50,
                foreground: AppColors.success700,
                leadingDot: Icons.circle,
              ),
              const SizedBox(height: 40),
              Center(child: _buildSosButton(context)),
              const SizedBox(height: 12),
              Center(
                child: Text(
                  'Hold for 1.5s to skip confirmation',
                  style: AppTextStyles.body4Regular.copyWith(color: AppColors.neutral500),
                ),
              ),
              const SizedBox(height: 32),
              AppFilledButton(
                label: 'Quick Emergency — Alert All Groups',
                background: AppColors.alarm500,
                icon: Icons.send_rounded,
                onPressed: () => _goToActivate(context),
              ),
              const SizedBox(height: 12),
              AppFilledButton(
                label: 'Create Emergency Alert',
                background: AppColors.brand600,
                icon: Icons.add,
                onPressed: () => _goToActivate(context),
              ),
              const SizedBox(height: 12),
              AppFilledButton(
                label: 'Test Emergency Alert',
                background: AppColors.neutral500,
                icon: Icons.add,
                onPressed: () => _goToActivate(context),
              ),
              const SizedBox(height: 28),
              if (widget.hasActivity) _buildRecentActivity() else _buildEmptyContacts(),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildHeader() {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text('Good morning',
                  style: AppTextStyles.body3Regular.copyWith(color: AppColors.neutral600)),
              Text(widget.userName,
                  style: AppTextStyles.h6Bold.copyWith(color: AppColors.neutral900)),
            ],
          ),
        ),
        const AppLogoMark(size: 40),
        const SizedBox(width: 8),
        Container(
          padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(20),
            border: Border.all(color: AppColors.neutral200),
          ),
          child: Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              const Icon(Icons.workspace_premium_outlined, size: 16, color: AppColors.neutral700),
              const SizedBox(width: 4),
              Text('Free', style: AppTextStyles.body4Medium.copyWith(color: AppColors.neutral700)),
            ],
          ),
        ),
        const SizedBox(width: 8),
        Container(
          padding: const EdgeInsets.all(8),
          decoration: BoxDecoration(shape: BoxShape.circle, color: AppColors.neutral50),
          child: const Icon(Icons.notifications_none_rounded, size: 20, color: AppColors.neutral800),
        ),
      ],
    );
  }

  Widget _buildSosButton(BuildContext context) {
    return GestureDetector(
      onTap: () => _goToActivate(context),
      child: Container(
        width: 200,
        height: 200,
        decoration: BoxDecoration(
          shape: BoxShape.circle,
          boxShadow: [
            BoxShadow(color: AppColors.alarm500.withOpacity(0.35), blurRadius: 60, spreadRadius: 10),
          ],
        ),
        child: Container(
          decoration: const BoxDecoration(
            shape: BoxShape.circle,
            gradient: RadialGradient(
              colors: [AppColors.warning200, AppColors.warning300],
            ),
          ),
          child: Center(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Text('SOS', style: AppTextStyles.h4Bold.copyWith(color: Colors.white)),
                const SizedBox(height: 4),
                Text('Tap or hold',
                    style: AppTextStyles.body3Medium.copyWith(color: Colors.white.withOpacity(0.9))),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildEmptyContacts() {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: AppColors.neutral100),
      ),
      child: Column(
        children: [
          Container(
            width: 56,
            height: 56,
            decoration: const BoxDecoration(shape: BoxShape.circle, color: AppColors.neutral50),
            child: const Icon(Icons.people_outline, color: AppColors.neutral500),
          ),
          const SizedBox(height: 16),
          Text('No contacts yet',
              style: AppTextStyles.body2Bold.copyWith(color: AppColors.neutral900)),
          const SizedBox(height: 4),
          Text(
            'Add people you trust. They\'ll be notified in emergencies.',
            textAlign: TextAlign.center,
            style: AppTextStyles.body4Regular.copyWith(color: AppColors.neutral500),
          ),
          const SizedBox(height: 16),
          SizedBox(
            width: 180,
            child: AppFilledButton(
              label: 'Add contact',
              background: AppColors.brand600,
              icon: Icons.add,
              height: 44,
              onPressed: () {},
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildRecentActivity() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text('RECENT ACTIVITY',
            style: AppTextStyles.caption1SemiBold.copyWith(
              color: AppColors.neutral500,
              letterSpacing: 0.5,
            )),
        const SizedBox(height: 12),
        _activityRow(
          title: 'Test alert sent',
          subtitle: '2h ago',
          badgeLabel: 'Test',
          badgeBg: AppColors.brand50,
          badgeFg: AppColors.brand700,
        ),
        const Divider(height: 24, color: AppColors.neutral100),
        _activityRow(
          title: 'Location shared with Family',
          subtitle: 'Yesterday',
          badgeLabel: 'Safe',
          badgeBg: AppColors.success50,
          badgeFg: AppColors.success700,
        ),
      ],
    );
  }

  Widget _activityRow({
    required String title,
    required String subtitle,
    required String badgeLabel,
    required Color badgeBg,
    required Color badgeFg,
  }) {
    return Row(
      children: [
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(title, style: AppTextStyles.body3Bold.copyWith(color: AppColors.neutral900)),
              const SizedBox(height: 2),
              Text(subtitle, style: AppTextStyles.body4Regular.copyWith(color: AppColors.neutral500)),
            ],
          ),
        ),
        StatusBadge(label: badgeLabel, background: badgeBg, foreground: badgeFg),
      ],
    );
  }
}
