import 'package:fact_flow/views/screen/Auth/forget_password_screen.dart';
import 'package:fact_flow/views/screen/Auth/login_screen.dart';
import 'package:fact_flow/views/screen/Auth/signup_screen.dart';
import 'package:fact_flow/views/screen/Splash/Onboarding/onboard_screen.dart';
import 'package:get/get.dart';

import '../views/screen/Home/home_screen.dart';
import '../views/screen/Profile/profile_screen.dart';
import '../views/screen/Splash/splash_screen.dart';

class AppRoutes {
  static String splashScreen = "/splash_screen";
  static String homeScreen = "/home_screen";
  static String profileScreen = "/profile_screen";
  static String onboardScreen = "/onboarding_screen";
  static String loginScreen = "/login_screen";
  static String signupScreen = "/signup_screen";
  static String forgetPasswordScreen = "/forget_password_screen";

  static List<GetPage> page = [
    GetPage(name: splashScreen, page: () => const SplashScreen()),
    GetPage(
      name: homeScreen,
      page: () => const HomeScreen(),
      transition: Transition.noTransition,
    ),

    GetPage(
      name: profileScreen,
      page: () => const ProfileScreen(),
      transition: Transition.noTransition,
    ),
    GetPage(
      name: onboardScreen,
      page: () => OnboardScreen(),
      transition: Transition.noTransition,
    ),
    GetPage(
      name: loginScreen,
      page: () => LoginScreen(),
      transition: Transition.noTransition,
    ),
    GetPage(
      name: forgetPasswordScreen,
      page: () => ForgetPasswordScreen(),
      transition: Transition.noTransition,
    ),
        GetPage(
      name: signupScreen,
      page: () => SignupScreen(),
      transition: Transition.noTransition,
    ),
  ];
}
