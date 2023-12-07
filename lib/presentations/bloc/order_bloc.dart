import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:wanderer/domain/entities/order.dart';
import 'package:wanderer/domain/usecase/getOrderDataByStatus.dart';
import 'package:wanderer/domain/usecase/requestOrder.dart';
import 'package:wanderer/domain/usecase/updateStatusOrder.dart';

part 'order_state.dart';

class OrderCubit extends Cubit<OrderState> {
  final RequestOrder requestOrder;
  final GetOrderDataByStatus getOrderDataByStatusUseCase;
  final UpdateStatusOrder updateStatusOrder;

  OrderCubit(this.requestOrder, this.getOrderDataByStatusUseCase,
      this.updateStatusOrder)
      : super(OrderInitial());

  Future<void> makeOrder(OrderData orderData) async {
    emit(OrderLoading());
    final result = await requestOrder.execute(orderData);

    result.fold(
      (l) => emit(OrderFailed(error: l)),
      (r) => emit(OrderSuccess(message: r)),
    );
  }

  Future<void> getOrderDataByStatus(
      String adminId, String status, bool isUser) async {
    emit(OrderLoading());
    final result =
        await getOrderDataByStatusUseCase.execute(adminId, status, isUser);

    result.fold(
      (l) => emit(OrderFailed(error: l)),
      (r) {
        if (status == "waiting") {
          emit(OrderDataWaitingPaymentObtained(list: r));
        } else if (status == "paid") {
          emit(OrderDataPaidObtained(list: r));
        } else if (status == "request") {
          emit(OrderDataRequestObtained(list: r));
        } else if (status == "done") {
          emit(OrderDataDoneObtained(list: r));
        }
      },
    );
  }

  Future<void> updateStatus(String id, String adminId, String status) async {
    await updateStatusOrder.execute(id, adminId, status);
  }
}
