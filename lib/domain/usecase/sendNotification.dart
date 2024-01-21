import 'package:wanderer/domain/repositories/notication_repository.dart';

class SendNotification {
  final NotificationRepos notificationRepos;

  SendNotification({required this.notificationRepos});

  Future<void> execute(String targetToken, String title, String body) async {
    await notificationRepos.sendNotification(targetToken, title, body);
  }
}
