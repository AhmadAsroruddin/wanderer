part of 'markers_bloc.dart';

abstract class MarkersState extends Equatable {
  const MarkersState();

  @override
  List<Object> get props => [];
}

class MarkersInitial extends MarkersState {}

class MarkersLoading extends MarkersState {}

class MarkersFailed extends MarkersState {
  final String error;
  const MarkersFailed({required this.error});

  @override
  List<Object> get props => [error];
}

class MarkersSuccess extends MarkersState {
  final String message;
  const MarkersSuccess({required this.message});

  @override
  List<Object> get props => [message];
}
