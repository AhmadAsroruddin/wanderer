part of 'order_bloc.dart';

class OrderState extends Equatable {
  const OrderState();

  @override
  List<Object> get props => [];
}

class OrderLoading extends OrderState {}

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

class OrderDataObtained extends OrderState {
  final List<OrderData> list;

  const OrderDataObtained({required this.list});

  @override
  List<Object> get props => [list];
}
