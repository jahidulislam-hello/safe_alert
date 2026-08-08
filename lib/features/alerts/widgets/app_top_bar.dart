import '/core/utils/app_colors.dart';
import '/core/utils/app_styles.dart';
import 'package:flutter/material.dart';


/// "Good morning / Name" header with the crest mark centered and a
/// notification bell on the right, matching the top of every Home state.
class AppTopBar extends StatelessWidget {
  const AppTopBar({
    super.key,
    required this.userName,
    this.hasUnreadNotifications = false,
    this.onBellTap,
  });

  final String userName;
  final bool hasUnreadNotifications;
  final VoidCallback? onBellTap;

  @override
  Widget build(BuildContext context) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'Good morning',
                style: AppTextStyles.body3Regular.copyWith(
                  color: AppColors.neutral600,
                ),
              ),
              const SizedBox(height: 2),
              Text(
                userName,
                style: AppTextStyles.h6Bold.copyWith(
                  color: AppColors.brand900,
                ),
              ),
            ],
          ),
        ),
        _CrestMark(),
        const SizedBox(width: 12),
        _BellButton(
          hasUnread: hasUnreadNotifications,
          onTap: onBellTap,
        ),
      ],
    );
  }
}

class _CrestMark extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    // Placeholder for the shield/crest brand mark shown in the design —
    // swap for Image.asset('assets/crest.png') once you have the artwork.
    return Container(
      width: 44,
      height: 44,
      alignment: Alignment.center,
      child: Icon(Icons.shield_moon_outlined, size: 28, color: AppColors.neutral300),
    );
  }
}

class _BellButton extends StatelessWidget {
  const _BellButton({required this.hasUnread, this.onTap});

  final bool hasUnread;
  final VoidCallback? onTap;

  @override
  Widget build(BuildContext context) {
    return Material(
      color: AppColors.neutral50,
      shape: const CircleBorder(),
      child: InkWell(
        customBorder: const CircleBorder(),
        onTap: onTap,
        child: SizedBox(
          width: 44,
          height: 44,
          child: Stack(
            alignment: Alignment.center,
            children: [
              Icon(Icons.notifications_none_rounded, color: AppColors.brand900, size: 22),
              if (hasUnread)
                Positioned(
                  top: 11,
                  right: 11,
                  child: Container(
                    width: 8,
                    height: 8,
                    decoration: const BoxDecoration(
                      color: AppColors.alarm500,
                      shape: BoxShape.circle,
                    ),
                  ),
                ),
            ],
          ),
        ),
      ),
    );
  }
}
