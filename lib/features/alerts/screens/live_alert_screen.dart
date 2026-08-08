import '/core/utils/app_colors.dart';
import '/core/utils/app_styles.dart';
import 'package:flutter/material.dart';
import '../controllers/live_alert_controller.dart';
import '../models/emergency_models.dart';
import 'emergency_group_call_screen.dart';

/// Full-screen live alert detail: profile, live map, and the
/// I'm Responding / Can't Help decision.
class LiveAlertScreen extends StatefulWidget {
  const LiveAlertScreen({super.key, required this.alert});

  final EmergencyAlertModel alert;

  @override
  State<LiveAlertScreen> createState() => _LiveAlertScreenState();
}

class _LiveAlertScreenState extends State<LiveAlertScreen> {
  late final LiveAlertController controller = LiveAlertController(alert: widget.alert);

  @override
  void initState() {
    super.initState();
    controller.addListener(_onChange);
  }

  @override
  void dispose() {
    controller.removeListener(_onChange);
    super.dispose();
  }

  void _onChange() => setState(() {});

  void _openGroupCall() {
    Navigator.of(context).push(
      MaterialPageRoute(builder: (_) => EmergencyGroupCallScreen(alert: widget.alert)),
    );
  }

  @override
  Widget build(BuildContext context) {
    final alert = widget.alert;

    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.fromLTRB(20, 8, 20, 20),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  IconButton(
                    onPressed: () => Navigator.of(context).maybePop(),
                    icon: Icon(Icons.arrow_back, color: AppColors.brand900),
                  ),
                  const Spacer(),
                  Row(
                    children: [
                      Container(
                        width: 7,
                        height: 7,
                        margin: const EdgeInsets.only(right: 6),
                        decoration: const BoxDecoration(color: AppColors.alarm500, shape: BoxShape.circle),
                      ),
                      Text(
                        'LIVE ALERT',
                        style: AppTextStyles.body4Medium.copyWith(color: AppColors.alarm600, letterSpacing: 0.4),
                      ),
                    ],
                  ),
                  const Spacer(),
                  Text(
                    controller.elapsed,
                    style: AppTextStyles.body3Bold.copyWith(color: AppColors.alarm600),
                  ),
                ],
              ),
              const SizedBox(height: 18),
              Row(
                children: [
                  Container(
                    width: 44,
                    height: 44,
                    decoration: BoxDecoration(color: AppColors.brand50, borderRadius: BorderRadius.circular(14)),
                    alignment: Alignment.center,
                    child: Text(
                      alert.personInitials,
                      style: AppTextStyles.body3Bold.copyWith(color: AppColors.brand600),
                    ),
                  ),
                  const SizedBox(width: 12),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(alert.personName, style: AppTextStyles.body2Bold.copyWith(color: AppColors.brand900)),
                        const SizedBox(height: 2),
                        Text(
                          'Your group: ${alert.groupRelation ?? ''}',
                          style: AppTextStyles.body4Regular.copyWith(color: AppColors.neutral500),
                        ),
                        const SizedBox(height: 6),
                        Row(
                          children: [
                            _Tag(alert.alertType),
                            const SizedBox(width: 8),
                            if (alert.modeLabel != null) _Tag(alert.modeLabel!),
                          ],
                        ),
                      ],
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 20),
              Expanded(child: _LiveMap(location: alert.location)),
              const SizedBox(height: 18),
              Row(
                children: [
                  Expanded(
                    child: _ActionButton(
                      icon: Icons.videocam_rounded,
                      label: 'Join Call',
                      background: AppColors.brand100,
                      foreground: AppColors.brand700,
                      onTap: _openGroupCall,
                    ),
                  ),
                  const SizedBox(width: 12),
                  Expanded(
                    child: _ActionButton(
                      icon: Icons.chat_bubble_outline_rounded,
                      label: 'Message',
                      background: AppColors.success50,
                      foreground: AppColors.success700,
                      onTap: () {},
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 18),
              if (controller.isResponding)
                _RespondingBanner()
              else ...[
                SizedBox(
                  width: double.infinity,
                  child: ElevatedButton.icon(
                    onPressed: controller.respond,
                    icon: const Icon(Icons.check_circle_outline_rounded, size: 20),
                    label: Text("I'm Responding", style: AppTextStyles.body2Bold),
                    style: ElevatedButton.styleFrom(
                      backgroundColor: AppColors.success500,
                      foregroundColor: Colors.white,
                      elevation: 0,
                      padding: const EdgeInsets.symmetric(vertical: 16),
                      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
                    ),
                  ),
                ),
                const SizedBox(height: 10),
                SizedBox(
                  width: double.infinity,
                  child: TextButton(
                    onPressed: () {
                      controller.cantHelp();
                      Navigator.of(context).maybePop();
                    },
                    style: TextButton.styleFrom(
                      padding: const EdgeInsets.symmetric(vertical: 14),
                    ),
                    child: Text("Can't Help", style: AppTextStyles.body2Medium.copyWith(color: AppColors.neutral400)),
                  ),
                ),
              ],
            ],
          ),
        ),
      ),
    );
  }
}

class _Tag extends StatelessWidget {
  const _Tag(this.label);
  final String label;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
      decoration: BoxDecoration(color: AppColors.alarm50, borderRadius: BorderRadius.circular(20)),
      child: Text(label, style: AppTextStyles.caption1SemiBold.copyWith(color: AppColors.alarm600)),
    );
  }
}

class _ActionButton extends StatelessWidget {
  const _ActionButton({
    required this.icon,
    required this.label,
    required this.background,
    required this.foreground,
    required this.onTap,
  });

  final IconData icon;
  final String label;
  final Color background;
  final Color foreground;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return ElevatedButton.icon(
      onPressed: onTap,
      icon: Icon(icon, size: 18, color: foreground),
      label: Text(label, style: AppTextStyles.body3Bold.copyWith(color: foreground)),
      style: ElevatedButton.styleFrom(
        backgroundColor: background,
        elevation: 0,
        padding: const EdgeInsets.symmetric(vertical: 14),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(14)),
      ),
    );
  }
}

class _RespondingBanner extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: AppColors.success50,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: AppColors.success100),
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Icon(Icons.check_circle_rounded, color: AppColors.success600, size: 22),
          const SizedBox(width: 10),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text("You're responding", style: AppTextStyles.body2Bold.copyWith(color: AppColors.success800)),
                const SizedBox(height: 2),
                Text(
                  "Sarah has been notified you're on the way",
                  style: AppTextStyles.body4Regular.copyWith(color: AppColors.success700),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

/// Stylized stand-in for a live map: dark navy background, faint grid, and
/// a pulsing SOS pin at the reported location. Swap for a real map SDK
/// widget (google_maps_flutter, mapbox_gl, etc.) wired to [location].
class _LiveMap extends StatelessWidget {
  const _LiveMap({required this.location});

  final String location;

  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      borderRadius: BorderRadius.circular(20),
      child: Container(
        color: AppColors.brand950,
        child: Stack(
          children: [
            CustomPaint(size: Size.infinite, painter: _GridPainter()),
            Center(
              child: Container(
                width: 40,
                height: 40,
                decoration: BoxDecoration(
                  color: AppColors.alarm500,
                  shape: BoxShape.circle,
                  border: Border.all(color: AppColors.alarm500.withValues(alpha: 0.35), width: 8),
                ),
                alignment: Alignment.center,
                child: Text('SOS', style: AppTextStyles.caption1SemiBold.copyWith(color: Colors.white)),
              ),
            ),
            Positioned(
              left: 12,
              right: 12,
              bottom: 12,
              child: Container(
                padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 12),
                decoration: BoxDecoration(
                  color: Colors.black.withValues(alpha: 0.55),
                  borderRadius: BorderRadius.circular(14),
                ),
                child: Row(
                  children: [
                    Icon(Icons.location_on, color: AppColors.brand200, size: 16),
                    const SizedBox(width: 6),
                    Expanded(
                      child: Text(
                        location,
                        style: AppTextStyles.body4Medium.copyWith(color: Colors.white),
                      ),
                    ),
                    Container(
                      width: 6,
                      height: 6,
                      decoration: const BoxDecoration(color: AppColors.success500, shape: BoxShape.circle),
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
}

class _GridPainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()
      ..color = Colors.white.withValues(alpha: 0.06)
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
