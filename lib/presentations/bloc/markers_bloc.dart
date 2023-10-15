import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:image_picker/image_picker.dart';
import 'package:wanderer/domain/usecase/addMarker.dart';
import 'package:wanderer/domain/usecase/getAllMarkers.dart';

import '../../domain/entities/marker.dart';

part 'markers_state.dart';

class MarkersCubit extends Cubit<MarkersState> {
  final AddMarkers _addMarkers;
  final GetAllMarkers _getAllMarkers;

  MarkersCubit(this._addMarkers, this._getAllMarkers) : super(MarkersInitial());

  Future<void> addMarkers(
      Markers markers, List<XFile> images, bool adminCheck) async {
    emit(MarkersLoading());

    final result = await _addMarkers.execute(markers, images, adminCheck);

    result.fold(
      (l) => emit(MarkersFailed(error: l)),
      (r) => emit(MarkersSuccess(message: r, isClicked: false)),
    );
  }

  Future<List<Markers>> getAllMarkers() async {
    final result = await _getAllMarkers.execute();

    return result;
  }

  void getMarker(bool isClicked, Markers marker) {
    emit(GetOneMarker(
        marker: marker, isClicked: isClicked)); // Toggle nilai boolean
  }
}
