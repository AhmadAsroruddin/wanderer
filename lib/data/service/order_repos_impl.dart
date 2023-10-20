import 'package:dartz/dartz.dart';
import 'package:wanderer/data/datasource/order_datasource.dart';

import 'package:wanderer/domain/entities/order.dart';
import 'package:wanderer/domain/repositories/order_repository.dart';

class OrderReposImpl extends OrderRepos {
  final OrderDataSource orderDataSource;
  OrderReposImpl({required this.orderDataSource});

  @override
  Future<Either<String, String>> makeOrder(OrderData order) async {
    try {
      await orderDataSource.makeOrder(order);
      return const Right("Data Berhasil Dimasukkan");
    } catch (e) {
      print(e);
      return Left(e.toString());
    }
  }

  @override
  Future<Either<String, List<OrderData>>> getOrderDataByStatus(
      String adminId, String status) async {
    try {
      final result =
          await orderDataSource.getOrderDataByStatus(adminId, status);
      return Right(result);
    } catch (e) {
      return Left(e.toString());
    }
  }
}
