import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class FaceIdScanButton extends StatelessWidget {
  final VoidCallback onTap;
  final double size;

  const FaceIdScanButton({
    super.key,
    required this.onTap,
    this.size = 48,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: SizedBox(
        width: size.w,
        height: size.w,
        child: Image.asset(
          'assets/icons/scan.png',
          width: size.w,
          height: size.w,
          fit: BoxFit.contain,
        ),
      ),
    );
  }
}