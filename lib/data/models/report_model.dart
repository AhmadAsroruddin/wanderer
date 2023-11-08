import 'package:equatable/equatable.dart';
import 'package:wanderer/domain/entities/report.dart';

class ReportModel extends Equatable {
  const ReportModel(this.message, this.userId, this.orderId, this.adminId);

  final String message;
  final String userId;
  final String orderId;
  final String adminId;

  Map<String, dynamic> toMap() {
    return {
      'message': message,
      'userId': userId,
      'orderId': orderId,
      'adminId': adminId
    };
  }

  Report toEntity() {
    return Report(message, userId, orderId, adminId);
  }

  @override
  List<Object> get props => [message, userId, orderId, adminId];
}
