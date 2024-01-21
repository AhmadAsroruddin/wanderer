import 'package:dio/dio.dart';
import 'package:wanderer/domain/repositories/notication_repository.dart';

class NotificationReposImpl implements NotificationRepos {
  @override
  Future<void> sendNotification(
      String targetToken, String title, String body) async {
    const serverKey =
        'AAAAuBMSC20:APA91bGBAKSZfz2SMn_eEZviI5iijB9y7N_7XQgL9G_DWDKpG3-1rfxF27slfVv5v9mzN_d6X6unrPOPPq070ZBCskRV4fnCGek9-nkNH7OvmI11SF9abjWexJ09dY_bnEDW904p3jKF'; // Replace with your Firebase Cloud Messaging server key

    final headers = {
      'Content-Type': 'application/json',
      'Authorization': 'key=$serverKey',
    };

    final bodyMap = {
      'to': targetToken,
      'notification': {
        'title': title,
        'body': body,
      },
    };

    const url = 'https://fcm.googleapis.com/fcm/send';

    try {
      final response = await Dio()
          .post(url, options: Options(headers: headers), data: bodyMap);

      if (response.statusCode == 200) {
        print('Notifikasi berhasil dikirim ke perangkat dengan token: ');
      } else {
        print('Gagal mengirim notifikasi. Status code: ${response.statusCode}');
      }
    } catch (e) {
      print('Terjadi kesalahan saat mengirim notifikasi: $e');
    }
  }
}
