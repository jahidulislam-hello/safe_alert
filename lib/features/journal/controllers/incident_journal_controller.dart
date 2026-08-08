import 'package:flutter/material.dart';
import '../models/incident_entry.dart';

/// Drives the Incident Journal screen: the list of entries, and the
/// show/hide + text state of the "New Entry" compose card that appears
/// when the AppBar's "+" button is tapped.
class IncidentJournalController extends ChangeNotifier {
  IncidentJournalController();

  final List<IncidentEntry> _entries = [
    IncidentEntry(
      id: 'e1',
      category: IncidentCategory.incident,
      description:
          'Was followed home from the subway. Got home safely but felt unsafe at 23rd St station.',
      date: DateTime(2026, 7, 30),
    ),
    IncidentEntry(
      id: 'e2',
      category: IncidentCategory.test,
      description:
          'Was followed home from the subway. Got home safely but felt unsafe at 23rd St station.',
      date: DateTime(2026, 7, 30),
    ),
    IncidentEntry(
      id: 'e3',
      category: IncidentCategory.update,
      description:
          'Was followed home from the subway. Got home safely but felt unsafe at 23rd St station.',
      date: DateTime(2026, 7, 30),
    ),
  ];

  List<IncidentEntry> get entries => List.unmodifiable(_entries);

  /// Whether the "New Entry" compose card is currently shown.
  bool isComposing = false;

  final TextEditingController draftController = TextEditingController();

  bool get canSave => draftController.text.trim().isNotEmpty;

  /// Tapping the AppBar "+" button.
  void startNewEntry() {
    isComposing = true;
    notifyListeners();
  }

  void cancelNewEntry() {
    isComposing = false;
    draftController.clear();
    notifyListeners();
  }

  /// Tapping Save on the compose card. New entries default to the "Update"
  /// tag since the compose form has no category picker in the design —
  /// swap in a real selector here if you want the author to choose one.
  void saveNewEntry() {
    final text = draftController.text.trim();
    if (text.isEmpty) return;
    _entries.insert(
      0,
      IncidentEntry(
        id: DateTime.now().microsecondsSinceEpoch.toString(),
        category: IncidentCategory.update,
        description: text,
        date: DateTime.now(),
      ),
    );
    isComposing = false;
    draftController.clear();
    notifyListeners();
  }

  @override
  void dispose() {
    draftController.dispose();
    super.dispose();
  }
}
