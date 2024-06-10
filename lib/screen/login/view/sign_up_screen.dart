import 'package:chat_me_app/utils/auth_helper.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../home/controller/home_controller.dart';

class SignUpScreen extends StatefulWidget {
  const SignUpScreen({super.key});

  @override
  State<SignUpScreen> createState() => _SignUpScreen();
}

class _SignUpScreen extends State<SignUpScreen> {
  TextEditingController txtEmail = TextEditingController();
  TextEditingController txtPass = TextEditingController();
  HomeController controller = Get.put(HomeController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          Obx(
            () => controller.pTheme == true
                ? Image.asset(
                    "assets/image/img_2.png",
                    width: MediaQuery.sizeOf(context).width,
                    fit: BoxFit.cover,
                    height: MediaQuery.sizeOf(context).height,
                  )
                : Image.asset(
                    "assets/image/img.png",
                    width: MediaQuery.sizeOf(context).width,
                    fit: BoxFit.cover,
                    height: MediaQuery.sizeOf(context).height,
                  ),
          ),
          Padding(
            padding: const EdgeInsets.all(12),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Image.asset(
                  "assets/image/chatlogo.png",
                  height: 100,
                  width: 100,
                ),
                const Text(
                  "Chat Me SignUp",
                  style: TextStyle(fontSize: 20),
                ),
                const SizedBox(
                  height: 50,
                ),
                TextField(
                  controller: txtEmail,
                  decoration: const InputDecoration(hintText: "Email"),
                ),
                const SizedBox(
                  height: 20,
                ),
                Obx(
                  () => TextField(
                    obscureText: controller.isHide.value,
                    controller: txtPass,
                    decoration: InputDecoration(
                        suffixIcon: IconButton(
                            onPressed: () {
                              controller.showPassword();
                            },
                            icon: Icon(controller.isHide.value
                                ? Icons.visibility_off
                                : Icons.visibility)),
                        hintText: "Password"),
                  ),
                ),
                const SizedBox(
                  height: 20,
                ),
                ElevatedButton(
                    onPressed: () async {
                      String? msg = await AuthHelper.helper
                          .signUp(txtEmail.text, txtPass.text);
                      if (msg == "Success") {
                        Get.back();
                      } else {
                        Get.snackbar("$msg", "Chat Me");
                      }
                    },
                    child: const Text("Sign In")),
                const SizedBox(
                  height: 50,
                ),
                TextButton(
                    onPressed: () {
                      Get.back();
                    },
                    child: const Text("Already have an account"))
              ],
            ),
          ),
        ],
      ),
    );
  }
}
