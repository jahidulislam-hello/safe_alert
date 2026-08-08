import 'dart:io';

import 'package:safe_alert/core/utils/app_colors.dart';
import 'package:safe_alert/core/utils/app_styles.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:permission_handler/permission_handler.dart';
import 'profile_photo_picker.dart';

/// Mix into any State that needs "tap a slot -> pick/replace/remove a
/// photo" behavior. Keeps Create Account and Edit Profile identical
/// without copy-pasting the bottom-sheet + permission logic.
mixin PhotoPickerMixin<T extends StatefulWidget> on State<T> {
  final ImagePicker photoPicker = ImagePicker();

  Future<void> handleSlotTap(List<File?> photos, int index, VoidCallback rebuild) async {
    if (photos[index] != null) {
      final action = await _showReplaceOrRemoveSheet();
      if (action == PhotoAction.remove) {
        photos[index] = null;
        rebuild();
      } else if (action == PhotoAction.replace) {
        await _pickInto(photos, index, rebuild);
      }
      return;
    }
    await _pickInto(photos, index, rebuild);
  }

  Future<void> _pickInto(List<File?> photos, int index, VoidCallback rebuild) async {
    final source = await _showSourceSheet();
    if (source == null) return;

    final permission = source == ImageSource.camera ? Permission.camera : Permission.photos;
    final status = await permission.request();
    if (!status.isGranted && !status.isLimited) {
      Get.snackbar(
        'Permission needed',
        'Allow access so you can add your profile photo.',
        snackPosition: SnackPosition.BOTTOM,
      );
      return;
    }

    final picked = await photoPicker.pickImage(source: source, imageQuality: 85);
    if (picked == null) return;

    photos[index] = File(picked.path);
    rebuild();
  }

  Future<ImageSource?> _showSourceSheet() {
    return Get.bottomSheet<ImageSource>(
      Container(
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.vertical(top: Radius.circular(20.r)),
        ),
        padding: EdgeInsets.symmetric(vertical: 12.h),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            ListTile(
              leading: const Icon(Icons.camera_alt_outlined, color: AppColors.brand500),
              title: Text('Take a photo', style: AppTextStyles.body2Regular),
              onTap: () => Get.back(result: ImageSource.camera),
            ),
            ListTile(
              leading: const Icon(Icons.photo_library_outlined, color: AppColors.brand500),
              title: Text('Choose from gallery', style: AppTextStyles.body2Regular),
              onTap: () => Get.back(result: ImageSource.gallery),
            ),
          ],
        ),
      ),
    );
  }

  Future<PhotoAction?> _showReplaceOrRemoveSheet() {
    return Get.bottomSheet<PhotoAction>(
      Container(
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.vertical(top: Radius.circular(20.r)),
        ),
        padding: EdgeInsets.symmetric(vertical: 12.h),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            ListTile(
              leading: const Icon(Icons.swap_horiz, color: AppColors.brand500),
              title: Text('Replace photo', style: AppTextStyles.body2Regular),
              onTap: () => Get.back(result: PhotoAction.replace),
            ),
            ListTile(
              leading: const Icon(Icons.delete_outline, color: AppColors.alarm500),
              title: Text('Remove photo', style: AppTextStyles.body2Regular),
              onTap: () => Get.back(result: PhotoAction.remove),
            ),
          ],
        ),
      ),
    );
  }
}
