part of 'user_bloc.dart';

class UserState extends Equatable {
  const UserState();

  @override
  List<Object> get props => [];
}

class UserLoading extends UserState {}

class UserFailed extends UserState {
  final String error;

  const UserFailed({required this.error});

  @override
  List<Object> get props => [error];
}

class UserSuccess extends UserState {
  final Users user;
  const UserSuccess({required this.user});
  @override
  List<Object> get props => [user];
}

class UserDeleteSuccess extends UserState {}
