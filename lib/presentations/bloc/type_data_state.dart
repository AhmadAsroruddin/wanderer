part of 'type_bloc.dart';

class TypeDataState extends Equatable {
  const TypeDataState();

  @override
  List<Object> get props => [];
}

class TypeDataLoading extends TypeDataState {}

class TypeDataFailed extends TypeDataState {
  final String error;
  const TypeDataFailed({required this.error});

  @override
  List<Object> get props => [error];
}

class TypeDataSuccess extends TypeDataState {
  final List<Tipe> tipe;
  const TypeDataSuccess({required this.tipe});

  @override
  List<Object> get props => [tipe];
}
