import 'package:dartz/dartz.dart';
import 'package:wanderer/domain/repositories/order_repository.dart';

class UpdateStatusOrder {
  final OrderRepos orderRepos;
  UpdateStatusOrder({required this.orderRepos});

  Future<Either<String, String>> execute(
      String id, String adminId, String status) {
    return orderRepos.updateStatus(id, adminId, status);
  }
}
