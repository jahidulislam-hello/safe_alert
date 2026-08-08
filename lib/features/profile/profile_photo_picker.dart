import 'dart:io';
import 'package:safe_alert/core/utils/app_colors.dart';
import 'package:safe_alert/core/utils/app_styles.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';


/// The "Profile Photos" section — required badge + N photo slots.
/// Used on Create Account and Edit Profile so both stay pixel-identical.
class ProfilePhotoPicker extends StatelessWidget {
  final int requiredCount;
  final List<File?> photos;
  final ValueChanged<int> onTapSlot;

  const ProfilePhotoPicker({
    super.key,
    required this.requiredCount,
    required this.photos,
    required this.onTapSlot,
  });

  int get _selectedCount => photos.where((p) => p != null).length;

  @override
  Widget build(BuildContext context) {
    final remaining = requiredCount - _selectedCount;
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            Text('Profile Photos ', style: AppTextStyles.body3Medium),
            Text('*', style: AppTextStyles.body3Medium.copyWith(color: AppColors.alarm500)),
            const Spacer(),
            Container(
              padding: EdgeInsets.symmetric(horizontal: 10.w, vertical: 4.h),
              decoration: BoxDecoration(
                color: AppColors.alarm50,
                borderRadius: BorderRadius.circular(20.r),
              ),
              child: Text(
                remaining > 0 ? '$remaining/$requiredCount required' : 'Complete',
                style: AppTextStyles.caption1SemiBold.copyWith(color: AppColors.alarm700),
              ),
            ),
          ],
        ),
        SizedBox(height: 10.h),
        Row(
          children: List.generate(requiredCount, (i) {
            return Padding(
              padding: EdgeInsets.only(right: i == requiredCount - 1 ? 0 : 10.w),
              child: _PhotoSlot(
                index: i,
                file: photos[i],
                onTap: () => onTapSlot(i),
              ),
            );
          }),
        ),
      ],
    );
  }
}

class _PhotoSlot extends StatelessWidget {
  final int index;
  final File? file;
  final VoidCallback onTap;

  const _PhotoSlot({required this.index, required this.file, required this.onTap});

  @override
  Widget build(BuildContext context) {
    final hasPhoto = file != null;
    return Expanded(
      child: GestureDetector(
        onTap: onTap,
        child: AspectRatio(
          aspectRatio: 1,
          child: Container(
            clipBehavior: Clip.antiAlias,
            decoration: BoxDecoration(
              color: hasPhoto ? AppColors.brand50 : AppColors.neutral50,
              borderRadius: BorderRadius.circular(12.r),
              border: Border.all(
                color: hasPhoto ? AppColors.brand500 : AppColors.neutral200,
                width: hasPhoto ? 1.6 : 1,
              ),
            ),
            child: Stack(
              fit: StackFit.expand,
              children: [
                if (hasPhoto)
                  Image.file(file!, fit: BoxFit.cover)
                else
                  Center(
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Icon(Icons.camera_alt_outlined, color: AppColors.neutral400, size: 22.sp),
                        SizedBox(height: 4.h),
                        Text(
                          'Photo ${index + 1}',
                          style: AppTextStyles.body4Regular.copyWith(color: AppColors.neutral500),
                        ),
                      ],
                    ),
                  ),
                if (hasPhoto)
                  Positioned(
                    top: 6.h,
                    right: 6.w,
                    child: Container(
                      width: 22.w,
                      height: 22.w,
                      decoration: const BoxDecoration(shape: BoxShape.circle, color: AppColors.brand500),
                      child: Icon(Icons.check, color: Colors.white, size: 14.sp),
                    ),
                  ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

/// Bottom sheets shared by any screen that needs to pick/replace/remove
/// a photo (Create Account, Edit Profile, single avatar upload).
enum PhotoAction { replace, remove }
