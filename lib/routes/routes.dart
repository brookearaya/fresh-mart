import 'package:flutter/material.dart';
import 'package:fresh_mart/Logic/AuthStateChanges.dart';
import 'package:fresh_mart/cart/cart_page.dart';
import 'package:fresh_mart/cart/checkout.dart';
import 'package:fresh_mart/views/authentication/PhoneNumberSignUp.dart';
import 'package:fresh_mart/views/start/onboarding.dart';
import 'package:fresh_mart/views/start/splashscreen.dart';
import '../widgets/bottomnavbar.dart';

const String SS = "Splash Scree";
const String OBS = "OnBoarding Screen";
const String LOGIN = "SignIn";
const String MainPage = "Bottom Nav Bar";
const String CheckStatus = "Check Status";
const String CartPage = "Cart Page";
//Route controller
Route<dynamic> routesController(RouteSettings setting) {
  switch (setting.name) {
    case SS:
      return MaterialPageRoute(builder: ((context) => SplashScreen()));
    case OBS:
      return MaterialPageRoute(builder: ((context) => OnboardingScreen()));
    case LOGIN:
      return MaterialPageRoute(builder: (context) => PhoneNumberSignUpPage());
    case MainPage:
      return MaterialPageRoute(builder: (context) => DisplayNavBar());
    case CheckStatus:
      return MaterialPageRoute(builder: (context) => AuthStatePage());
    case CartPage:
      return MaterialPageRoute(builder: (context) => Checkout(index: 1,));
    default:
      throw ('Page Does not Exist');
  }
}
