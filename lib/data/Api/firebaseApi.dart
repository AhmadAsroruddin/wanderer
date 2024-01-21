import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:wanderer/data/datasource/user_datasource.dart';

Future<void> handledBackgroundMessage(RemoteMessage message) async {
  print('Title : ${message.notification?.title}');
  print('Body : ${message.notification?.body}');
  print('Payload : ${message.data}');
}

class FirebaseApi {
  final firebaseMessaging = FirebaseMessaging.instance;

  Future<void> initNotifications() async {
    await firebaseMessaging.requestPermission();
    final userRepos = UserDataSourceImpl();

    userRepos.addToken();
    FirebaseMessaging.onBackgroundMessage(handledBackgroundMessage);
  }
}
