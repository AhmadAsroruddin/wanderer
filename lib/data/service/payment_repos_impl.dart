import 'package:dartz/dartz.dart';
import 'package:wanderer/data/datasource/payment_datasource.dart';
import 'package:wanderer/domain/entities/order.dart';
import 'package:wanderer/domain/entities/paymentUrl.dart';
import 'package:wanderer/domain/repositories/payment_repository.dart';

class PaymentReposImpl implements PaymentRepos {
  PaymentDataSource paymentDataSource;

  PaymentReposImpl({required this.paymentDataSource});

  @override
  Future<Either<String, PaymentUrl>> getUrl(
      double price, OrderData order) async {
    try {
      final response = await paymentDataSource.getUrl(price, order);
      return Right(response);
    } catch (e) {
      print("URL ERROR : $e");
      return Left(e.toString());
    }
  }
}
