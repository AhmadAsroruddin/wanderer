import 'package:wanderer/domain/entities/transactionStatus.dart';
import 'package:wanderer/domain/repositories/payment_repository.dart';

class GetTransactionResponse {
  final PaymentRepos paymentRepos;

  GetTransactionResponse({required this.paymentRepos});

  Future<TransactionStatus> execute(String orderId) {
    return paymentRepos.getResponse(orderId);
  }
}
