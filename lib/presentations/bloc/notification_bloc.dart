import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:wanderer/domain/usecase/sendNotification.dart';

part 'notification_state.dart';

class NotificationCubit extends Cubit<NotificationState> {
  final SendNotification _sendNotification;

  NotificationCubit(this._sendNotification) : super(NotificationInitial());

  Future<void> sendNotification(
      String targetToken, String title, String body) async {
    _sendNotification.execute(targetToken, title, body);
  }
}
