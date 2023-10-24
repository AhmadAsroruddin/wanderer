import 'package:dartz/dartz.dart';
import 'package:wanderer/domain/entities/order.dart';
import 'package:wanderer/domain/entities/transactionStatus.dart';

import '../entities/paymentUrl.dart';

abstract class PaymentRepos {
  Future<Either<String, PaymentUrl>> getUrl(double price, OrderData order);
  Future<TransactionStatus> getResponse(String orderId);
}
