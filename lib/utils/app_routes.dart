import 'package:chat_me_app/screen/chat/view/chat_screen.dart';
import 'package:chat_me_app/screen/contact/view/contact_screen.dart';
import 'package:chat_me_app/screen/home/view/home_screen.dart';
import 'package:chat_me_app/screen/login/view/sign_in_screen.dart';
import 'package:chat_me_app/screen/login/view/sign_up_screen.dart';
import 'package:chat_me_app/screen/profile/view/profile_screen.dart';
import 'package:chat_me_app/screen/splash/view/splash_screen.dart';
import 'package:flutter/cupertino.dart';

Map<String, WidgetBuilder> app_route = {
  "/": (context) => const SplashScreen(),
  "login": (context) => const SignInScreen(),
  "signup": (context) => const SignUpScreen(),
  "profile": (context) => const ProfileScreen(),
  "home": (context) => const HomeScreen(),
  "contact": (context) => const ContactScreen(),
  "chat": (context) => const ChatScreen(),
};
