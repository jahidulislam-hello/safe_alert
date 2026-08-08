import 'package:safe_alert/core/utils/app_colors.dart';
import 'package:safe_alert/core/utils/app_styles.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';



enum AppHeaderLeading { back, close }

/// Top bar used on Verify, Secure Account, Create Account, and Log in:
/// a leading back-chevron or X, then a title, both tappable to dismiss.
class AppHeader extends StatelessWidget implements PreferredSizeWidget {
  final String title;
  final AppHeaderLeading leading;
  final VoidCallback onLeadingTap;

  const AppHeader({
    super.key,
    required this.title,
    required this.onLeadingTap,
    this.leading = AppHeaderLeading.back,
  });

  @override
  Widget build(BuildContext context) {
    final isBack = leading == AppHeaderLeading.back;
    return Padding(
      padding: EdgeInsets.fromLTRB(isBack ? 8.w : 20.w, 12.h, 12.w, 8.h),
      child: Row(
        mainAxisAlignment:
            isBack ? MainAxisAlignment.start : MainAxisAlignment.spaceBetween,
        children: isBack
            ? [
                IconButton(
                  onPressed: onLeadingTap,
                  icon: const Icon(Icons.chevron_left, color: AppColors.brand950),
                  splashRadius: 20.r,
                ),
                Text(
                  title,
                  style: AppTextStyles.body2Medium.copyWith(color: AppColors.brand950),
                ),
              ]
            : [
                Text(title, style: AppTextStyles.h6Bold),
                IconButton(
                  onPressed: onLeadingTap,
                  icon: const Icon(Icons.close, color: AppColors.neutral700),
                  splashRadius: 20.r,
                ),
              ],
      ),
    );
  }

  @override
  Size get preferredSize => Size.fromHeight(56.h);
}
