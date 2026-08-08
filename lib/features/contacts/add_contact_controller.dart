import '/features/contacts/contact.dart';
import 'package:flutter/material.dart';


/// Drives the Add Contact popup: name/phone text, the selected status
/// (dropdown), validation, and submission back to [ContactsController].
class AddContactController extends ChangeNotifier {
  AddContactController({required this.onSubmit});

  /// Callback invoked with the finished [Contact] when the form is valid
  /// and "Add Contacts" is pressed — wired to ContactsController.addContact.
  final ValueChanged<Contact> onSubmit;

  final TextEditingController nameController = TextEditingController();
  final TextEditingController phoneController = TextEditingController();

  ContactStatus? selectedStatus;

  bool get isValid =>
      nameController.text.trim().isNotEmpty &&
      phoneController.text.trim().isNotEmpty &&
      selectedStatus != null;

  void setStatus(ContactStatus? status) {
    selectedStatus = status;
    notifyListeners();
  }

  void refresh() => notifyListeners();

  /// Returns true if the contact was created (form was valid).
  bool submit() {
    if (!isValid) {
      notifyListeners(); // trigger validation-state repaint if you add error text
      return false;
    }
    final contact = Contact(
      id: DateTime.now().microsecondsSinceEpoch.toString(),
      name: nameController.text.trim(),
      relation: selectedStatus!.label,
      tag: ContactTag.family,
      avatarColor: kAvatarPalette[DateTime.now().millisecond % kAvatarPalette.length],
    );
    onSubmit(contact);
    return true;
  }

  @override
  void dispose() {
    nameController.dispose();
    phoneController.dispose();
    super.dispose();
  }
}
