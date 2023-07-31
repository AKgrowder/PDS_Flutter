import 'package:flutter/material.dart';
import 'package:archit_s_application1/presentation/splash_screen/splash_screen.dart';
import 'package:archit_s_application1/presentation/register_create_account_screen/register_create_account_screen.dart';
import 'package:archit_s_application1/presentation/Login_Screen/Login_Screen.dart';
import 'package:archit_s_application1/presentation/otp_verification_screen/otp_verification_screen.dart';
import 'package:archit_s_application1/presentation/forget_password_screen/forget_password_screen.dart';
import 'package:archit_s_application1/presentation/create_account_screen/create_account_screen.dart';
import 'package:archit_s_application1/presentation/app_navigation_screen/app_navigation_screen.dart';

class AppRoutes {
  static const String splashScreen = '/splash_screen';

  static const String registerCreateAccountScreen =
      '/register_create_account_screen';

  static const String registerScreen = '/register_screen';

  static const String otpVerificationScreen = '/otp_verification_screen';

  static const String forgetPasswordScreen = '/forget_password_screen';

  static const String createAccountScreen = '/create_account_screen';

  static const String appNavigationScreen = '/app_navigation_screen';

  static Map<String, WidgetBuilder> routes = {
    splashScreen: (context) => SplashScreen(),
    registerCreateAccountScreen: (context) => RegisterCreateAccountScreen(),
    registerScreen: (context) => LoginScreen(),
    otpVerificationScreen: (context) => OtpVerificationScreen(),
    forgetPasswordScreen: (context) => ForgetPasswordScreen(),
    createAccountScreen: (context) => CreateAccountScreen(),
    appNavigationScreen: (context) => AppNavigationScreen()
  };
}
