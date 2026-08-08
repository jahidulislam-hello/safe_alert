import 'package:safe_alert/core/utils/app_colors.dart';
import 'package:safe_alert/core/utils/app_styles.dart';
import 'package:flutter/material.dart';


/// Small logo mark used at the top of most screens (shield + pin).
/// Swap this out for your real asset via `Image.asset(...)` when ready.
class AppLogoMark extends StatelessWidget {
  final double size;
  const AppLogoMark({super.key, this.size = 48});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: size,
      height: size,
      child: Stack(
        alignment: Alignment.center,
        children: [
          Icon(Icons.shield_outlined, size: size, color: AppColors.neutral300),
          Icon(Icons.location_on, size: size * 0.5, color: AppColors.alarm500),
        ],
      ),
    );
  }
}

/// Pill-shaped status badge, e.g. "Safe — No active alerts" or "Free".
class StatusBadge extends StatelessWidget {
  final String label;
  final Color background;
  final Color foreground;
  final IconData? leadingDot;

  const StatusBadge({
    super.key,
    required this.label,
    required this.background,
    required this.foreground,
    this.leadingDot,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
      decoration: BoxDecoration(
        color: background,
        borderRadius: BorderRadius.circular(24),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          if (leadingDot != null) ...[
            Icon(leadingDot, size: 8, color: foreground),
            const SizedBox(width: 8),
          ],
          Text(label, style: AppTextStyles.body3Medium.copyWith(color: foreground)),
        ],
      ),
    );
  }
}

/// Full-width filled pill button used for primary/emergency actions.
class AppFilledButton extends StatelessWidget {
  final String label;
  final Color background;
  final Color foreground;
  final IconData? icon;
  final VoidCallback? onPressed;
  final double height;

  const AppFilledButton({
    super.key,
    required this.label,
    required this.background,
    this.foreground = Colors.white,
    this.icon,
    this.onPressed,
    this.height = 56,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: double.infinity,
      height: height,
      child: ElevatedButton(
        onPressed: onPressed,
        style: ElevatedButton.styleFrom(
          backgroundColor: background,
          disabledBackgroundColor: background.withOpacity(0.6),
          foregroundColor: foreground,
          elevation: 0,
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(28)),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            if (icon != null) ...[
              Icon(icon, size: 18, color: foreground),
              const SizedBox(width: 8),
            ],
            Text(label, style: AppTextStyles.body2Bold.copyWith(color: foreground)),
          ],
        ),
      ),
    );
  }
}

/// Full-width outlined pill button.
class AppOutlinedButton extends StatelessWidget {
  final String label;
  final Color borderColor;
  final Color foreground;
  final VoidCallback? onPressed;
  final double height;

  const AppOutlinedButton({
    super.key,
    required this.label,
    required this.borderColor,
    required this.foreground,
    this.onPressed,
    this.height = 56,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: double.infinity,
      height: height,
      child: OutlinedButton(
        onPressed: onPressed,
        style: OutlinedButton.styleFrom(
          foregroundColor: foreground,
          side: BorderSide(color: borderColor, width: 1.5),
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(28)),
        ),
        child: Text(label, style: AppTextStyles.body2Bold.copyWith(color: foreground)),
      ),
    );
  }
}

/// Circular avatar with initials, used for contacts.
class InitialsAvatar extends StatelessWidget {
  final String initials;
  final Color background;
  final Color foreground;
  final double radius;
  final bool online;

  const InitialsAvatar({
    super.key,
    required this.initials,
    required this.background,
    this.foreground = Colors.white,
    this.radius = 20,
    this.online = false,
  });

  @override
  Widget build(BuildContext context) {
    return Stack(
      clipBehavior: Clip.none,
      children: [
        CircleAvatar(
          radius: radius,
          backgroundColor: background,
          child: Text(
            initials,
            style: AppTextStyles.body3Bold.copyWith(color: foreground),
          ),
        ),
        if (online)
          Positioned(
            right: -1,
            bottom: -1,
            child: Container(
              width: 10,
              height: 10,
              decoration: BoxDecoration(
                color: AppColors.success500,
                shape: BoxShape.circle,
                border: Border.all(color: Colors.white, width: 2),
              ),
            ),
          ),
      ],
    );
  }
}

/// Top app bar with an optional back button and centered title, matching
/// the "< Screen Title" pattern used across the flow.
class AppTopBar extends StatelessWidget implements PreferredSizeWidget {
  final String? title;
  final VoidCallback? onBack;

  const AppTopBar({super.key, this.title, this.onBack});

  @override
  Widget build(BuildContext context) {
    return AppBar(
      backgroundColor: Colors.white,
      elevation: 0,
      centerTitle: false,
      leading: onBack != null
          ? IconButton(
              icon: const Icon(Icons.chevron_left, color: AppColors.neutral900),
              onPressed: onBack,
            )
          : null,
      title: title != null
          ? Text(title!, style: AppTextStyles.body2Medium.copyWith(color: AppColors.neutral900))
          : null,
    );
  }

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);
}

/// A light, rounded info/warning banner (used for the silent-mode caution).
class InlineBanner extends StatelessWidget {
  final String text;
  final Color background;
  final Color foreground;
  final IconData icon;

  const InlineBanner({
    super.key,
    required this.text,
    required this.background,
    required this.foreground,
    this.icon = Icons.warning_amber_rounded,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: background,
        borderRadius: BorderRadius.circular(12),
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Icon(icon, size: 18, color: foreground),
          const SizedBox(width: 8),
          Expanded(
            child: Text(text, style: AppTextStyles.body4Regular.copyWith(color: foreground)),
          ),
        ],
      ),
    );
  }
}
