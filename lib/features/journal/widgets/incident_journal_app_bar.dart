import 'package:safe_alert/core/utils/app_colors.dart';
import 'package:safe_alert/core/utils/app_styles.dart';
import 'package:flutter/material.dart';


/// "Incident Journal" title on the left, crest mark centered, and the
/// round blue "+" button on the right that opens the compose card.
class IncidentJournalAppBar extends StatelessWidget {
  const IncidentJournalAppBar({super.key, required this.onAddPressed});

  final VoidCallback onAddPressed;

  @override
  Widget build(BuildContext context) {
    return Stack(
      alignment: Alignment.center,
      children: [
        // Title left-aligned
        Align(
          alignment: Alignment.centerLeft,
          child: Text(
            'Incident Journal',
            style: AppTextStyles.h6Bold.copyWith(color: AppColors.brand900),
          ),
        ),
        // Crest perfectly centered
         _CrestMark(),
        // Add button right-aligned
        Align(
          alignment: Alignment.centerRight,
          child: _AddButton(onTap: onAddPressed),
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
    return SizedBox(
      width: 70,
      height: 70,
      child: Image.asset('assets/icons/profile_logo.png'),
    );
  }
}

class _AddButton extends StatelessWidget {
  const _AddButton({required this.onTap});

  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return Material(
      color: AppColors.brand500,
      shape: const CircleBorder(),
      child: InkWell(
        customBorder: const CircleBorder(),
        onTap: onTap,
        child: const SizedBox(
          width: 40,
          height: 40,
          child: Icon(Icons.add_rounded, color: Colors.white, size: 22),
        ),
      ),
    );
  }
}
