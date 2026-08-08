import 'package:safe_alert/core/utils/app_colors.dart';
import 'package:safe_alert/core/utils/app_styles.dart';
import 'package:flutter/material.dart';
import '../widgets/common_widgets.dart';
import 'alert_mode_screen.dart';
import 'alert_sent_screen.dart';

class _EmergencyType {
  final String label;
  final IconData icon;
  const _EmergencyType(this.label, this.icon);
}

const _emergencyTypes = [
  _EmergencyType('Assault', Icons.pan_tool_alt_outlined),
  _EmergencyType('Medical', Icons.local_hospital_outlined),
  _EmergencyType('Fire', Icons.local_fire_department_outlined),
  _EmergencyType('Accident', Icons.car_crash_outlined),
  _EmergencyType('Theft', Icons.theater_comedy_outlined),
  _EmergencyType('Stalking', Icons.visibility_off_outlined),
  _EmergencyType('Natural Disaster', Icons.landscape_outlined),
  _EmergencyType('Mental Health', Icons.psychology_outlined),
  _EmergencyType('Child in danger', Icons.child_care_outlined),
];

/// Emergency type picker with a search field and 3-column grid,
/// plus an overflow "I don't feel safe" option.
class EmergencyTypeScreen extends StatefulWidget {
  final EmergencyAlertMode mode;
  const EmergencyTypeScreen({super.key, required this.mode});

  @override
  State<EmergencyTypeScreen> createState() => _EmergencyTypeScreenState();
}

class _EmergencyTypeScreenState extends State<EmergencyTypeScreen> {
  String? _selectedLabel;
  String _query = '';

  @override
  Widget build(BuildContext context) {
    final filtered = _emergencyTypes
        .where((t) => t.label.toLowerCase().contains(_query.toLowerCase()))
        .toList();

    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppTopBar(title: 'Emergency Type', onBack: () => Navigator.of(context).pop()),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.fromLTRB(20, 8, 20, 20),
          child: Column(
            children: [
              const SizedBox(height: 4),
              const AppLogoMark(size: 40),
              const SizedBox(height: 20),
              TextField(
                onChanged: (v) => setState(() => _query = v),
                decoration: InputDecoration(
                  hintText: 'Search emergency type...',
                  hintStyle: AppTextStyles.body3Regular.copyWith(color: AppColors.neutral400),
                  prefixIcon: const Icon(Icons.search, color: AppColors.neutral400),
                  filled: true,
                  fillColor: AppColors.neutral50,
                  contentPadding: const EdgeInsets.symmetric(vertical: 0),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(24),
                    borderSide: BorderSide.none,
                  ),
                ),
              ),
              const SizedBox(height: 20),
              Expanded(
                child: GridView.builder(
                  itemCount: filtered.length + 1,
                  gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 3,
                    mainAxisSpacing: 12,
                    crossAxisSpacing: 12,
                    childAspectRatio: 0.9,
                  ),
                  itemBuilder: (context, index) {
                    if (index == filtered.length) {
                      return _TypeTile(
                        label: "I don't feel safe",
                        icon: Icons.more_horiz,
                        selected: _selectedLabel == "I don't feel safe",
                        onTap: () => setState(() => _selectedLabel = "I don't feel safe"),
                      );
                    }
                    final t = filtered[index];
                    return _TypeTile(
                      label: t.label,
                      icon: t.icon,
                      selected: _selectedLabel == t.label,
                      onTap: () => setState(() => _selectedLabel = t.label),
                    );
                  },
                ),
              ),
              const SizedBox(height: 12),
              AppFilledButton(
                label: 'Send Alert',
                background: _selectedLabel != null ? AppColors.brand600 : AppColors.neutral300,
                onPressed: _selectedLabel != null
                    ? () => Navigator.of(context).pushReplacement(
                          MaterialPageRoute(
                            builder: (_) => AlertSentScreen(
                              mode: widget.mode,
                              emergencyType: _selectedLabel!,
                            ),
                          ),
                        )
                    : null,
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class _TypeTile extends StatelessWidget {
  final String label;
  final IconData icon;
  final bool selected;
  final VoidCallback onTap;

  const _TypeTile({
    required this.label,
    required this.icon,
    required this.selected,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 150),
        padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 12),
        decoration: BoxDecoration(
          color: selected ? AppColors.brand50 : Colors.white,
          borderRadius: BorderRadius.circular(14),
          border: Border.all(
            color: selected ? AppColors.brand400 : AppColors.neutral100,
            width: selected ? 1.5 : 1,
          ),
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(icon, color: selected ? AppColors.brand600 : AppColors.neutral700, size: 22),
            const SizedBox(height: 8),
            Text(
              label,
              textAlign: TextAlign.center,
              maxLines: 2,
              overflow: TextOverflow.ellipsis,
              style: AppTextStyles.body4Medium.copyWith(
                color: selected ? AppColors.brand700 : AppColors.neutral700,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
