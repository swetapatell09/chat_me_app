import 'package:chat_me_app/firebase_options.dart';
import 'package:chat_me_app/screen/home/controller/home_controller.dart';
import 'package:chat_me_app/utils/app_routes.dart';
import 'package:chat_me_app/utils/fcm_helper.dart';
import 'package:chat_me_app/utils/notification_service.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

HomeController controller = Get.put(HomeController());
void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  NotificationService.helper.initNotification();
  FCMHelper.fcm.receiveMessage();
  runApp(Obx(() {
    controller.getData();
    return GetMaterialApp(
      theme: ThemeData.light(),
      darkTheme: ThemeData.dark(),
      themeMode: controller.mode.value,
      debugShowCheckedModeBanner: false,
      initialRoute: "/",
      routes: app_route,
    );
  }));
}
