import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:wanderer/domain/entities/order.dart';
import 'package:wanderer/domain/usecase/getOrderDataByStatus.dart';
import 'package:wanderer/domain/usecase/requestOrder.dart';

part 'order_state.dart';

class OrderCubit extends Cubit<OrderState> {
  final RequestOrder requestOrder;
  final GetOrderDataByStatus getOrderDataByStatusUseCase;

  OrderCubit(this.requestOrder, this.getOrderDataByStatusUseCase)
      : super(OrderLoading());

  Future<void> makeOrder(OrderData orderData) async {
    final result = await requestOrder.execute(orderData);

    result.fold(
      (l) => emit(OrderFailed(error: l)),
      (r) => emit(OrderSuccess(message: r)),
    );
  }

  Future<void> getOrderDataByStatus(String adminId, String status) async {
    final result = await getOrderDataByStatusUseCase.execute(adminId, status);

    result.fold(
      (l) => emit(OrderFailed(error: l)),
      (r) => emit(OrderDataObtained(list: r)),
    );
  }
}
