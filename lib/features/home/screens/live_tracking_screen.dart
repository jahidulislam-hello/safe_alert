import 'dart:async';
import 'package:safe_alert/core/utils/app_colors.dart';
import 'package:safe_alert/core/utils/app_styles.dart';
import 'package:flutter/material.dart';

import '../widgets/common_widgets.dart';
import 'alert_mode_screen.dart';
import 'cancel_alert_screen.dart';

/// Live tracking screen: map placeholder with an SOS pin, meta row
/// (type / mode / duration), and a list of responding contacts.
class LiveTrackingScreen extends StatefulWidget {
  final EmergencyAlertMode mode;
  final String emergencyType;

  const LiveTrackingScreen({super.key, required this.mode, required this.emergencyType});

  @override
  State<LiveTrackingScreen> createState() => _LiveTrackingScreenState();
}

class _LiveTrackingScreenState extends State<LiveTrackingScreen> {
  int _elapsedSeconds = 2 * 60 + 33;
  Timer? _timer;

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

  bool get _isSilent => widget.mode == EmergencyAlertMode.silent;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: Column(
          children: [
            // Map placeholder
            Expanded(
              flex: 5,
              child: Container(
                width: double.infinity,
                color: AppColors.brand950,
                child: Stack(
                  alignment: Alignment.center,
                  children: [
                    CustomPaint(size: Size.infinite, painter: _GridPainter()),
                    Column(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Container(
                          padding: const EdgeInsets.all(10),
                          decoration: const BoxDecoration(color: AppColors.alarm500, shape: BoxShape.circle),
                          child: const Text('SOS',
                              style: TextStyle(
                                color: Colors.white,
                                fontWeight: FontWeight.bold,
                                fontSize: 12,
                              )),
                        ),
                      ],
                    ),
                    Positioned(
                      left: 12,
                      bottom: 12,
                      right: 12,
                      child: Container(
                        padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 10),
                        decoration: BoxDecoration(
                          color: Colors.black.withOpacity(0.45),
                          borderRadius: BorderRadius.circular(12),
                        ),
                        child: Row(
                          children: [
                            const Icon(Icons.location_on, color: Colors.white70, size: 16),
                            const SizedBox(width: 6),
                            Expanded(
                              child: Text('123 Main St, New York, NY',
                                  style: AppTextStyles.body4Medium.copyWith(color: Colors.white)),
                            ),
                            Container(
                              width: 8,
                              height: 8,
                              decoration: const BoxDecoration(color: AppColors.success500, shape: BoxShape.circle),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
            Expanded(
              flex: 4,
              child: Padding(
                padding: const EdgeInsets.fromLTRB(20, 16, 20, 20),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        Expanded(
                          child: _metaColumn('Emergency Type', widget.emergencyType, AppColors.neutral900),
                        ),
                        Expanded(
                          child: _metaColumn(
                            'Mode',
                            _isSilent ? 'Silent' : 'Emergency',
                            _isSilent ? AppColors.brand600 : AppColors.alarm600,
                          ),
                        ),
                        Expanded(
                          child: _metaColumn('Emergency Type', _formattedTime, AppColors.alarm600),
                        ),
                      ],
                    ),
                    const SizedBox(height: 16),
                    Text('RESPONDING CONTACTS',
                        style: AppTextStyles.caption1SemiBold.copyWith(
                          color: AppColors.neutral500,
                          letterSpacing: 0.5,
                        )),
                    const SizedBox(height: 10),
                    Expanded(
                      child: ListView(
                        children: [
                          _contactRow(name: 'James Johnson', relation: 'Father', initials: 'JJ', color: AppColors.brand400),
                          const Divider(height: 20, color: AppColors.neutral100),
                          _contactRow(name: 'Emma Smith', relation: 'Sister', initials: 'ES', color: AppColors.warning300),
                        ],
                      ),
                    ),
                    Row(
                      children: [
                        Expanded(
                          child: AppOutlinedButton(
                            label: 'Call',
                            borderColor: AppColors.brand600,
                            foreground: AppColors.brand600,
                            height: 48,
                            onPressed: () {},
                          ),
                        ),
                        const SizedBox(width: 12),
                        Expanded(
                          child: AppOutlinedButton(
                            label: 'End Alert',
                            borderColor: AppColors.alarm500,
                            foreground: AppColors.alarm500,
                            height: 48,
                            onPressed: () => Navigator.of(context).push(
                              MaterialPageRoute(builder: (_) => const CancelAlertScreen()),
                            ),
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 12),
                    TextButton.icon(
                      onPressed: () {},
                      icon: const Icon(Icons.sms_outlined, color: AppColors.brand600, size: 18),
                      label: Text('Message',
                          style: AppTextStyles.body3Medium.copyWith(color: AppColors.brand600)),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _metaColumn(String label, String value, Color valueColor) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(label, style: AppTextStyles.caption1Medium.copyWith(color: AppColors.neutral400)),
        const SizedBox(height: 2),
        Text(value, style: AppTextStyles.body3Bold.copyWith(color: valueColor)),
      ],
    );
  }

  Widget _contactRow({required String name, required String relation, required String initials, required Color color}) {
    return Row(
      children: [
        InitialsAvatar(initials: initials, background: color, radius: 20),
        const SizedBox(width: 12),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(name, style: AppTextStyles.body3Bold.copyWith(color: AppColors.neutral900)),
              Text(relation, style: AppTextStyles.body4Regular.copyWith(color: AppColors.neutral500)),
            ],
          ),
        ),
        Row(
          children: [
            Container(
              width: 6,
              height: 6,
              decoration: const BoxDecoration(color: AppColors.success500, shape: BoxShape.circle),
            ),
            const SizedBox(width: 6),
            Text('En route', style: AppTextStyles.body4Medium.copyWith(color: AppColors.success600)),
          ],
        ),
      ],
    );
  }
}

/// Simple map-grid background so the tracking screen doesn't need a real
/// maps SDK dependency to look believable.
class _GridPainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()
      ..color = Colors.white.withOpacity(0.06)
      ..strokeWidth = 1;
    const step = 32.0;
    for (double x = 0; x < size.width; x += step) {
      canvas.drawLine(Offset(x, 0), Offset(x, size.height), paint);
    }
    for (double y = 0; y < size.height; y += step) {
      canvas.drawLine(Offset(0, y), Offset(size.width, y), paint);
    }
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => false;
}
