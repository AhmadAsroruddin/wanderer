part of 'auth_bloc.dart';

abstract class AuthState extends Equatable {
  const AuthState();

  @override
  List<Object> get props => [];
}

class AuthInitial extends AuthState {}

class AuthLoading extends AuthState {}

class AuthError extends AuthState {
  final String error;

  const AuthError({required this.error});

  @override
  List<Object> get props => [error];
}

class AuthLogin extends AuthState {
  final String message;

  const AuthLogin({required this.message});

  @override
  List<Object> get props => [message];
}

class AuthData extends AuthState {
  final String message;

  const AuthData({required this.message});

  @override
  List<Object> get props => [message];
}

class ResetSended extends AuthState {
  final String message;

  const ResetSended({required this.message});

  @override
  List<Object> get props => [message];
}
