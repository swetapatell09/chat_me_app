import 'package:chat_me_app/utils/notification_service.dart';
import 'package:firebase_messaging/firebase_messaging.dart';

class FCMHelper {
  static FCMHelper fcm = FCMHelper._();

  FCMHelper._();
  String? token;

  Future<void> getToken() async {
    token = await FirebaseMessaging.instance.getToken();
    print("==============${token}");
  }

  Future<void> receiveMessage() async {
    getToken();
    FirebaseMessaging.onMessage.listen(
      (event) {
        if (event.notification != null) {
          String? title = event.notification!.title;
          String? body = event.notification!.body;
          NotificationService.helper.showNotification(title!, body!);
        }
      },
    );
  }
}
