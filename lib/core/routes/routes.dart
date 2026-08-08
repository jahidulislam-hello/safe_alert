import 'package:safe_alert/core/navbar/navbar_screen.dart';
import 'package:safe_alert/features/auth/create_account_screen.dart';
import 'package:safe_alert/features/auth/forget/forget_pin_screen.dart';
import 'package:safe_alert/features/auth/login_screen.dart';
import 'package:safe_alert/features/auth/secure_account_screen.dart';
import 'package:safe_alert/features/auth/verify_phone_screen.dart';
import 'package:safe_alert/features/auth/welcome_screen.dart';
import 'package:get/get.dart';


class AppRoutes {
  AppRoutes._();

  static const welcomeScreen       = '/welcome';
  static const createAccountScreen = '/create-account';
  static const verifyPhoneScreen   = '/verify-phone';
  static const secureAccountScreen = '/secure-account';
  static const loginScreen         = '/login';
  static const forgetPinScreen     = '/forget-pin';
  static const bottomNavbar        = '/home';
  static const groupMemberJoinScreen = '/join-group-member';

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
      name: forgetPinScreen,
      page: () => const ForgetPinScreen(),
      transition: Transition.fadeIn,
      transitionDuration: const Duration(milliseconds: 220),
    ),
    GetPage(
      name: bottomNavbar,
      page: () => const BottomNavbar(),
      transition: Transition.fadeIn,
      transitionDuration: const Duration(milliseconds: 220),
    ),
  ];
}