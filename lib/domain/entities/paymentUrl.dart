import 'package:equatable/equatable.dart';

class PaymentUrl extends Equatable {
  const PaymentUrl({required this.token, required this.redirectUrl});

  final String token;
  final String redirectUrl;

  @override
  List<Object> get props => [token, redirectUrl];
}
