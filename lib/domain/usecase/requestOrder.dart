import 'package:dartz/dartz.dart';
import 'package:wanderer/domain/repositories/order_repository.dart';

import '../entities/order.dart';

class RequestOrder {
  final OrderRepos orderRepos;

  RequestOrder({required this.orderRepos});

  Future<Either<String, String>> execute(OrderData orderData) async {
    return await orderRepos.makeOrder(orderData);
  }
}
