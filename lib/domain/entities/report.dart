import 'package:equatable/equatable.dart';

class Report extends Equatable {
  const Report(this.message, this.userId, this.orderId, this.adminId);
  final String message;
  final String userId;
  final String orderId;
  final String adminId;

  @override
  List<Object> get props => [message, userId, orderId, adminId];
}
