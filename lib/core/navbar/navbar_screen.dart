import 'package:safe_alert/core/navbar/controller.dart';
import 'package:safe_alert/core/utils/app_colors.dart';
import 'package:safe_alert/features/alerts/controllers/alert_controller.dart';
import 'package:safe_alert/features/contacts/contacts_controller.dart';
import 'package:safe_alert/features/journal/controllers/incident_journal_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:safe_alert/features/alerts/screens/alert_screen.dart';
import 'package:safe_alert/features/contacts/contacts_screen.dart';
import 'package:safe_alert/features/home/screens/home_screen.dart';
import 'package:safe_alert/features/journal/screens/incident_journal_screen.dart';
import 'package:safe_alert/features/profile/profile_screen.dart';

class BottomNavbar extends StatefulWidget {
  final int initialIndex;
  const BottomNavbar({super.key, this.initialIndex = 0});

  @override
  State<BottomNavbar> createState() => _BottomNavbarState();
}

class _BottomNavbarState extends State<BottomNavbar> {
  late final BottomNavbarController controller;
  late final AlertController _alertController;
  late final ContactsController _contactsController;
  late final IncidentJournalController _journalController;
  late final List<Widget> _pages;

  @override
  void initState() {
    super.initState();
    controller = Get.put(BottomNavbarController(widget.initialIndex));
    _alertController = AlertController(userName: 'Sarah Johnson');
    _alertController.init();
    _contactsController = ContactsController();
    _journalController = IncidentJournalController();
    _pages = [
      const HomeScreen(),
      AlertScreen(controller: _alertController),
      ContactsScreen(controller: _contactsController),
      IncidentJournalScreen(controller: _journalController),
      const ProfileScreen(),
    ];
  }

  @override
  void dispose() {
    _alertController.dispose();
    _contactsController.dispose();
    _journalController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Obx(() => _pages[controller.currentIndex.value]),
      bottomNavigationBar: Container(
        height: 60,
        margin: const EdgeInsets.symmetric(horizontal: 15, vertical: 10),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(20),
          color: AppColors.neutral50,
        ),
        // ClipRRect ensures the top border respects the rounded corners
        // while left, right, and bottom remain borderless.
        child: ClipRRect(
          borderRadius: BorderRadius.circular(20),
          child: Container(
            decoration: const BoxDecoration(
              border: Border(
                top: BorderSide(
                  color: AppColors.neutral100,
                  width: 1.15,
                ),
              ),
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                _buildNavItem(
                  activeImage: "assets/icons/act_home.png",
                  passiveImage: "assets/icons/home.png",
                  index: 0,
                ),
                _buildNavItem(
                  activeImage: "assets/icons/act_alerts.png",
                  passiveImage: "assets/icons/alerts.png",
                  index: 1,
                ),
                _buildNavItem(
                  activeImage: "assets/icons/act_contacts.png",
                  passiveImage: "assets/icons/contacts.png",
                  index: 2,
                ),
                _buildNavItem(
                  activeImage: "assets/icons/act_journal.png",
                  passiveImage: "assets/icons/journal.png",
                  index: 3,
                ),
                _buildNavItem(
                  activeImage: "assets/icons/act_profile.png",
                  passiveImage: "assets/icons/profile.png",
                  index: 4,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildNavItem({
    required String activeImage,
    required String passiveImage,
    required int index,
  }) {
    return GestureDetector(
      onTap: () => controller.changeIndex(index),
      child: Obx(() {
        final isSelected = controller.currentIndex.value == index;

        return Container(
          alignment: Alignment.center,
          child: Image.asset(
            isSelected ? activeImage : passiveImage,
            height: 40,
            width: isSelected ? 90 : 75,
            fit: BoxFit.contain,
          ),
        );
      }),
    );
  }
}
