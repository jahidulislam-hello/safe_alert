import '/core/utils/app_colors.dart';
import '/core/utils/app_styles.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';



/// Grid of 0-9 tappable digit chips for choosing the fallback 1-digit
/// PIN. Shows the "PIN {n} selected" confirmation line beneath it.
class PinDigitGrid extends StatelessWidget {
  final int? selectedDigit;
  final ValueChanged<int> onSelect;

  const PinDigitGrid({super.key, required this.selectedDigit, required this.onSelect});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text('Enter 1 digit Pin', style: AppTextStyles.body3Medium.copyWith(color: AppColors.neutral700)),
        SizedBox(height: 10.h),
        Wrap(
          spacing: 10.w,
          runSpacing: 10.h,
          children: List.generate(10, (i) {
            final isSelected = selectedDigit == i;
            return GestureDetector(
              onTap: () => onSelect(i),
              child: Container(
                width: 44.w,
                height: 44.w,
                alignment: Alignment.center,
                decoration: BoxDecoration(
                  color: isSelected ? AppColors.brand500 : Colors.white,
                  borderRadius: BorderRadius.circular(10.r),
                  border: Border.all(
                    color: isSelected ? AppColors.brand500 : AppColors.neutral200,
                  ),
                ),
                child: Text(
                  '$i',
                  style: AppTextStyles.body2Medium.copyWith(
                    color: isSelected ? Colors.white : AppColors.neutral800,
                  ),
                ),
              ),
            );
          }),
        ),
        if (selectedDigit != null) ...[
          SizedBox(height: 10.h),
          Text(
            'PIN $selectedDigit selected',
            style: AppTextStyles.body4Medium.copyWith(color: AppColors.success600),
          ),
        ],
      ],
    );
  }
}
