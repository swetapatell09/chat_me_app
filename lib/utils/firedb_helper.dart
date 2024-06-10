import 'package:chat_me_app/screen/chat/model/chat_model.dart';
import 'package:chat_me_app/screen/profile/model/profile_model.dart';
import 'package:chat_me_app/utils/auth_helper.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class FireDBHelper {
  static FireDBHelper helper = FireDBHelper._();

  FireDBHelper._();

  var db = FirebaseFirestore.instance;
  String? getChatDocId;
  String? chatId;
  ProfileModel? cUser;

  Future<void> saveUserData(ProfileModel model) async {
    await db.collection("user").doc(AuthHelper.helper.user!.uid).set({
      "name": model.name,
      "email": model.email,
      "mobile": model.mobile,
      "profile": model.profile,
      "uid": model.uid,
      "token": model.token,
    });
  }

  Future<DocumentSnapshot<Map<String, dynamic>>> getUserProfileData() async {
    return await db.collection("user").doc(AuthHelper.helper.user!.uid).get();
  }

  Future<QuerySnapshot<Map<String, dynamic>>> getAllContact() async {
    return await db
        .collection("user")
        .where("uid", isNotEqualTo: AuthHelper.helper.user!.uid)
        .get();
  }

  Future<void> sendMessage(ChatModel model, ProfileModel p1) async {
    if (chatId != null) {
      addMessage(chatId!, model, p1);
    } else {
      chatId = await addChatUid(p1);
      addMessage(chatId!, model, p1);
    }
  }

  void addMessage(String docId, ChatModel model, ProfileModel p1) {
    db.collection("chat").doc(docId).collection("msg").add({
      "uid": "${AuthHelper.helper.user!.uid}",
      "date": "${model.date}",
      "time": "${model.time}",
      "msg": "${model.msg}"
    });
  }

  Future<String> addChatUid(ProfileModel p1) async {
    DocumentReference reference = await db.collection("chat").add({
      "uid": [p1.uid, AuthHelper.helper.user!.uid],
      "name": [p1.name, cUser!.name],
      "mobile": [p1.mobile, cUser!.mobile],
      "profile": [p1.profile, cUser!.profile],
      "email": [p1.email, cUser!.email]
    });
    return reference.id;
  }

  Future<void> getChat(String myUid, String userUid) async {
    QuerySnapshot qs = await db
        .collection("chat")
        .where("uid", arrayContainsAny: [myUid, userUid]).get();
    List<DocumentSnapshot> dsList = qs.docs.where(
      (e) {
        List uid = e['uid'];
        if (uid.contains(myUid) && uid.contains(userUid)) {
          return true;
        }
        return false;
      },
    ).toList();
    if (dsList.isNotEmpty) {
      chatId = dsList[0].id;
    } else {
      chatId = null;
    }
  }

  Stream<QuerySnapshot<Map<String, dynamic>>>? getChat1(
      String myUid, String userUid) {
    if (chatId != null) {
      return db
          .collection("chat")
          .doc(chatId)
          .collection("msg")
          .orderBy("date")
          .snapshots();
    }
  }

  Stream<QuerySnapshot<Map<String, dynamic>>> getChat2() {
    return db.collection("chat").where("uid",
        arrayContainsAny: [AuthHelper.helper.user!.uid]).snapshots();
  }

  Future<void> getUser() async {
    DocumentSnapshot ds =
        await db.collection("user").doc(AuthHelper.helper.user!.uid).get();
    Map m1 = ds.data() as Map;
    cUser = ProfileModel.maptoModel(m1, ds.id);
  }
}
