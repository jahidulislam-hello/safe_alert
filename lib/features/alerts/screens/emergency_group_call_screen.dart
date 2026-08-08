import '/core/utils/app_colors.dart';
import '/core/utils/app_styles.dart';
import 'package:flutter/material.dart';
import '../models/emergency_models.dart';


/// Dark, full-screen active call UI for the emergency group: sender tile up
/// top, participant grid, quick-response chips, and call controls.
class EmergencyGroupCallScreen extends StatelessWidget {
  EmergencyGroupCallScreen({super.key, required this.alert});

  final EmergencyAlertModel alert;

  final List<CallParticipant> participants = const [
    CallParticipant(id: 'james', name: 'James', initials: 'JJ', status: CallParticipantStatus.joined),
    CallParticipant(id: 'emma', name: 'Emma', initials: 'ES', status: CallParticipantStatus.joined),
    CallParticipant(id: 'mike', name: 'Mike', initials: 'M', status: CallParticipantStatus.calling),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.brand950,
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.fromLTRB(20, 12, 20, 20),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  Container(
                    width: 7,
                    height: 7,
                    margin: const EdgeInsets.only(right: 6),
                    decoration: const BoxDecoration(color: AppColors.alarm500, shape: BoxShape.circle),
                  ),
                  Text(
                    'LIVE EMERGENCY CALL',
                    style: AppTextStyles.body4Medium.copyWith(color: AppColors.alarm400, letterSpacing: 0.4),
                  ),
                  const Spacer(),
                  Container(
                    padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
                    decoration: BoxDecoration(
                      color: AppColors.alarm900,
                      borderRadius: BorderRadius.circular(20),
                    ),
                    child: Text('02:23', style: AppTextStyles.caption1SemiBold.copyWith(color: AppColors.alarm200)),
                  ),
                ],
              ),
              const SizedBox(height: 4),
              Text('Emergency Group', style: AppTextStyles.h6Bold.copyWith(color: Colors.white)),
              const SizedBox(height: 16),
              _SenderTile(alert: alert),
              const SizedBox(height: 16),
              Row(
                children: [
                  Expanded(child: _ParticipantTile(participant: participants[0])),
                  const SizedBox(width: 12),
                  Expanded(child: _ParticipantTile(participant: participants[1])),
                ],
              ),
              const SizedBox(height: 12),
              _ParticipantTile(participant: participants[2], fullWidth: true),
              const Spacer(),
              Text(
                'QUICK RESPONSE',
                style: AppTextStyles.caption1SemiBold.copyWith(color: AppColors.neutral500, letterSpacing: 0.5),
              ),
              const SizedBox(height: 10),
              Row(
                children: const [
                  Expanded(child: _QuickResponseChip(label: 'Need Help')),
                  SizedBox(width: 8),
                  Expanded(child: _QuickResponseChip(label: 'Send Location')),
                  SizedBox(width: 8),
                  Expanded(child: _QuickResponseChip(label: "I'm Safe")),
                ],
              ),
              const SizedBox(height: 20),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  _CallControlButton(
                    icon: Icons.mic_none_rounded,
                    background: AppColors.brand800,
                    iconColor: Colors.white,
                    onTap: () {},
                  ),
                  const SizedBox(width: 22),
                  _CallControlButton(
                    icon: Icons.call_end_rounded,
                    background: AppColors.alarm500,
                    iconColor: Colors.white,
                    size: 64,
                    onTap: () => Navigator.of(context).maybePop(),
                  ),
                  const SizedBox(width: 22),
                  _CallControlButton(
                    icon: Icons.videocam_rounded,
                    background: AppColors.brand800,
                    iconColor: Colors.white,
                    onTap: () {},
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class _SenderTile extends StatelessWidget {
  const _SenderTile({required this.alert});
  final EmergencyAlertModel alert;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      height: 160,
      padding: const EdgeInsets.all(14),
      decoration: BoxDecoration(
        gradient: LinearGradient(
          colors: [AppColors.brand700, AppColors.brand500],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
        borderRadius: BorderRadius.circular(20),
      ),
      child: Stack(
        children: [
          Align(
            alignment: Alignment.topLeft,
            child: Text(
              'You (${alert.personName.split(' ').first}) — Sender',
              style: AppTextStyles.body4Medium.copyWith(color: Colors.white.withValues(alpha: 0.9)),
            ),
          ),
          Align(
            alignment: Alignment.topRight,
            child: Container(
              padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
              decoration: BoxDecoration(color: AppColors.alarm500, borderRadius: BorderRadius.circular(20)),
              child: Text('SOS', style: AppTextStyles.caption1SemiBold.copyWith(color: Colors.white)),
            ),
          ),
          Center(
            child: Container(
              width: 56,
              height: 56,
              decoration: BoxDecoration(
                color: Colors.white.withValues(alpha: 0.18),
                shape: BoxShape.circle,
              ),
              alignment: Alignment.center,
              child: Text(alert.personInitials, style: AppTextStyles.h6Bold.copyWith(color: Colors.white)),
            ),
          ),
        ],
      ),
    );
  }
}

class _ParticipantTile extends StatelessWidget {
  const _ParticipantTile({required this.participant, this.fullWidth = false});

  final CallParticipant participant;
  final bool fullWidth;

  @override
  Widget build(BuildContext context) {
    final isCalling = participant.status == CallParticipantStatus.calling;
    return Container(
      width: fullWidth ? double.infinity : null,
      padding: const EdgeInsets.symmetric(vertical: 20),
      decoration: BoxDecoration(
        color: AppColors.brand900.withValues(alpha: 0.6),
        borderRadius: BorderRadius.circular(18),
        border: Border.all(color: AppColors.brand700.withValues(alpha: 0.6)),
      ),
      child: isCalling
          ? Column(
              children: [
                Text('Calling...', style: AppTextStyles.body4Regular.copyWith(color: AppColors.neutral400)),
                const SizedBox(height: 6),
                Text(participant.name, style: AppTextStyles.body2Bold.copyWith(color: Colors.white)),
              ],
            )
          : Column(
              children: [
                Container(
                  width: 44,
                  height: 44,
                  decoration: BoxDecoration(
                    color: AppColors.brand600,
                    shape: BoxShape.circle,
                  ),
                  alignment: Alignment.center,
                  child: Text(participant.initials, style: AppTextStyles.body3Bold.copyWith(color: Colors.white)),
                ),
                const SizedBox(height: 8),
                Text(participant.name, style: AppTextStyles.body3Medium.copyWith(color: Colors.white)),
                const SizedBox(height: 4),
                Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Container(
                      width: 6,
                      height: 6,
                      margin: const EdgeInsets.only(right: 4),
                      decoration: const BoxDecoration(color: AppColors.success500, shape: BoxShape.circle),
                    ),
                    Text('Joined', style: AppTextStyles.caption1Medium.copyWith(color: AppColors.success400)),
                  ],
                ),
              ],
            ),
    );
  }
}

class _QuickResponseChip extends StatelessWidget {
  const _QuickResponseChip({required this.label});
  final String label;

  @override
  Widget build(BuildContext context) {
    return OutlinedButton(
      onPressed: () {},
      style: OutlinedButton.styleFrom(
        foregroundColor: Colors.white,
        side: BorderSide(color: AppColors.brand700),
        padding: const EdgeInsets.symmetric(vertical: 12),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(14)),
      ),
      child: Text(label, style: AppTextStyles.body4Medium, textAlign: TextAlign.center),
    );
  }
}

class _CallControlButton extends StatelessWidget {
  const _CallControlButton({
    required this.icon,
    required this.background,
    required this.iconColor,
    required this.onTap,
    this.size = 54,
  });

  final IconData icon;
  final Color background;
  final Color iconColor;
  final VoidCallback onTap;
  final double size;

  @override
  Widget build(BuildContext context) {
    return Material(
      color: background,
      shape: const CircleBorder(),
      child: InkWell(
        customBorder: const CircleBorder(),
        onTap: onTap,
        child: SizedBox(
          width: size,
          height: size,
          child: Icon(icon, color: iconColor, size: size * 0.42),
        ),
      ),
    );
  }
}
