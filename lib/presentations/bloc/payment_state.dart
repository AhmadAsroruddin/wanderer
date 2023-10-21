part of 'payment_bloc.dart';

class PaymentState extends Equatable {
  PaymentState();

  @override
  List<Object> get props => [];
}

class PaymentLoading extends PaymentState {}

class PaymentFailed extends PaymentState {
  final String error;
  PaymentFailed({required this.error});

  @override
  List<Object> get props => [error];
}

class PaymentUrls extends PaymentState {
  final PaymentUrl url;
  PaymentUrls({required this.url});

  @override
  List<Object> get props => [url];
}
