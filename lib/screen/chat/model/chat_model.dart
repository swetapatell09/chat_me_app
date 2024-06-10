class ChatModel {
  String? id, date, time, msg, uid, docId;

  ChatModel({this.uid, this.id, this.date, this.time, this.msg, this.docId});

  factory ChatModel.mapToModel(Map m1, String id) {
    return ChatModel(
        time: m1['time'],
        date: m1['date'],
        msg: m1['msg'],
        docId: id,
        uid: m1['uid']);
  }
}
