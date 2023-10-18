part of 'user_bloc.dart';

class UserState extends Equatable {
  UserState();

  @override
  List<Object> get props => [];
}

class UserLoading extends UserState {}

class UserFailed extends UserState {
  final String error;

  UserFailed({required this.error});

  @override
  List<Object> get props => [error];
}

class UserSuccess extends UserState {
  final Users user;
  UserSuccess({required this.user});
  @override
  List<Object> get props => [user];
}
