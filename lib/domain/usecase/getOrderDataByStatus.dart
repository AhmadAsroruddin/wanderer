import 'package:dartz/dartz.dart';
import 'package:wanderer/domain/repositories/order_repository.dart';

import '../entities/order.dart';

class GetOrderDataByStatus {
  OrderRepos orderRepos;

  GetOrderDataByStatus({required this.orderRepos});

  Future<Either<String, List<OrderData>>> execute(
      String adminId, String status, bool isUser) async {
    return orderRepos.getOrderDataByStatus(adminId, status, isUser);
  }
}
