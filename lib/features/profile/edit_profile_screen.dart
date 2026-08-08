import '/core/routes/routes.dart';
import '/core/utils/app_colors.dart';
import '/core/utils/app_styles.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class EditProfileScreen extends StatefulWidget {
  const EditProfileScreen({super.key});

  @override
  State<EditProfileScreen> createState() => _EditProfileScreenState();
}

class _EditProfileScreenState extends State<EditProfileScreen> {
  final TextEditingController fullNameController = TextEditingController();
  final TextEditingController dobController = TextEditingController();
  final TextEditingController emailController = TextEditingController();
  final TextEditingController phoneController = TextEditingController();
  final TextEditingController locationController = TextEditingController();
  final TextEditingController emergencyController = TextEditingController();

  String selectedRace = 'White';

  @override
  void dispose() {
    fullNameController.dispose();
    dobController.dispose();
    emailController.dispose();
    phoneController.dispose();
    locationController.dispose();
    emergencyController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      resizeToAvoidBottomInset: true,
      body: SafeArea(
        child: LayoutBuilder(
          builder: (context, constraints) {
            return SingleChildScrollView(
              physics: const BouncingScrollPhysics(),
              padding: const EdgeInsets.symmetric(
                horizontal: 16,
                vertical: 10,
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  _buildHeader(),
                  const SizedBox(height: 24),
                  _buildProfilePhotos(),
                  const SizedBox(height: 14),
                  _buildLabel('Full name'),
                  const SizedBox(height: 6),
                  _buildTextField(controller: fullNameController, hintText: 'Miles'),
                  const SizedBox(height: 12),
                  _buildLabel('Race', suffix: '(Optional)'),
                  const SizedBox(height: 6),
                  _buildRaceDropdown(),
                  const SizedBox(height: 12),
                  _buildLabel('Date Of Birth'),
                  const SizedBox(height: 6),
                  _buildTextField(
                    controller: dobController,
                    hintText: 'MM/DD/YYYY',
                    keyboardType: TextInputType.datetime,
                  ),
                  const SizedBox(height: 12),
                  _buildLabel('Email Address'),
                  const SizedBox(height: 6),
                  _buildTextField(
                    controller: emailController,
                    hintText: 'sarah@gmail.com',
                    keyboardType: TextInputType.emailAddress,
                  ),
                  const SizedBox(height: 12),
                  _buildLabel('Phone Number'),
                  const SizedBox(height: 6),
                  _buildTextField(
                    controller: phoneController,
                    hintText: '+2(555) 000 - 0000',
                    keyboardType: TextInputType.phone,
                  ),
                  const SizedBox(height: 12),
                  _buildLabel('Location'),
                  const SizedBox(height: 6),
                  _buildTextField(controller: locationController, hintText: 'New York, NY'),
                  const SizedBox(height: 12),
                  _buildLabel('Emergency Contact'),
                  const SizedBox(height: 6),
                  _buildTextField(
                    controller: emergencyController,
                    hintText: 'James Johnson - Father',
                  ),
                  const SizedBox(height: 16),
                  _buildContinueButton(),
                  const SizedBox(height: 10),
                ],
              ),
            );
          },
        ),
      ),
    );
  }

  // ---------------------------------------------------------------------------
  // HEADER
  // ---------------------------------------------------------------------------

  Widget _buildHeader() {
    return SizedBox(
      height: 28,
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Expanded(
            child: Text(
              'Edit Profile',
              style: AppTextStyles.body2Medium.copyWith(
                color: AppColors.neutral900,
                fontSize: 16,
                height: 20 / 16,
              ),
            ),
          ),
          GestureDetector(
            onTap: () => Get.back(),
            behavior: HitTestBehavior.opaque,
            child: const SizedBox(
              width: 28,
              height: 28,
              child: Center(
                child: Icon(Icons.close, size: 18, color: AppColors.neutral900),
              ),
            ),
          ),
        ],
      ),
    );
  }

  // ---------------------------------------------------------------------------
  // PROFILE PHOTOS
  // ---------------------------------------------------------------------------

  Widget _buildProfilePhotos() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            Text(
              'Profile Photos',
              style: AppTextStyles.caption1Medium.copyWith(
                color: AppColors.neutral800,
              ),
            ),
            const SizedBox(width: 3),
            Text(
              '*',
              style: AppTextStyles.caption1Medium.copyWith(
                color: AppColors.alarm500,
              ),
            ),
            const Spacer(),
            Container(
              height: 18,
              padding: const EdgeInsets.symmetric(horizontal: 7),
              decoration: BoxDecoration(
                color: const Color(0xFFFFE4DE),
                borderRadius: BorderRadius.circular(10),
              ),
              alignment: Alignment.center,
              child: Text(
                '0/3 required',
                style: AppTextStyles.caption1Medium.copyWith(
                  fontSize: 9,
                  height: 12 / 9,
                  color: AppColors.alarm400,
                ),
              ),
            ),
          ],
        ),
        const SizedBox(height: 8),
        Row(
          children: [
            Expanded(child: _buildPhotoBox(label: 'Photo 1')),
            const SizedBox(width: 8),
            Expanded(child: _buildPhotoBox(label: 'Photo 2')),
            const SizedBox(width: 8),
            Expanded(child: _buildPhotoBox(label: 'Photo 3')),
          ],
        ),
      ],
    );
  }

  Widget _buildPhotoBox({required String label}) {
    return AspectRatio(
      aspectRatio: 1.08,
      child: Container(
        decoration: BoxDecoration(
          color: AppColors.neutral50,
          border: Border.all(color: AppColors.neutral100, width: 1),
          borderRadius: BorderRadius.circular(6),
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Icon(Icons.camera_alt_outlined, size: 20, color: AppColors.neutral800),
            const SizedBox(height: 5),
            Text(
              label,
              style: AppTextStyles.caption1Medium.copyWith(
                fontSize: 10,
                height: 12 / 10,
                color: AppColors.neutral700,
              ),
            ),
          ],
        ),
      ),
    );
  }

  // ---------------------------------------------------------------------------
  // LABEL
  // ---------------------------------------------------------------------------

  Widget _buildLabel(String text, {bool isRequired = false, String? suffix}) {
    return Row(
      children: [
        Text(
          text,
          style: AppTextStyles.caption1Medium.copyWith(color: AppColors.neutral800),
        ),
        if (isRequired) ...[
          const SizedBox(width: 2),
          Text('*',
              style: AppTextStyles.caption1Medium.copyWith(color: AppColors.alarm500)),
        ],
        if (suffix != null) ...[
          const SizedBox(width: 3),
          Text(suffix,
              style: AppTextStyles.caption1Medium.copyWith(color: AppColors.neutral500)),
        ],
      ],
    );
  }

  // ---------------------------------------------------------------------------
  // TEXT FIELD
  // ---------------------------------------------------------------------------

  Widget _buildTextField({
    required TextEditingController controller,
    required String hintText,
    TextInputType? keyboardType,
  }) {
    return SizedBox(
      height: 48,
      child: TextField(
        controller: controller,
        keyboardType: keyboardType,
        style: AppTextStyles.body4Regular.copyWith(color: AppColors.neutral800),
        cursorColor: AppColors.brand500,
        decoration: InputDecoration(
          hintText: hintText,
          hintStyle: AppTextStyles.body4Regular.copyWith(color: AppColors.neutral400),
          filled: true,
          fillColor: Colors.white,
          contentPadding: const EdgeInsets.symmetric(horizontal: 12, vertical: 13),
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(6),
            borderSide: const BorderSide(color: AppColors.neutral200, width: 1),
          ),
          enabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(6),
            borderSide: const BorderSide(color: AppColors.neutral200, width: 1),
          ),
          focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(6),
            borderSide: const BorderSide(color: AppColors.brand500, width: 1),
          ),
        ),
      ),
    );
  }

  // ---------------------------------------------------------------------------
  // RACE DROPDOWN
  // ---------------------------------------------------------------------------

  Widget _buildRaceDropdown() {
    return Container(
      height: 48,
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(6),
        border: Border.all(color: AppColors.neutral200, width: 1),
      ),
      padding: const EdgeInsets.symmetric(horizontal: 12),
      child: DropdownButtonHideUnderline(
        child: DropdownButton<String>(
          value: selectedRace,
          isExpanded: true,
          icon: const Icon(
            Icons.keyboard_arrow_down_rounded,
            size: 20,
            color: AppColors.neutral500,
          ),
          style: AppTextStyles.body4Regular.copyWith(color: AppColors.neutral600),
          dropdownColor: Colors.white,
          borderRadius: BorderRadius.circular(6),
          items: const [
            DropdownMenuItem(value: 'White', child: Text('White')),
            DropdownMenuItem(value: 'Black', child: Text('Black')),
            DropdownMenuItem(value: 'Asian', child: Text('Asian')),
            DropdownMenuItem(value: 'Other', child: Text('Other')),
          ],
          onChanged: (value) {
            if (value == null) return;
            setState(() => selectedRace = value);
          },
        ),
      ),
    );
  }

  // ---------------------------------------------------------------------------
  // CONTINUE BUTTON — navigates to VerifyPhoneScreen, passing phone number
  // ---------------------------------------------------------------------------

  Widget _buildContinueButton() {
    return SizedBox(
      width: double.infinity,
      height: 48,
      child: ElevatedButton(
        onPressed: () {
          Get.toNamed(
            AppRoutes.verifyPhoneScreen,
            arguments: phoneController.text.trim(),
          );
        },
        style: ElevatedButton.styleFrom(
          backgroundColor: AppColors.brand500,
          foregroundColor: Colors.white,
          elevation: 0,
          shadowColor: Colors.transparent,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(24),
          ),
          padding: EdgeInsets.zero,
        ),
        child: Text(
          'Update Profile',
          style: AppTextStyles.caption1Medium.copyWith(
            fontSize: 14,
            color: Colors.white,
          ),
        ),
      ),
    );
  }
}
