part of 'order_bloc.dart';

class OrderState extends Equatable {
  const OrderState();

  @override
  List<Object> get props => [];
}

class OrderLoading extends OrderState {}

class OrderInitial extends OrderState {}

class OrderFailed extends OrderState {
  final String error;
  const OrderFailed({required this.error});

  @override
  List<Object> get props => [error];
}

class OrderSuccess extends OrderState {
  final String message;

  const OrderSuccess({required this.message});

  @override
  List<Object> get props => [message];
}

class OrderDataWaitingPaymentObtained extends OrderState {
  final List<OrderData> list;

  const OrderDataWaitingPaymentObtained({required this.list});

  @override
  List<Object> get props => [list];
}

class OrderDataPaidObtained extends OrderState {
  final List<OrderData> list;

  const OrderDataPaidObtained({required this.list});

  @override
  List<Object> get props => [list];
}

class OrderDataRequestObtained extends OrderState {
  final List<OrderData> list;

  const OrderDataRequestObtained({required this.list});

  @override
  List<Object> get props => [list];
}
