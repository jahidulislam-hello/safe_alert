import 'package:safe_alert/core/utils/app_colors.dart';
import 'package:flutter/material.dart';
import '../controllers/incident_journal_controller.dart';
import '../widgets/incident_entry_card.dart';
import '../widgets/incident_journal_app_bar.dart';
import '../widgets/new_entry_card.dart';

/// Single screen matching both mockups: the AppBar "+" toggles the
/// New Entry compose card in place at the top of the list — no route
/// change, just a controller-driven state flip.
class IncidentJournalScreen extends StatefulWidget {
  const IncidentJournalScreen({super.key, required this.controller});

  final IncidentJournalController controller;

  @override
  State<IncidentJournalScreen> createState() => _IncidentJournalScreenState();
}

class _IncidentJournalScreenState extends State<IncidentJournalScreen> {
  IncidentJournalController get controller => widget.controller;

  @override
  void initState() {
    super.initState();
    controller.addListener(_onChange);
  }

  @override
  void dispose() {
    controller.removeListener(_onChange);
    super.dispose();
  }

  void _onChange() => setState(() {});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.fromLTRB(20, 12, 20, 0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              IncidentJournalAppBar(onAddPressed: controller.startNewEntry),
              const SizedBox(height: 18),
              Expanded(
                child: ListView(
                  padding: const EdgeInsets.only(bottom: 24),
                  children: [
                    if (controller.isComposing) ...[
                      NewEntryCard(
                        controller: controller.draftController,
                        canSave: controller.canSave,
                        onChanged: (_) => setState(() {}),
                        onSave: controller.saveNewEntry,
                        onCancel: controller.cancelNewEntry,
                      ),
                      const SizedBox(height: 14),
                    ],
                    for (final entry in controller.entries) ...[
                      IncidentEntryCard(entry: entry),
                      const SizedBox(height: 14),
                    ],
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
