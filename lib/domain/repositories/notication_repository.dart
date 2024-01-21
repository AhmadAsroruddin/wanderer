abstract class NotificationRepos {
  Future<void> sendNotification(String targetToken, String title, String body);
}
