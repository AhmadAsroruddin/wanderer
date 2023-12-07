part of 'payout_bloc.dart';

class PayoutState extends Equatable {
  const PayoutState();
  @override
  List<Object> get props => [];
}

class PayoutInitial extends PayoutState {}

class PayOutLoading extends PayoutState {}

class BeneficariesFailed extends PayoutState {
  final String error;
  const BeneficariesFailed({required this.error});

  @override
  List<Object> get props => [error];
}

class BeneficariesSuccess extends PayoutState {
  final String message;
  const BeneficariesSuccess({required this.message});

  @override
  List<Object> get props => [message];
}

class PayoutCreteedSuccess extends PayoutState {
  final String id;
  const PayoutCreteedSuccess({required this.id});

  @override
  List<Object> get props => [id];
}

class ApproveSuccess extends PayoutState {
  final String message;
  const ApproveSuccess({required this.message});

  @override
  List<Object> get props => [message];
}
