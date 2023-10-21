import 'package:dartz/dartz.dart';
import 'package:wanderer/domain/entities/order.dart';
import 'package:wanderer/domain/entities/paymentUrl.dart';
import 'package:wanderer/domain/repositories/payment_repository.dart';

class GetPaymentUrl {
  PaymentRepos repos;
  GetPaymentUrl({required this.repos});

  Future<Either<String, PaymentUrl>> execute(
      double price, OrderData order) async {
    return repos.getUrl(price, order);
  }
}
