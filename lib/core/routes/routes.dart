import 'package:safe_alert/core/navbar/navbar_screen.dart';
import 'package:safe_alert/features/auth/create_account_screen.dart';
import 'package:safe_alert/features/auth/forget/enter_otp_screen.dart';
import 'package:safe_alert/features/auth/forget/forget_pin_screen.dart';
import 'package:safe_alert/features/auth/forget/pin_updated_screen.dart';
import 'package:safe_alert/features/auth/forget/set_new_pin_screen.dart';
import 'package:safe_alert/features/auth/login_screen.dart';
import 'package:safe_alert/features/auth/secure_account_screen.dart';
import 'package:safe_alert/features/auth/verify_phone_screen.dart';
import 'package:safe_alert/features/auth/welcome_screen.dart';
import 'package:safe_alert/features/profile/edit_profile_screen.dart';
import 'package:safe_alert/features/profile/profile_screen.dart';
import 'package:safe_alert/features/subscription/cancel_subscription_screen.dart';
import 'package:safe_alert/features/subscription/choose_plan_screen.dart';
import 'package:safe_alert/features/subscription/my_subscription_screen.dart';
import 'package:get/get.dart';

class AppRoutes {
  AppRoutes._();

  static const welcomeScreen = '/welcome';
  static const createAccountScreen = '/create-account';
  static const verifyPhoneScreen = '/verify-phone';
  static const secureAccountScreen = '/secure-account';
  static const loginScreen = '/login';
  static const groupMemberJoinScreen = '/join-group-member';
  static const profileScreen = '/profile';
  static const editProfileScreen = '/edit-profile';
  static const forgetPinScreen = '/forget-pin';
  static const enterOtpForgetPinScreen = '/forget-pin/enter-otp';
  static const setNewPinScreen = '/forget-pin/set-new-pin';
  static const pinUpdatedScreen = '/forget-pin/pin-updated';
  static const mySubscriptionScreen = '/my-subscription';
  static const cancelSubscriptionScreen = '/cancel-subscription';
  static const choosePlanScreen = '/choose-plan';
  static const bottomNavbar = '/bottom-navbar';

  static final List<GetPage> page = [
    GetPage(
      name: welcomeScreen,
      page: () => const WelcomeScreen(),
      transition: Transition.fadeIn,
      transitionDuration: const Duration(milliseconds: 220),
    ),
    GetPage(
      name: createAccountScreen,
      page: () => const CreateAccountScreen(),
      transition: Transition.fadeIn,
      transitionDuration: const Duration(milliseconds: 220),
    ),
    GetPage(
      name: verifyPhoneScreen,
      page: () => const VerifyPhoneScreen(),
      transition: Transition.fadeIn,
      transitionDuration: const Duration(milliseconds: 220),
    ),
    GetPage(
      name: secureAccountScreen,
      page: () => const SecureAccountScreen(),
      transition: Transition.fadeIn,
      transitionDuration: const Duration(milliseconds: 220),
    ),
    GetPage(
      name: loginScreen,
      page: () => const LoginScreen(),
      transition: Transition.fadeIn,
      transitionDuration: const Duration(milliseconds: 220),
    ),
    GetPage(
      name: profileScreen,
      page: () => const ProfileScreen(),
      transition: Transition.fadeIn,
      transitionDuration: const Duration(milliseconds: 220),
    ),
    GetPage(
      name: editProfileScreen,
      page: () => const EditProfileScreen(),
      transition: Transition.fadeIn,
      transitionDuration: const Duration(milliseconds: 220),
    ),
    GetPage(
      name: forgetPinScreen,
      page: () => const ForgetPinScreen(),
      transition: Transition.fadeIn,
      transitionDuration: const Duration(milliseconds: 220),
    ),
    GetPage(
      name: enterOtpForgetPinScreen,
      page: () => const EnterOtpScreen(),
      transition: Transition.fadeIn,
      transitionDuration: const Duration(milliseconds: 220),
    ),
    GetPage(
      name: setNewPinScreen,
      page: () => const SetNewPinScreen(),
      transition: Transition.fadeIn,
      transitionDuration: const Duration(milliseconds: 220),
    ),
    GetPage(
      name: pinUpdatedScreen,
      page: () => const PinUpdatedScreen(),
      transition: Transition.fadeIn,
      transitionDuration: const Duration(milliseconds: 220),
    ),
    GetPage(
      name: mySubscriptionScreen,
      page: () => const MySubscriptionScreen(),
      transition: Transition.fadeIn,
      transitionDuration: const Duration(milliseconds: 220),
    ),
    GetPage(
      name: cancelSubscriptionScreen,
      page: () => const CancelSubscriptionScreen(),
      transition: Transition.fadeIn,
      transitionDuration: const Duration(milliseconds: 220),
    ),
    GetPage(
      name: choosePlanScreen,
      page: () => const ChoosePlanScreen(),
      transition: Transition.fadeIn,
      transitionDuration: const Duration(milliseconds: 220),
    ),
    GetPage(
      name: bottomNavbar,
      page: () => const BottomNavbar(),
      transition: Transition.fadeIn,
      transitionDuration: const Duration(milliseconds: 220),
    ),
    // groupMemberJoinScreen — point at your existing screen once built;
    // no GetPage entry yet since there's no screen for it.
  ];
}