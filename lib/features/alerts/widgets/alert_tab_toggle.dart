import '/core/utils/app_colors.dart';
import '/core/utils/app_styles.dart';
import 'package:flutter/material.dart';
import '../models/emergency_models.dart';


/// The rounded "Active(n) / Past alerts" segmented control at the top of
/// the Home screen.
class AlertTabToggle extends StatelessWidget {
  const AlertTabToggle({
    super.key,
    required this.currentTab,
    required this.activeCount,
    required this.onChanged,
  });

  final AlertTab currentTab;
  final int activeCount;
  final ValueChanged<AlertTab> onChanged;

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 52,
      padding: const EdgeInsets.all(4),
      decoration: BoxDecoration(
        color: AppColors.neutral100,
        borderRadius: BorderRadius.circular(30),
      ),
      child: Row(
        children: [
          _Segment(
            label: 'Active($activeCount)',
            selected: currentTab == AlertTab.active,
            onTap: () => onChanged(AlertTab.active),
          ),
          _Segment(
            label: 'Past alerts',
            selected: currentTab == AlertTab.past,
            onTap: () => onChanged(AlertTab.past),
          ),
        ],
      ),
    );
  }
}

class _Segment extends StatelessWidget {
  const _Segment({
    required this.label,
    required this.selected,
    required this.onTap,
  });

  final String label;
  final bool selected;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: GestureDetector(
        onTap: onTap,
        behavior: HitTestBehavior.opaque,
        child: AnimatedContainer(
          duration: const Duration(milliseconds: 180),
          curve: Curves.easeOut,
          alignment: Alignment.center,
          decoration: BoxDecoration(
            color: selected ? AppColors.brand500 : Colors.transparent,
            borderRadius: BorderRadius.circular(26),
          ),
          child: Text(
            label,
            style: AppTextStyles.body2Medium.copyWith(
              color: selected ? Colors.white : AppColors.neutral600,
            ),
          ),
        ),
      ),
    );
  }
}
