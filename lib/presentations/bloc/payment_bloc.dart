import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:wanderer/domain/entities/transactionStatus.dart';
import 'package:wanderer/domain/usecase/getPaymentUrl.dart';
import 'package:wanderer/domain/usecase/getTransactionResponse.dart';

import '../../domain/entities/order.dart';
import '../../domain/entities/paymentUrl.dart';

part 'payment_state.dart';

class PaymentCubit extends Cubit<PaymentState> {
  GetPaymentUrl getPaymentUrl;
  GetTransactionResponse getTransactionResponse;

  PaymentCubit(this.getPaymentUrl, this.getTransactionResponse)
      : super(PaymentLoading());

  Future<void> getUrl(double price, OrderData order) async {
    final result = await getPaymentUrl.execute(price, order);

    result.fold(
      (l) => emit(PaymentFailed(error: l)),
      (r) => emit(PaymentUrls(url: r)),
    );
  }

  Future<TransactionStatus> getResponse(String orderId) async {
    final result = await getTransactionResponse.execute(orderId);

    return result;
  }
}
