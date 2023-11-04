part of 'admin_data_bloc.dart';

class AdminDataState extends Equatable {
  const AdminDataState();

  @override
  List<Object> get props => [];
}

class AdminDataLoading extends AdminDataState {}

class AdminDataInitial extends AdminDataState {}

class AdminDataFailed extends AdminDataState {
  final String error;
  const AdminDataFailed({required this.error});

  @override
  List<Object> get props => [error];
}

class AdminDataSuccess extends AdminDataState {
  final Admin data;
  const AdminDataSuccess({required this.data});

  @override
  List<Object> get props => [data];
}

class TypeDataSuccess extends AdminDataState {
  final List<Tipe> tipe;
  const TypeDataSuccess({required this.tipe});

  @override
  List<Object> get props => [tipe];
}

class AdminDataCampervan extends AdminDataState {
  final List<Admin> campervan;
  const AdminDataCampervan({required this.campervan});

  @override
  List<Object> get props => [campervan];
}
