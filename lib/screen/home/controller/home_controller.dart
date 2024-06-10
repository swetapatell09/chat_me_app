import 'package:chat_me_app/utils/share_helper.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class HomeController extends GetxController {
  Rx<IconData> icon = Icons.light_mode.obs;
  RxBool pTheme = false.obs;
  Rx<ThemeMode> mode = ThemeMode.light.obs;
  RxBool isHide = true.obs;

  Future<void> setData(bool theme) async {
    ShareHelper.helper.setTheme(theme);
    pTheme.value = (await ShareHelper.helper.applyTheme())!;
    if (pTheme.value == true) {
      icon.value = Icons.light_mode;
      mode.value = ThemeMode.dark;
    } else {
      icon.value = Icons.dark_mode;
      mode.value = ThemeMode.light;
    }
  }

  Future<void> getData() async {
    if (await ShareHelper.helper.applyTheme() != null) {
      pTheme.value = (await ShareHelper.helper.applyTheme())!;
      setData(pTheme.value);
    } else {
      pTheme.value = false;
      setData(pTheme.value);
    }
  }

  void showPassword() {
    isHide.value = !isHide.value;
  }
}
