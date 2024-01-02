import 'package:firebase_messaging/firebase_messaging.dart';

Future<void> handledBackgroundMessage(RemoteMessage message) async {
  print('Title : ${message.notification?.title}');
  print('Body : ${message.notification?.body}');
  print('Payload : ${message.data}');
}

class FirebaseApi {
  final firebaseMessaging = FirebaseMessaging.instance;

  Future<void> initNotifications() async {
    await firebaseMessaging.requestPermission();

    FirebaseMessaging.onBackgroundMessage(handledBackgroundMessage);
  }
}
