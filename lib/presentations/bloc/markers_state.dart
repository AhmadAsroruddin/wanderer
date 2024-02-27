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
  final bool isClicked;

  const MarkersSuccess({required this.message, required this.isClicked});

  @override
  List<Object> get props => [message, isClicked];
}

class GetAllMarkersDone extends MarkersState {
  final List<Markers> data;

  const GetAllMarkersDone({required this.data});

  @override
  List<Object> get props => [data];
}

class GetOneMarker extends MarkersState {
  final Markers marker;
  final bool isClicked;

  const GetOneMarker({required this.marker, required this.isClicked});

  @override
  List<Object> get props => [marker, isClicked];
}

class GetMarkerForFavorite extends MarkersState {
  final Markers marker;

  const GetMarkerForFavorite({required this.marker});

  @override
  List<Object> get props => [marker];
}

class SearchMarkers extends MarkersState {
  final List<Markers> marker;

  const SearchMarkers({required this.marker});

  @override
  List<Object> get props => [marker];
}

class GetUserMarkerSuccess extends MarkersState {
  final List<MarkerModel> markers;

  const GetUserMarkerSuccess({required this.markers});

  @override
  List<Object> get props => [markers];
}
