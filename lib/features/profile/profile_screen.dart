import 'package:safe_alert/core/utils/app_colors.dart';
import 'package:safe_alert/core/utils/app_styles.dart';
import 'package:safe_alert/features/profile/app_chevron_list_tile.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'edit_profile_screen.dart';

/// Profile tab — user card with avatar/edit, account menu, and Log out.
class ProfileScreen extends StatelessWidget {
  const ProfileScreen({super.key});

  // TODO: pull these from your AuthController / user model.
  static const _name = 'Mohammod Jakuan';
  static const _phone = '+880 189* ****';
  static const _avatarUrl =
      'https://images.unsplash.com/photo-1633332755192-727a05c4013d?w=200&q=80';

  void _onEdit() {
    Get.to(() => const EditProfileScreen());
  }

  void _onDeleteAccount() {
    Get.dialog(
      AlertDialog(
        title: Text('Delete Account', style: AppTextStyles.h6Bold),
        content: Text(
          'This will permanently delete your account and all data. This can\'t be undone.',
          style: AppTextStyles.body3Regular.copyWith(color: AppColors.neutral600),
        ),
        actions: [
          TextButton(
            onPressed: () => Get.back(),
            child: Text('Cancel', style: AppTextStyles.body3Medium.copyWith(color: AppColors.neutral600)),
          ),
          TextButton(
            onPressed: () {
              Get.back();
              // TODO: call your AuthController delete-account flow.
            },
            child: Text('Delete', style: AppTextStyles.body3Medium.copyWith(color: AppColors.alarm600)),
          ),
        ],
      ),
    );
  }

  void _onLogout() {
    // TODO: context.read<AuthController>().logout(); then Get.offAllNamed(AppRoutes.welcomeScreen);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: Column(
          children: [
            Padding(
              padding: EdgeInsets.fromLTRB(20.w, 12.h, 20.w, 4.h),
              child: Row(
                children: [
                  // Left — "Profile" title
                  Expanded(
                    child: Text(
                      'Profile',
                      style: AppTextStyles.h6Bold.copyWith(color: AppColors.brand950),
                    ),
                  ),
                  // Centre — logo (70×70)
                  Image.asset(
                    'assets/icons/profile_logo.png',
                    width: 70.w,
                    height: 70.w,
                    fit: BoxFit.contain,
                  ),
                  // Right — Delete Account button (Expanded keeps logo centred)
                  Expanded(
                    child: Align(
                      alignment: Alignment.centerRight,
                      child: TextButton(
                        onPressed: _onDeleteAccount,
                        style: TextButton.styleFrom(
                          backgroundColor: Colors.white,
                          fixedSize: Size(double.infinity, 24.h),
                          padding: EdgeInsets.symmetric(horizontal: 10.w),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(12.r),
                            side: const BorderSide(color: AppColors.neutral100),
                          ),
                        ),
                        child: Text(
                          'Delete Account',
                          style: AppTextStyles.body4Medium.copyWith(
                            color: AppColors.alarm600,
                          ),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
            Expanded(
              child: SingleChildScrollView(
                padding: EdgeInsets.symmetric(horizontal: 20.w),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    SizedBox(height: 8.h),
                    _ProfileCard(
                      name: _name,
                      phone: _phone,
                      avatarUrl: _avatarUrl,
                      onEdit: _onEdit,
                    ),
                    SizedBox(height: 20.h),
                    AppChevronListTile(title: 'My Subscriptions', onTap: () {}),

                    AppChevronListTile(title: 'About Us', onTap: () {}),

                    AppChevronListTile(title: 'Privacy Policy', onTap: () {}),

                    AppChevronListTile(title: 'Terms & Conditions', onTap: () {}),
                  ],
                ),
              ),
            ),
            Padding(
              padding: EdgeInsets.fromLTRB(20.w, 0, 20.w, 16.h),
              child: SizedBox(
                width: double.infinity,
                height: 52.h,
                child: OutlinedButton.icon(
                  onPressed: _onLogout,
                  icon: Icon(Icons.logout, size: 18.sp, color: AppColors.alarm600),
                  label: Text(
                    'Log out',
                    style: AppTextStyles.body1Medium.copyWith(color: AppColors.alarm600),
                  ),
                  style: OutlinedButton.styleFrom(
                    side: const BorderSide(color: AppColors.neutral200),
                    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(28.r)),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _ProfileCard extends StatelessWidget {
  final String name;
  final String phone;
  final String avatarUrl;
  final VoidCallback onEdit;

  const _ProfileCard({
    required this.name,
    required this.phone,
    required this.avatarUrl,
    required this.onEdit,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(16.w),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(8.r),
        border: Border.all(color: AppColors.neutral100),
      ),
      child: Row(
        children: [
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(name, style: AppTextStyles.body2Medium.copyWith(color: AppColors.neutral900)),
                SizedBox(height: 4.h),
                Text(phone, style: AppTextStyles.body4Regular.copyWith(color: AppColors.neutral500)),
                SizedBox(height: 10.h),
                InkWell(
                  onTap: onEdit,
                  borderRadius: BorderRadius.circular(12.r),
                  child: Container(
                    padding: EdgeInsets.symmetric(horizontal: 10.w),
                    height: 24.h,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(12.r),
                      border: Border.all(color: AppColors.neutral100),
                    ),
                    child: Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Icon(
                          Icons.edit_outlined,
                          size: 16.sp,
                          color: AppColors.brand600,
                        ),
                        SizedBox(width: 4.w),
                        Text(
                          'Edit',
                          style: AppTextStyles.body4Medium.copyWith(
                            color: AppColors.brand600,
                          ),
                        ),
                      ],
                    ),
                  ),
                )
              ],
            ),
          ),
          SizedBox(width: 12.w),
          Stack(
            children: [
              CircleAvatar(
                radius: 32.r,
                backgroundColor: AppColors.neutral200,
                backgroundImage: NetworkImage(avatarUrl),
              ),
              Positioned(
                bottom: 0,
                right: 0,
                child: InkWell(
                  onTap: onEdit,
                  child: Container(
                    width: 24.w,
                    height: 24.w,
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      color: AppColors.brand500,
                      border: Border.all(color: Colors.white, width: 2),
                    ),
                    child: Icon(Icons.camera_alt, size: 12.sp, color: Colors.white),
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
