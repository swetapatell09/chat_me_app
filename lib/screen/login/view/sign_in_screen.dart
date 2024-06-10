import 'package:chat_me_app/screen/home/controller/home_controller.dart';
import 'package:chat_me_app/utils/auth_helper.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class SignInScreen extends StatefulWidget {
  const SignInScreen({super.key});

  @override
  State<SignInScreen> createState() => _SignInScreenState();
}

class _SignInScreenState extends State<SignInScreen> {
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
            child: SingleChildScrollView(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const SizedBox(
                    height: 150,
                  ),
                  Image.asset(
                    "assets/image/chatlogo.png",
                    height: 100,
                    width: 100,
                  ),
                  const Text(
                    "Chat Me Login",
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
                            .signIn(txtEmail.text, txtPass.text);
                        if (msg == "Success") {
                          Get.offAllNamed('profile');
                        } else {
                          Get.snackbar("$msg", "");
                        }
                      },
                      child: const Text("Login")),
                  const SizedBox(
                    height: 10,
                  ),
                  ElevatedButton(
                      onPressed: () async {
                        String msg = await AuthHelper.helper.guestLogIn();
                        if (msg == 'Success') {
                          Get.offAllNamed('profile');
                        } else {
                          Get.snackbar("$msg", "");
                        }
                      },
                      child: const Text("Sign in as Guest")),
                  const SizedBox(
                    height: 20,
                  ),
                  InkWell(
                    onTap: () {
                      AuthHelper.helper.signInWithGoogle();
                    },
                    child: Container(
                      padding: const EdgeInsets.only(right: 10),
                      height: 40,
                      width: 120,
                      decoration: BoxDecoration(
                          color: Colors.grey,
                          borderRadius: BorderRadius.circular(20)),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceAround,
                        children: [
                          Image.asset(
                            "assets/image/google_logo.png",
                            height: 80,
                            width: 35,
                          ),
                          const Text(
                            "Google",
                            style: TextStyle(fontSize: 20, color: Colors.red),
                          )
                        ],
                      ),
                    ),
                  ),
                  // ElevatedButton(
                  //     onPressed: () {
                  //       AuthHelper.helper.signInWithGoogle();
                  //     },
                  //     child: const Text("Google")),
                  const SizedBox(
                    height: 20,
                  ),
                  TextButton(
                      onPressed: () {
                        Get.toNamed('signup');
                      },
                      child: const Text(
                        "Create a new Account",
                        style: TextStyle(fontSize: 20),
                      ))
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
