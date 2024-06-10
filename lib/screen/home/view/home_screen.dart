import 'package:chat_me_app/screen/profile/model/profile_model.dart';
import 'package:chat_me_app/utils/auth_helper.dart';
import 'package:chat_me_app/utils/notification_service.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../utils/firedb_helper.dart';
import '../controller/home_controller.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  HomeController controller = Get.put(HomeController());
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    FireDBHelper.helper.getUser();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          actions: [
            IconButton(
              onPressed: () {
                NotificationService.helper.showNotification("hii", "hello");
              },
              icon: const Icon(Icons.notification_add_outlined),
            ),
            IconButton(
              onPressed: () {
                NotificationService.helper.scheduleNotification();
              },
              icon: const Icon(Icons.timer),
            ),
            Obx(
              () => IconButton(
                onPressed: () {
                  bool theme = controller.pTheme.value;
                  theme = !theme;
                  controller.setData(theme);
                },
                icon: Icon(controller.icon.value),
              ),
            ),
          ],
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
            StreamBuilder(
              stream: FireDBHelper.helper.getChat2(),
              builder: (context, snapshot) {
                if (snapshot.hasError) {
                  return Text("${snapshot.error}");
                } else if (snapshot.hasData) {
                  List<ProfileModel> list = [];
                  QuerySnapshot? qs = snapshot.data;
                  List<QueryDocumentSnapshot> qds = qs!.docs;

                  for (var x in qds) {
                    Map m1 = x.data() as Map;
                    List uid = m1['uid'];
                    List name = m1['name'];
                    List email = m1['email'];
                    List mobile = m1['mobile'];
                    List profile = m1['profile'];
                    String id = "";
                    String name1 = "";
                    String email1 = "";
                    String mobile1 = "";
                    String profile1 = "";
                    if (uid[0] == AuthHelper.helper.user!.uid) {
                      id = uid[1];
                      name1 = name[1];
                      email1 = email[1];
                      mobile1 = mobile[1];
                      profile1 = profile[1];
                    } else {
                      id = uid[0];
                      name1 = name[0];
                      email1 = email[0];
                      mobile1 = mobile[0];
                      profile1 = profile[0];
                    }
                    ProfileModel p1 = ProfileModel(
                      name: name1,
                      uid: id,
                      email: email1,
                      mobile: mobile1,
                      profile: profile1,
                    );

                    list.add(p1);
                  }
                  return ListView.builder(
                    itemCount: list.length,
                    itemBuilder: (context, index) {
                      return InkWell(
                        onTap: () async {
                          await FireDBHelper.helper.getChat(
                              AuthHelper.helper.user!.uid, list[index].uid!);
                          Get.toNamed('chat', arguments: list[index]);
                        },
                        child: ListTile(
                          leading: CircleAvatar(
                            radius: 20,
                            child: Text(
                              "${list[index].name!.substring(0, 1)}",
                              textAlign: TextAlign.center,
                              style: const TextStyle(fontSize: 20),
                            ),
                          ),
                          title: Text("${list[index].name}"),
                          subtitle: Text("${list[index].mobile}"),
                        ),
                      );
                    },
                  );
                }
                return Container();
              },
            ),
          ],
        ),
        floatingActionButton: FloatingActionButton(
          onPressed: () {
            Get.toNamed('contact');
          },
          child: const Icon(Icons.chat),
        ),
        drawer: Drawer(
          child: Padding(
            padding: const EdgeInsets.all(10.0),
            child: Column(
              children: [
                const SizedBox(
                  height: 10,
                ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Column(
                    children: [
                      FirebaseAuth.instance.currentUser!.photoURL == null
                          ? const Icon(
                              Icons.person,
                              size: 50,
                            )
                          : CircleAvatar(
                              radius: 50,
                              backgroundImage: NetworkImage(
                                  "${FirebaseAuth.instance.currentUser!.photoURL}"),
                            ),
                      const SizedBox(
                        height: 5,
                      ),
                      Visibility(
                        visible:
                            FirebaseAuth.instance.currentUser!.displayName !=
                                null,
                        child: Text(
                          "${FirebaseAuth.instance.currentUser!.displayName}",
                          style: const TextStyle(fontSize: 18),
                        ),
                      ),
                      Text(
                        "${FirebaseAuth.instance.currentUser!.email}",
                        style: const TextStyle(fontSize: 18),
                      ),
                    ],
                  ),
                ),
                ListTile(
                  onTap: () {
                    AuthHelper.helper.logout();
                    Get.offAllNamed('login');
                  },
                  leading: const Icon(Icons.logout),
                  title: const Text("Logout"),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
