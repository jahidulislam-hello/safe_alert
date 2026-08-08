import 'dart:async';
import 'package:safe_alert/core/utils/app_colors.dart';
import 'package:safe_alert/core/utils/app_styles.dart';
import 'package:flutter/material.dart';
import '../widgets/common_widgets.dart';

/// Dark-themed live emergency group call screen: main sender tile,
/// joined-contact tiles, a calling tile, and quick-response actions.
class LiveCallScreen extends StatefulWidget {
  const LiveCallScreen({super.key});

  @override
  State<LiveCallScreen> createState() => _LiveCallScreenState();
}

class _LiveCallScreenState extends State<LiveCallScreen> {
  int _elapsedSeconds = 2 * 60 + 23;
  Timer? _timer;
  bool _muted = false;

  @override
  void initState() {
    super.initState();
    _timer = Timer.periodic(const Duration(seconds: 1), (_) {
      setState(() => _elapsedSeconds++);
    });
  }

  @override
  void dispose() {
    _timer?.cancel();
    super.dispose();
  }

  String get _formattedTime {
    final m = (_elapsedSeconds ~/ 60).toString().padLeft(2, '0');
    final s = (_elapsedSeconds % 60).toString().padLeft(2, '0');
    return '$m:$s';
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.neutral950,
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.fromLTRB(16, 12, 16, 20),
          child: Column(
            children: [
              Row(
                children: [
                  Container(
                    width: 8,
                    height: 8,
                    decoration: const BoxDecoration(color: AppColors.alarm500, shape: BoxShape.circle),
                  ),
                  const SizedBox(width: 6),
                  Text('LIVE EMERGENCY CALL',
                      style: AppTextStyles.caption1SemiBold.copyWith(
                        color: AppColors.alarm400,
                        letterSpacing: 0.5,
                      )),
                  const Spacer(),
                  Container(
                    padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
                    decoration: BoxDecoration(
                      color: AppColors.neutral800,
                      borderRadius: BorderRadius.circular(12),
                    ),
                    child: Text(_formattedTime,
                        style: AppTextStyles.body4Medium.copyWith(color: Colors.white)),
                  ),
                ],
              ),
              const SizedBox(height: 4),
              Align(
                alignment: Alignment.centerLeft,
                child: Text('Emergency Group',
                    style: AppTextStyles.body2Bold.copyWith(color: Colors.white)),
              ),
              const SizedBox(height: 16),
              // Main sender tile
              Expanded(
                flex: 5,
                child: Container(
                  width: double.infinity,
                  decoration: BoxDecoration(
                    color: AppColors.brand800,
                    borderRadius: BorderRadius.circular(20),
                  ),
                  child: Stack(
                    children: [
                      Center(
                        child: InitialsAvatar(
                          initials: 'SJ',
                          background: AppColors.brand500,
                          radius: 40,
                        ),
                      ),
                      Positioned(
                        left: 12,
                        bottom: 12,
                        child: Container(
                          padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
                          decoration: BoxDecoration(
                            color: Colors.black.withOpacity(0.35),
                            borderRadius: BorderRadius.circular(10),
                          ),
                          child: Text('You (Sarah) — Sender',
                              style: AppTextStyles.body4Medium.copyWith(color: Colors.white)),
                        ),
                      ),
                      Positioned(
                        right: 12,
                        top: 12,
                        child: Container(
                          padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                          decoration: BoxDecoration(
                            color: AppColors.alarm500,
                            borderRadius: BorderRadius.circular(10),
                          ),
                          child: Text('SOS',
                              style: AppTextStyles.caption1SemiBold.copyWith(color: Colors.white)),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              const SizedBox(height: 12),
              // Joined / calling tiles
              Expanded(
                flex: 3,
                child: Row(
                  children: [
                    Expanded(child: _participantTile(name: 'James', initials: 'JJ', color: AppColors.brand400, status: 'Joined')),
                    const SizedBox(width: 12),
                    Expanded(child: _participantTile(name: 'Emma', initials: 'ES', color: AppColors.warning300, status: 'Joined')),
                    const SizedBox(width: 12),
                    Expanded(child: _callingTile(name: 'Mike')),
                  ],
                ),
              ),
              const SizedBox(height: 20),
              Align(
                alignment: Alignment.centerLeft,
                child: Text('QUICK RESPONSE',
                    style: AppTextStyles.caption1SemiBold.copyWith(
                      color: AppColors.neutral400,
                      letterSpacing: 0.5,
                    )),
              ),
              const SizedBox(height: 10),
              Row(
                children: [
                  Expanded(child: _quickChip('Need Help')),
                  const SizedBox(width: 8),
                  Expanded(child: _quickChip('Send Location')),
                  const SizedBox(width: 8),
                  Expanded(child: _quickChip("I'm Safe")),
                ],
              ),
              const SizedBox(height: 20),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  _circleAction(
                    icon: _muted ? Icons.mic_off : Icons.mic,
                    background: AppColors.neutral800,
                    foreground: Colors.white,
                    onTap: () => setState(() => _muted = !_muted),
                  ),
                  _circleAction(
                    icon: Icons.call_end,
                    background: AppColors.alarm500,
                    foreground: Colors.white,
                    large: true,
                    onTap: () => Navigator.of(context).pop(),
                  ),
                  _circleAction(
                    icon: Icons.videocam,
                    background: AppColors.neutral800,
                    foreground: Colors.white,
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

  Widget _participantTile({required String name, required String initials, required Color color, required String status}) {
    return Container(
      decoration: BoxDecoration(
        color: AppColors.neutral900,
        borderRadius: BorderRadius.circular(16),
      ),
      padding: const EdgeInsets.symmetric(vertical: 12),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          InitialsAvatar(initials: initials, background: color, radius: 22),
          const SizedBox(height: 8),
          Text(name, style: AppTextStyles.body4Medium.copyWith(color: Colors.white)),
          const SizedBox(height: 4),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Container(width: 6, height: 6, decoration: const BoxDecoration(color: AppColors.success500, shape: BoxShape.circle)),
              const SizedBox(width: 4),
              Text(status, style: AppTextStyles.caption1Medium.copyWith(color: AppColors.neutral400)),
            ],
          ),
        ],
      ),
    );
  }

  Widget _callingTile({required String name}) {
    return Container(
      decoration: BoxDecoration(
        color: AppColors.neutral900,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: AppColors.neutral700, style: BorderStyle.solid),
      ),
      padding: const EdgeInsets.symmetric(vertical: 12),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          const SizedBox(
            width: 20,
            height: 20,
            child: CircularProgressIndicator(strokeWidth: 2, color: AppColors.neutral400),
          ),
          const SizedBox(height: 10),
          Text('Calling...', style: AppTextStyles.caption1Medium.copyWith(color: AppColors.neutral400)),
          const SizedBox(height: 4),
          Text(name, style: AppTextStyles.body4Medium.copyWith(color: Colors.white)),
        ],
      ),
    );
  }

  Widget _quickChip(String label) {
    return Container(
      padding: const EdgeInsets.symmetric(vertical: 10),
      decoration: BoxDecoration(
        color: AppColors.neutral900,
        borderRadius: BorderRadius.circular(20),
        border: Border.all(color: AppColors.neutral700),
      ),
      child: Text(
        label,
        textAlign: TextAlign.center,
        style: AppTextStyles.body4Medium.copyWith(color: Colors.white),
      ),
    );
  }

  Widget _circleAction({
    required IconData icon,
    required Color background,
    required Color foreground,
    required VoidCallback onTap,
    bool large = false,
  }) {
    final size = large ? 64.0 : 52.0;
    return GestureDetector(
      onTap: onTap,
      child: Container(
        width: size,
        height: size,
        decoration: BoxDecoration(color: background, shape: BoxShape.circle),
        child: Icon(icon, color: foreground, size: large ? 28 : 22),
      ),
    );
  }
}
