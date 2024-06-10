import 'dart:ui';

import 'package:chat_me_app/screen/chat/model/chat_model.dart';
import 'package:chat_me_app/screen/home/controller/home_controller.dart';
import 'package:chat_me_app/screen/profile/model/profile_model.dart';
import 'package:chat_me_app/utils/auth_helper.dart';
import 'package:chat_me_app/utils/firedb_helper.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class ChatScreen extends StatefulWidget {
  const ChatScreen({super.key});

  @override
  State<ChatScreen> createState() => _ChatScreenState();
}

class _ChatScreenState extends State<ChatScreen> {
  ProfileModel p1 = Get.arguments;
  TextEditingController txtMessage = TextEditingController();
  HomeController controller = Get.put(HomeController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: CircleAvatar(
          child: Text(
            "${p1.name?.substring(0, 1)}",
            style: const TextStyle(fontSize: 25),
          ),
          radius: 30,
        ),
        title: Text(
          "${p1.name}",
          style: const TextStyle(fontSize: 25),
        ),
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
          BackdropFilter(filter: ImageFilter.blur(sigmaX: 6, sigmaY: 6)),
          Column(
            children: [
              Expanded(
                child: StreamBuilder(
                  stream: FireDBHelper.helper
                      .getChat1(AuthHelper.helper.user!.uid, p1.uid!),
                  builder: (context, snapshot) {
                    if (snapshot.hasError) {
                      return Text("${snapshot.error}");
                    } else if (snapshot.hasData) {
                      List<ChatModel> chatList = [];
                      QuerySnapshot? qs =
                          snapshot.data as QuerySnapshot<Object?>?;
                      List<QueryDocumentSnapshot> qds = qs!.docs;

                      for (var x in qds) {
                        Map m1 = x.data() as Map;
                        ChatModel c1 = ChatModel.mapToModel(m1, x.id);
                        chatList.add(c1);
                      }
                      return Column(
                        children: [
                          Expanded(
                              child: ListView.builder(
                            itemCount: chatList.length,
                            itemBuilder: (context, index) {
                              print(
                                  "${AuthHelper.helper.user!.uid} ${chatList[index].uid}");

                              return InkWell(
                                onTap: () async {
                                  if (chatList[index].uid ==
                                      AuthHelper.helper.user!.uid) {
                                    await FireDBHelper.helper
                                        .deleteMessage(chatList[index].id!);
                                  }
                                },
                                child: Container(
                                  width: MediaQuery.sizeOf(context).width,
                                  alignment: chatList[index].uid ==
                                          AuthHelper.helper.user!.uid
                                      ? Alignment.centerRight
                                      : Alignment.centerLeft,
                                  child: Container(
                                    margin: const EdgeInsets.all(10),
                                    padding: const EdgeInsets.symmetric(
                                        horizontal: 10),
                                    decoration: BoxDecoration(
                                        color: chatList[index].uid ==
                                                AuthHelper.helper.user!.uid
                                            ? Colors.green.shade200
                                            : Colors.grey,
                                        borderRadius: const BorderRadius.only(
                                            bottomLeft: Radius.circular(5),
                                            topLeft: Radius.circular(5),
                                            topRight: Radius.circular(5))),
                                    child: Text(
                                      "${chatList[index].msg}",
                                      style: const TextStyle(
                                          fontSize: 16, color: Colors.black),
                                    ),
                                  ),
                                ),
                              );
                            },
                          )),
                        ],
                      );
                    }
                    return Container();
                  },
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(12),
                child: TextField(
                  controller: txtMessage,
                  decoration: InputDecoration(
                      border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(30)),
                      hintText: "Type",
                      suffixIcon: IconButton(
                        onPressed: () {
                          ChatModel c1 = ChatModel(
                              uid: AuthHelper.helper.user!.uid,
                              date: "${DateTime.now()}",
                              time: "${TimeOfDay.now()}",
                              msg: txtMessage.text);
                          txtMessage.clear();
                          FireDBHelper.helper.sendMessage(c1, p1);
                        },
                        icon: const Icon(Icons.send),
                      )),
                ),
              )
            ],
          ),
        ],
      ),
    );
  }
}
