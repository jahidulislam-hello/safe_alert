import 'dart:math' as math;
import 'package:safe_alert/features/auth/login_screen.dart';

import '/core/utils/app_colors.dart';
import '/core/utils/app_styles.dart';
import 'package:flutter/material.dart';
import 'create_account_screen.dart';

/// First screen: blue landing screen with the shield emblem and the
/// Create Account / Log in / Join as a group member actions.
class WelcomeScreen extends StatelessWidget {
  const WelcomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.brand500,
      body: SafeArea(
        child: Column(
          children: [
            // Emblem
            const Expanded(
              child: Center(
                child: SizedBox(
                  width: 230,
                  height: 230,
                  child: ProtectionEmblem(),
                ),
              ),
            ),

            // Bottom actions
            Padding(
              padding: const EdgeInsets.fromLTRB(24, 0, 24, 28),
              child: Column(
                children: [
                  // Create Account — filled light pill button
                  SizedBox(
                    width: double.infinity,
                    height: 52,
                    child: ElevatedButton(
                      onPressed: () {
                        Navigator.of(context).push(
                          MaterialPageRoute(
                            builder: (_) => const CreateAccountScreen(),
                          ),
                        );
                      },
                      style: ElevatedButton.styleFrom(
                        backgroundColor: AppColors.brand50,
                        foregroundColor: AppColors.brand800,
                        elevation: 0,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(28),
                        ),
                      ),
                      child: Text(
                        'Create Account',
                        style: AppTextStyles.body1Medium
                            .copyWith(color: AppColors.brand800),
                      ),
                    ),
                  ),
                  const SizedBox(height: 12),

                  // Log in — outlined pill button
                  SizedBox(
                    width: double.infinity,
                    height: 52,
                    child: OutlinedButton(
                      onPressed: () {
                        Navigator.of(context).push(
                          MaterialPageRoute(
                            builder: (_) => const LoginScreen(),
                          ),
                        );
                      },
                      style: OutlinedButton.styleFrom(
                        foregroundColor: Colors.white,
                        side:
                        const BorderSide(color: Colors.white, width: 1.4),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(28),
                        ),
                      ),
                      child: Text(
                        'Log in',
                        style: AppTextStyles.body1Medium
                            .copyWith(color: Colors.white),
                      ),
                    ),
                  ),
                  const SizedBox(height: 18),

                  // // Join as a group member — text link
                  // GestureDetector(
                  //   onTap: () {},
                  //   child: Text(
                  //     'Join as a group member',
                  //     style: AppTextStyles.body3Medium.copyWith(
                  //       color: Colors.white,
                  //       decoration: TextDecoration.underline,
                  //       decorationColor: Colors.white,
                  //     ),
                  //   ),
                  // ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

/// The circular shield / wings / people / alarm emblem shown on the
/// welcome screen. Built from vector primitives — no image asset needed.
class ProtectionEmblem extends StatelessWidget {
  const ProtectionEmblem({super.key});

  @override
  Widget build(BuildContext context) {
    return Stack(
      alignment: Alignment.center,
      clipBehavior: Clip.none,
      children: const [
        _PeopleRing(),
        Padding(
          padding: EdgeInsets.only(bottom: 10),
          child: _ShieldWithWings(),
        ),
        Positioned(bottom: 4, child: _SirenIcon()),
      ],
    );
  }
}

class _PeopleRing extends StatelessWidget {
  const _PeopleRing();

  static const int nodeCount = 5;
  static const double ringSize = 230;
  static const double nodeRadius = 96;
  static const double nodeSize = 30;

  @override
  Widget build(BuildContext context) {
    final nodeCenters = List.generate(nodeCount, (i) {
      final angle = (-90 + i * (360 / nodeCount)) * math.pi / 180;
      return Offset(
        ringSize / 2 + nodeRadius * math.cos(angle),
        ringSize / 2 + nodeRadius * math.sin(angle),
      );
    });

    return SizedBox(
      width: ringSize,
      height: ringSize,
      child: Stack(
        children: [
          CustomPaint(
            size: const Size(ringSize, ringSize),
            painter: _RingLinesPainter(
              nodeCenters: nodeCenters,
              color: Colors.white.withOpacity(0.85),
            ),
          ),
          for (final c in nodeCenters)
            Positioned(
              left: c.dx - nodeSize / 2,
              top: c.dy - nodeSize / 2,
              child: Container(
                width: nodeSize,
                height: nodeSize,
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  color: AppColors.brand500,
                  border: Border.all(
                      color: Colors.white.withOpacity(0.9), width: 1.6),
                ),
                child:
                const Icon(Icons.person, color: Colors.white, size: 16),
              ),
            ),
        ],
      ),
    );
  }
}

class _RingLinesPainter extends CustomPainter {
  final List<Offset> nodeCenters;
  final Color color;
  const _RingLinesPainter({required this.nodeCenters, required this.color});

  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()
      ..color = color
      ..strokeWidth = 1.2
      ..style = PaintingStyle.stroke;
    final center = Offset(size.width / 2, size.height / 2);

    // Spokes from center to each node.
    for (final p in nodeCenters) {
      canvas.drawLine(center, p, paint);
    }
    // Ring connecting the nodes.
    final path = Path()..addPolygon(nodeCenters, true);
    canvas.drawPath(path, paint);
  }

  @override
  bool shouldRepaint(covariant _RingLinesPainter oldDelegate) => false;
}

class _ShieldWithWings extends StatelessWidget {
  const _ShieldWithWings();

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 190,
      height: 130,
      child: Stack(
        alignment: Alignment.center,
        children: [
          // Wings
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Icon(Icons.flight,
                  size: 60, color: Colors.white.withOpacity(0.95)),
              Transform.flip(
                flipX: true,
                child: Icon(Icons.flight,
                    size: 60, color: Colors.white.withOpacity(0.95)),
              ),
            ],
          ),
          // Shield
          Container(
            width: 86,
            height: 98,
            clipBehavior: Clip.antiAlias,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(16),
              boxShadow: const [
                BoxShadow(
                    color: Colors.black26,
                    blurRadius: 6,
                    offset: Offset(0, 3)),
              ],
            ),
            child: ClipPath(
              clipper: _ShieldClipper(),
              child: Container(
                decoration: const BoxDecoration(
                  gradient: LinearGradient(
                    colors: [Color(0xFFF2F2F2), Color(0xFFAEB3BB)],
                    begin: Alignment.topLeft,
                    end: Alignment.bottomRight,
                  ),
                ),
                alignment: Alignment.center,
                child: const Icon(Icons.location_on,
                    color: Color(0xFFE41313), size: 42),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class _ShieldClipper extends CustomClipper<Path> {
  @override
  Path getClip(Size size) {
    final w = size.width, h = size.height;
    return Path()
      ..moveTo(w * 0.5, 0)
      ..lineTo(w, h * 0.18)
      ..lineTo(w, h * 0.55)
      ..cubicTo(w, h * 0.85, w * 0.75, h, w * 0.5, h)
      ..cubicTo(w * 0.25, h, 0, h * 0.85, 0, h * 0.55)
      ..lineTo(0, h * 0.18)
      ..close();
  }

  @override
  bool shouldReclip(covariant CustomClipper<Path> oldClipper) => false;
}

class _SirenIcon extends StatelessWidget {
  const _SirenIcon();

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        Container(
          width: 16,
          height: 16,
          decoration: const BoxDecoration(
            shape: BoxShape.circle,
            color: Color(0xFFE41313),
          ),
        ),
        Container(
          margin: const EdgeInsets.only(top: 2),
          width: 38,
          height: 16,
          decoration: const BoxDecoration(
            color: Color(0xFFE41313),
            borderRadius: BorderRadius.vertical(top: Radius.circular(10)),
          ),
        ),
        Container(
          width: 46,
          height: 7,
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(2),
          ),
        ),
      ],
    );
  }
}