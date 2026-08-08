import 'package:flutter/foundation.dart';
import '../models/emergency_models.dart';

/// Drives the Live Alert detail screen: elapsed timer text and whether the
/// current user has tapped "I'm Responding".
class LiveAlertController extends ChangeNotifier {
  LiveAlertController({required this.alert});

  final EmergencyAlertModel alert;

  bool _isResponding = false;
  bool get isResponding => _isResponding;

  String elapsed = '04:09';

  void respond() {
    if (_isResponding) return;
    _isResponding = true;
    // TODO: notify backend that this user is en route.
    notifyListeners();
  }

  void cantHelp() {
    // TODO: notify backend the user declined to help; typically pops the screen.
  }
}
