import 'package:chat_me_app/utils/auth_helper.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    super.initState();
    bool isLogin = AuthHelper.helper.checkUser();
    Future.delayed(Duration(seconds: 3),
        () => Get.offAllNamed(isLogin ? 'home' : 'login'));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Image.asset(
              "assets/image/chatlogo.png",
              height: 100,
              width: 100,
            ),
          ],
        ),
      ),
    );
  }
}
