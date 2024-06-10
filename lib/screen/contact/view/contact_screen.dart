import 'package:chat_me_app/screen/profile/model/profile_model.dart';
import 'package:chat_me_app/utils/auth_helper.dart';
import 'package:chat_me_app/utils/firedb_helper.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../home/controller/home_controller.dart';

class ContactScreen extends StatefulWidget {
  const ContactScreen({super.key});

  @override
  State<ContactScreen> createState() => _ContactScreenState();
}

class _ContactScreenState extends State<ContactScreen> {
  HomeController controller = Get.put(HomeController());
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text("Contacts"),
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
            FutureBuilder(
              future: FireDBHelper.helper.getAllContact(),
              builder: (context, snapshot) {
                if (snapshot.hasError) {
                  return Text("${snapshot.error}");
                } else if (snapshot.hasData) {
                  List<ProfileModel> profileList = [];
                  QuerySnapshot? qs = snapshot.data;
                  List<QueryDocumentSnapshot> qds = qs!.docs;

                  for (var x in qds) {
                    Map m1 = x.data() as Map;
                    ProfileModel model = ProfileModel.maptoModel(m1, x.id);
                    profileList.add(model);
                  }
                  return ListView.builder(
                    itemCount: profileList.length,
                    itemBuilder: (context, index) {
                      return InkWell(
                        onTap: () async {
                          await FireDBHelper.helper.getChat(
                              AuthHelper.helper.user!.uid,
                              profileList[index].uid!);
                          Get.toNamed('chat', arguments: profileList[index]);
                        },
                        child: ListTile(
                          leading: CircleAvatar(
                            child: Text(
                              "${profileList[index].name?.substring(0, 1)}",
                              style: TextStyle(fontSize: 20),
                            ),
                          ),
                          title: Text("${profileList[index].name}"),
                          subtitle: Text("${profileList[index].mobile}"),
                        ),
                      );
                    },
                  );
                }
                return const Center(child: CircularProgressIndicator());
              },
            ),
          ],
        ));
  }
}
