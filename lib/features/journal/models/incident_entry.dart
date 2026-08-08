/// The three tag categories a journal entry can carry, each with its own
/// chip color per the design (pink/red = Incident, lavender = Test,
/// green = Update).
enum IncidentCategory { incident, test, update }

extension IncidentCategoryLabel on IncidentCategory {
  String get label {
    switch (this) {
      case IncidentCategory.incident:
        return 'Incident';
      case IncidentCategory.test:
        return 'Test';
      case IncidentCategory.update:
        return 'Update';
    }
  }
}

/// A single entry in the Incident Journal.
class IncidentEntry {
  final String id;
  final IncidentCategory category;
  final String description;
  final DateTime date;

  const IncidentEntry({
    required this.id,
    required this.category,
    required this.description,
    required this.date,
  });
}
