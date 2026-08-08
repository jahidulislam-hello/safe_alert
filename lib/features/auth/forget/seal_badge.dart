import 'dart:math' as math;
import 'package:flutter/material.dart';

/// A scalloped "certificate seal" badge — a circle with a wavy/bumped
/// edge — used for the Pin Updated success state. Filled with [color]
/// and showing a centered checkmark.
class SealBadge extends StatelessWidget {
  final double size;
  final Color color;

  const SealBadge({super.key, this.size = 100, this.color = const Color(0xFF00A61E)});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: size,
      height: size,
      child: CustomPaint(
        painter: _SealPainter(color: color),
        child: Center(
          child: Icon(Icons.check, color: Colors.white, size: size * 0.42),
        ),
      ),
    );
  }
}

class _SealPainter extends CustomPainter {
  final Color color;
  const _SealPainter({required this.color});

  @override
  void paint(Canvas canvas, Size size) {
    final center = Offset(size.width / 2, size.height / 2);
    final baseRadius = size.width / 2 * 0.86;
    final bumpAmplitude = size.width / 2 * 0.14;
    const bumps = 16;

    final path = Path();
    for (int i = 0; i <= bumps * 8; i++) {
      final t = i / (bumps * 8) * 2 * math.pi;
      final r = baseRadius + bumpAmplitude * math.cos(bumps * t);
      final point = Offset(center.dx + r * math.cos(t), center.dy + r * math.sin(t));
      if (i == 0) {
        path.moveTo(point.dx, point.dy);
      } else {
        path.lineTo(point.dx, point.dy);
      }
    }
    path.close();

    canvas.drawPath(path, Paint()..color = color);
  }

  @override
  bool shouldRepaint(covariant _SealPainter oldDelegate) => oldDelegate.color != color;
}
