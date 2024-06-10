import 'package:chat_me_app/screen/profile/model/profile_model.dart';
import 'package:chat_me_app/utils/auth_helper.dart';
import 'package:chat_me_app/utils/fcm_helper.dart';
import 'package:chat_me_app/utils/firedb_helper.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../home/controller/home_controller.dart';

class ProfileScreen extends StatefulWidget {
  const ProfileScreen({super.key});

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  GlobalKey<FormState> key = GlobalKey<FormState>();
  TextEditingController txtName = TextEditingController();
  TextEditingController txtMobile = TextEditingController();
  TextEditingController txtEmail = TextEditingController();
  TextEditingController txtProfile = TextEditingController();
  HomeController controller = Get.put(HomeController());

  @override
  Widget build(BuildContext context) {
    return Form(
      key: key,
      child: Scaffold(
          appBar: AppBar(
            title: const Text("Profile"),
            centerTitle: true,
          ),
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
              SingleChildScrollView(
                child: FutureBuilder(
                  future: FireDBHelper.helper.getUserProfileData(),
                  builder: (context, snapshot) {
                    if (snapshot.hasError) {
                      return Text("${snapshot.error}");
                    } else if (snapshot.hasData) {
                      DocumentSnapshot? ds = snapshot.data;
                      Map? m1 = ds?.data() as Map?;
                      if (m1 != null) {
                        String name = m1['name'];
                        String email = m1['email'];
                        String mobile = m1['mobile'];
                        String profile = m1['profile'];

                        txtName.text = name;
                        txtEmail.text = email;
                        txtMobile.text = mobile;
                        txtProfile.text = profile;
                      }
                      return Padding(
                        padding: const EdgeInsets.all(12),
                        child: Column(
                          children: [
                            TextFormField(
                              controller: txtName,
                              decoration: const InputDecoration(
                                  border: OutlineInputBorder(),
                                  hintText: "Name",
                                  prefixIcon:
                                      Icon(Icons.account_circle_outlined)),
                              keyboardType: TextInputType.name,
                              validator: (value) {
                                if (value!.isEmpty) {
                                  return "name is required";
                                }
                                return null;
                              },
                            ),
                            const SizedBox(height: 10),
                            TextFormField(
                                controller: txtMobile,
                                decoration: const InputDecoration(
                                    border: OutlineInputBorder(),
                                    hintText: "Mobile",
                                    prefixIcon: Icon(Icons.call)),
                                keyboardType: TextInputType.phone,
                                validator: (value) {
                                  if (value!.isEmpty) {
                                    return "mobile is required";
                                  } else if (value.length != 10) {
                                    return "enter valid number";
                                  }
                                  return null;
                                }),
                            const SizedBox(height: 10),
                            TextFormField(
                              controller: txtEmail,
                              decoration: const InputDecoration(
                                  border: OutlineInputBorder(),
                                  hintText: "Email",
                                  prefixIcon: Icon(Icons.email)),
                              keyboardType: TextInputType.emailAddress,
                              validator: (value) {
                                if (value!.isEmpty) {
                                  return "email is required";
                                }
                                return null;
                              },
                            ),
                            const SizedBox(height: 10),
                            TextFormField(
                              controller: txtProfile,
                              decoration: const InputDecoration(
                                  border: OutlineInputBorder(),
                                  hintText: "Profile",
                                  prefixIcon: Icon(Icons.image)),
                              validator: (value) {
                                if (value!.isEmpty) {
                                  return "profile is required";
                                }
                                return null;
                              },
                            ),
                            const SizedBox(height: 10),
                            ElevatedButton(
                                onPressed: () async {
                                  if (key.currentState!.validate()) {
                                    ProfileModel p1 = ProfileModel(
                                      name: txtName.text,
                                      email: txtEmail.text,
                                      mobile: txtMobile.text,
                                      profile: txtProfile.text,
                                      uid: AuthHelper.helper.user!.uid,
                                      token: FCMHelper.fcm.token,
                                    );
                                    await FireDBHelper.helper.saveUserData(p1);
                                    Get.offAllNamed('home');
                                  }
                                },
                                child: const Text("Save"))
                          ],
                        ),
                      );
                    }
                    return Center(child: CircularProgressIndicator());
                  },
                ),
              ),
            ],
          )),
    );
  }
}
